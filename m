From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ALSA: opl4: don't opencode IS_REACHABLE()
Date: Sat, 12 Nov 2016 09:33:45 +0100
Message-ID: <1478939625-1625-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/drivers/opl4/opl4_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index 89c7aa0..240656e 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -153,7 +153,7 @@ static int snd_opl4_detect(struct snd_opl4 *opl4)
 	return 0;
 }
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 static void snd_opl4_seq_dev_free(struct snd_seq_device *seq_dev)
 {
 	struct snd_opl4 *opl4 = seq_dev->private_data;
@@ -249,7 +249,7 @@ int snd_opl4_create(struct snd_card *card,
 	snd_opl4_create_mixer(opl4);
 	snd_opl4_create_proc(opl4);
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 	opl4->seq_client = -1;
 	if (opl4->hardware < OPL3_HW_OPL4_ML)
 		snd_opl4_create_seq_dev(opl4, seq_device);
-- 
2.7.4
