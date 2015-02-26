From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: hda - Clear pcm pointer assigned
	to hda_pcm at device removal
Date: Thu, 26 Feb 2015 18:00:25 +0100
Message-ID: <1424970025-8082-11-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E284C264F19
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 96D42ADD7
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We leave the pcm field of struct hda_pcm at removal of each device, so
far.  This hasn't been a problem since unbinding the codec driver
isn't supposed to happen and another route via snd_hda_codec_reset()
clears all the once.  However, for a proper unbind implementation, we
need to care about it.

This patch does the thing above properly:

- Include struct hda_pcm pointer instead of struct hda_pcm_stream
  pointers in struct azx_dev.  This allows us to point the hda_pcm
  object at dev_free callback.

- Introduce to_hda_pcm_stream() macro for better readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 22 +++++++++++++++-------
 sound/pci/hda/hda_controller.h |  2 +-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 789ca66c3094..1695f0e2bd9d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -258,11 +258,18 @@ static void azx_timecounter_init(struct snd_pcm_substream *substream,
 		tc->cycle_last = last;
 }
 
+static inline struct hda_pcm_stream *
+to_hda_pcm_stream(struct snd_pcm_substream *substream)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	return &apcm->info->stream[substream->stream];
+}
+
 static u64 azx_adjust_codec_delay(struct snd_pcm_substream *substream,
 				u64 nsec)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	u64 codec_frames, codec_nsecs;
 
 	if (!hinfo->ops.get_delay)
@@ -398,7 +405,7 @@ static int azx_setup_periods(struct azx *chip,
 static int azx_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	unsigned long flags;
@@ -440,7 +447,7 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct azx *chip = apcm->chip;
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	int err;
 
 	/* reset BDL address */
@@ -467,7 +474,7 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int bufsize, period_bytes, format_val, stream_tag;
 	int err;
@@ -707,7 +714,7 @@ unsigned int azx_get_position(struct azx *chip,
 
 	if (substream->runtime) {
 		struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-		struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
+		struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 
 		if (chip->get_delay[stream])
 			delay += chip->get_delay[stream](chip, azx_dev, pos);
@@ -790,7 +797,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 static int azx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
-	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -904,6 +911,7 @@ static void azx_pcm_free(struct snd_pcm *pcm)
 	struct azx_pcm *apcm = pcm->private_data;
 	if (apcm) {
 		list_del(&apcm->list);
+		apcm->info->pcm = NULL;
 		kfree(apcm);
 	}
 }
@@ -940,6 +948,7 @@ static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 	apcm->chip = chip;
 	apcm->pcm = pcm;
 	apcm->codec = codec;
+	apcm->info = cpcm;
 	pcm->private_data = apcm;
 	pcm->private_free = azx_pcm_free;
 	if (cpcm->pcm_type == HDA_PCM_TYPE_MODEM)
@@ -947,7 +956,6 @@ static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 	list_add_tail(&apcm->list, &chip->pcm_list);
 	cpcm->pcm = pcm;
 	for (s = 0; s < 2; s++) {
-		apcm->hinfo[s] = &cpcm->stream[s];
 		if (cpcm->stream[s].substreams)
 			snd_pcm_set_ops(pcm, s, &azx_pcm_ops);
 	}
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index e4f46a21698a..94c1a4719f7f 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -283,7 +283,7 @@ struct azx_pcm {
 	struct azx *chip;
 	struct snd_pcm *pcm;
 	struct hda_codec *codec;
-	struct hda_pcm_stream *hinfo[2];
+	struct hda_pcm *info;
 	struct list_head list;
 };
 
-- 
2.3.0
