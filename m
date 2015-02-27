From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/9] ALSA: hda - Don't assume non-NULL PCM ops
Date: Fri, 27 Feb 2015 23:55:40 +0100
Message-ID: <1425077744-4553-6-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAE7265176
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 65B5DABF4
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
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

The PCM ops might be set NULL, or cleared to NULL when the driver is
unbound.  Give a proper NULL check at each place to be more robust.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      |  9 +++++++--
 sound/pci/hda/hda_controller.c | 30 +++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 6a5fb9bf9441..a8082677373e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4074,7 +4074,11 @@ int snd_hda_codec_prepare(struct hda_codec *codec,
 {
 	int ret;
 	mutex_lock(&codec->bus->prepare_mutex);
-	ret = hinfo->ops.prepare(hinfo, codec, stream, format, substream);
+	if (hinfo->ops.prepare)
+		ret = hinfo->ops.prepare(hinfo, codec, stream, format,
+					 substream);
+	else
+		ret = -ENODEV;
 	if (ret >= 0)
 		purify_inactive_streams(codec);
 	mutex_unlock(&codec->bus->prepare_mutex);
@@ -4095,7 +4099,8 @@ void snd_hda_codec_cleanup(struct hda_codec *codec,
 			   struct snd_pcm_substream *substream)
 {
 	mutex_lock(&codec->bus->prepare_mutex);
-	hinfo->ops.cleanup(hinfo, codec, substream);
+	if (hinfo->ops.cleanup)
+		hinfo->ops.cleanup(hinfo, codec, substream);
 	mutex_unlock(&codec->bus->prepare_mutex);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_cleanup);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index be02bca6f7e6..ad85f9bfaf57 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -416,7 +416,8 @@ static int azx_pcm_close(struct snd_pcm_substream *substream)
 	azx_dev->running = 0;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	azx_release_device(azx_dev);
-	hinfo->ops.close(hinfo, apcm->codec, substream);
+	if (hinfo->ops.close)
+		hinfo->ops.close(hinfo, apcm->codec, substream);
 	snd_hda_power_down(apcm->codec);
 	mutex_unlock(&chip->open_mutex);
 	return 0;
@@ -808,8 +809,8 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&chip->open_mutex);
 	azx_dev = azx_assign_device(chip, substream);
 	if (azx_dev == NULL) {
-		mutex_unlock(&chip->open_mutex);
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 	runtime->hw = azx_pcm_hw;
 	runtime->hw.channels_min = hinfo->channels_min;
@@ -844,12 +845,13 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   buff_step);
 	snd_hda_power_up(apcm->codec);
-	err = hinfo->ops.open(hinfo, apcm->codec, substream);
+	if (hinfo->ops.open)
+		err = hinfo->ops.open(hinfo, apcm->codec, substream);
+	else
+		err = -ENODEV;
 	if (err < 0) {
 		azx_release_device(azx_dev);
-		snd_hda_power_down(apcm->codec);
-		mutex_unlock(&chip->open_mutex);
-		return err;
+		goto powerdown;
 	}
 	snd_pcm_limit_hw_rates(runtime);
 	/* sanity check */
@@ -858,10 +860,10 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	    snd_BUG_ON(!runtime->hw.formats) ||
 	    snd_BUG_ON(!runtime->hw.rates)) {
 		azx_release_device(azx_dev);
-		hinfo->ops.close(hinfo, apcm->codec, substream);
-		snd_hda_power_down(apcm->codec);
-		mutex_unlock(&chip->open_mutex);
-		return -EINVAL;
+		if (hinfo->ops.close)
+			hinfo->ops.close(hinfo, apcm->codec, substream);
+		err = -EINVAL;
+		goto powerdown;
 	}
 
 	/* disable LINK_ATIME timestamps for capture streams
@@ -880,6 +882,12 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_set_sync(substream);
 	mutex_unlock(&chip->open_mutex);
 	return 0;
+
+ powerdown:
+	snd_hda_power_down(apcm->codec);
+ unlock:
+	mutex_unlock(&chip->open_mutex);
+	return err;
 }
 
 static int azx_pcm_mmap(struct snd_pcm_substream *substream,
-- 
2.3.0
