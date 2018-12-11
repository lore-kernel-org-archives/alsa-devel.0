From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] ALSA: fireface: share some registers for
	status of clock synchronization
Date: Tue, 11 Dec 2018 19:17:28 +0900
Message-ID: <20181211101735.13735-2-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B203267B8A
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:46 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id w6so6426010pgl.6
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:46 -0800 (PST)
In-Reply-To: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As long as investigating packet dumps from Fireface 400/800, status
registers for clock synchronization is common.

This commit moves some macros for them to header file.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 11 ++++-------
 sound/firewire/fireface/ff.h                |  5 +++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 654a50319198..20e0c0ec3a58 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -14,9 +14,6 @@
 #define FF400_ISOC_COMM_START	0x000080100508ull
 #define FF400_TX_PACKET_FORMAT	0x00008010050cull
 #define FF400_ISOC_COMM_STOP	0x000080100510ull
-#define FF400_SYNC_STATUS	0x0000801c0000ull
-#define FF400_FETCH_PCM_FRAMES	0x0000801c0000ull	/* For block request. */
-#define FF400_CLOCK_CONFIG	0x0000801c0004ull
 
 #define FF400_MIDI_HIGH_ADDR	0x0000801003f4ull
 #define FF400_MIDI_RX_PORT_0	0x000080180000ull
@@ -30,7 +27,7 @@ static int ff400_get_clock(struct snd_ff *ff, unsigned int *rate,
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 FF400_CLOCK_CONFIG, &reg, sizeof(reg), 0);
+				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return err;
 	data = le32_to_cpu(reg);
@@ -165,7 +162,7 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 	}
 
 	err = snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
-				 FF400_FETCH_PCM_FRAMES, reg,
+				 SND_FF_REG_FETCH_PCM_FRAMES, reg,
 				 sizeof(__le32) * 18, 0);
 	kfree(reg);
 	return err;
@@ -179,7 +176,7 @@ static void ff400_dump_sync_status(struct snd_ff *ff,
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 FF400_SYNC_STATUS, &reg, sizeof(reg), 0);
+				 SND_FF_REG_SYNC_STATUS, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return;
 
@@ -294,7 +291,7 @@ static void ff400_dump_clock_config(struct snd_ff *ff,
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
-				 FF400_CLOCK_CONFIG, &reg, sizeof(reg), 0);
+				 SND_FF_REG_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return;
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 64df44beb950..9122fb6ed8fd 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -37,6 +37,11 @@
 #define SND_FF_IN_MIDI_PORTS		2
 #define SND_FF_OUT_MIDI_PORTS		2
 
+#define SND_FF_REG_SYNC_STATUS		0x0000801c0000ull
+/* For block wriet request. */
+#define SND_FF_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
+#define SND_FF_REG_CLOCK_CONFIG		0x0000801c0004ull
+
 struct snd_ff_protocol;
 struct snd_ff_spec {
 	const char *const name;
-- 
2.19.1
