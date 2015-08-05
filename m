From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: fireworks/firewire-lib: add support
	for recent firmware quirk
Date: Wed,  5 Aug 2015 09:21:05 +0900
Message-ID: <1438734065-5204-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1438734065-5204-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 803192659FE
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 02:21:15 +0200 (CEST)
In-Reply-To: <1438734065-5204-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: johannes.oertel@uni-due.de, alsa-devel@alsa-project.org, harryhaaren@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Fireworks uses TSB43CB43(IceLynx-Micro) as its IEC 61883-1/6 interface.
This chip includes ARM7 core, and loads and runs program. The firmware
is stored in on-board memory and loaded every powering-on from it.

Echo Audio ships several versions of firmwares for each model. These
firmwares have each quirk and the quirk changes a sequence of packets.

As long as I investigated, AudioFire2/AudioFire4/AudioFirePre8 have a
quirk to transfer a first packet with 0x02 in its dbc field. This causes
ALSA Fireworks driver to detect discontinuity. In this case, firmware
version 5.7.0, 5.7.3 and 5.8.0 are used.

Payload  CIP      CIP
quadlets header1  header2
02       00050002 90ffffff <-
42       0005000a 90013000
42       00050012 90014400
42       0005001a 90015800
02       0005001a 90ffffff
42       00050022 90019000
42       0005002a 9001a400
42       00050032 9001b800
02       00050032 90ffffff
42       0005003a 9001d000
42       00050042 9001e400
42       0005004a 9001f800
02       0005004a 90ffffff
(AudioFire2 with firmware version 5.7.)

$ dmesg
snd-fireworks fw1.0: Detect discontinuity of CIP: 00 02

These models, AudioFire8 (since Jul 2009 ) and Gibson Robot Interface
Pack series uses the same ARM binary as their firmware. Thus, this
quirk may be observed among them.

This commit adds a new member for AMDTP structure. This member represents
the value of dbc field in a first AMDTP packet. Drivers can set it with
a preferred value according to model's quirk.

Tested-by: Johannes Oertei <johannes.oertel@uni-due.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 5 +++--
 sound/firewire/amdtp.h                      | 2 ++
 sound/firewire/fireworks/fireworks.c        | 8 ++++++++
 sound/firewire/fireworks/fireworks.h        | 1 +
 sound/firewire/fireworks/fireworks_stream.c | 9 +++++++++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 7bb988f..2a153d2 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -740,8 +740,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	    s->data_block_counter != UINT_MAX)
 		data_block_counter = s->data_block_counter;
 
-	if (((s->flags & CIP_SKIP_DBC_ZERO_CHECK) && data_block_counter == 0) ||
-	    (s->data_block_counter == UINT_MAX)) {
+	if (((s->flags & CIP_SKIP_DBC_ZERO_CHECK) &&
+	     data_block_counter == s->tx_first_dbc) ||
+	    s->data_block_counter == UINT_MAX) {
 		lost = false;
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 26b9093..b2cf9e7 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -157,6 +157,8 @@ struct amdtp_stream {
 
 	/* quirk: fixed interval of dbc between previos/current packets. */
 	unsigned int tx_dbc_interval;
+	/* quirk: indicate the value of dbc field in a first packet. */
+	unsigned int tx_first_dbc;
 
 	bool callbacked;
 	wait_queue_head_t callback_wait;
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 2682e7e..c94a432 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -248,8 +248,16 @@ efw_probe(struct fw_unit *unit,
 	err = get_hardware_info(efw);
 	if (err < 0)
 		goto error;
+	/* AudioFire8 (since 2009) and AudioFirePre8 */
 	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_9)
 		efw->is_af9 = true;
+	/* These models uses the same firmware. */
+	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_2 ||
+	    entry->model_id == MODEL_ECHO_AUDIOFIRE_4 ||
+	    entry->model_id == MODEL_ECHO_AUDIOFIRE_9 ||
+	    entry->model_id == MODEL_GIBSON_RIP ||
+	    entry->model_id == MODEL_GIBSON_GOLDTOP)
+		efw->is_fireworks3 = true;
 
 	snd_efw_proc_init(efw);
 
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4f0201a..084d414 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -71,6 +71,7 @@ struct snd_efw {
 
 	/* for quirks */
 	bool is_af9;
+	bool is_fireworks3;
 	u32 firmware_version;
 
 	unsigned int midi_in_ports;
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index c55db1b..7e353f1 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -172,6 +172,15 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	efw->tx_stream.flags |= CIP_DBC_IS_END_EVENT;
 	/* Fireworks reset dbc at bus reset. */
 	efw->tx_stream.flags |= CIP_SKIP_DBC_ZERO_CHECK;
+	/*
+	 * But Recent firmwares starts packets with non-zero dbc.
+	 * Driver version 5.7.6 installs firmware version 5.7.3.
+	 */
+	if (efw->is_fireworks3 &&
+	    (efw->firmware_version == 0x5070000 ||
+	     efw->firmware_version == 0x5070300 ||
+	     efw->firmware_version == 0x5080000))
+		efw->tx_stream.tx_first_dbc = 0x02;
 	/* AudioFire9 always reports wrong dbs. */
 	if (efw->is_af9)
 		efw->tx_stream.flags |= CIP_WRONG_DBS;
-- 
2.1.4
