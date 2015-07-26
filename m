From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks: add support for AudioFire2
	quirk
Date: Sun, 26 Jul 2015 16:10:09 +0900
Message-ID: <1437894609-26681-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A215B2605CB
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 09:10:18 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Fireworks uses TSB43CB43(IceLynx-Micro) as its IEC 61883-1/6 interface.
This chip includes ARM7 core, and loads and runs program. The firmware
is stored in on-board memory and loaded every powering-on.

Echo Audio ships several versions of firmwares for each model. These
firmwares have each quirk and the quirk changes a sequence of packets.

AudioFire2 has a quirk to transfer a first packet with non-zero in
its dbc field. This causes ALSA Fireworks driver to detect discontinuity.
As long as I investigated, firmware 5.7, 5.7.6 and 5.8 have this quirk.

This commit adds a support for the quirk to handle AudioFire2 packets.
For safe, CIP_SKIP_INIT_DBC_CHECK is applied to all versions of
AudioFire2's firmwares.

02 00050002 90ffffff <-
42 0005000a 90013000
42 00050012 90014400
42 0005001a 90015800
02 0005001a 90ffffff
42 00050022 90019000
42 0005002a 9001a400
42 00050032 9001b800
02 00050032 90ffffff
42 0005003a 9001d000
42 00050042 9001e400
42 0005004a 9001f800
02 0005004a 90ffffff

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c        | 2 ++
 sound/firewire/fireworks/fireworks.h        | 1 +
 sound/firewire/fireworks/fireworks_stream.c | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 2682e7e..c670db4 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -248,6 +248,8 @@ efw_probe(struct fw_unit *unit,
 	err = get_hardware_info(efw);
 	if (err < 0)
 		goto error;
+	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_2)
+		efw->is_af2 = true;
 	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_9)
 		efw->is_af9 = true;
 
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4f0201a..c33252b 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -70,6 +70,7 @@ struct snd_efw {
 	bool resp_addr_changable;
 
 	/* for quirks */
+	bool is_af2;
 	bool is_af9;
 	u32 firmware_version;
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index c55db1b..a0762dd 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -172,6 +172,9 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	efw->tx_stream.flags |= CIP_DBC_IS_END_EVENT;
 	/* Fireworks reset dbc at bus reset. */
 	efw->tx_stream.flags |= CIP_SKIP_DBC_ZERO_CHECK;
+	/* AudioFire2 starts packets with non-zero dbc. */
+	if (efw->is_af2)
+		efw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
 	/* AudioFire9 always reports wrong dbs. */
 	if (efw->is_af9)
 		efw->tx_stream.flags |= CIP_WRONG_DBS;
-- 
2.1.4
