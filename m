From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Enable pin and converter in
	prepare" to the asoc tree
Date: Thu, 19 Jan 2017 18:03:47 +0000
Message-ID: <E1cUH3r-0004w0-4R@debutante>
References: <1483341277-14475-10-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57C862678D4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 19:04:01 +0100 (CET)
In-Reply-To: <1483341277-14475-10-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Sachin Mokashi <sachinx.mokashi@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Enable pin and converter in prepare

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1de777fed54dfa93e166a3c934c5846920b86f0c Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 10 Jan 2017 17:57:48 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Enable pin and converter in prepare

Instead of enabling pin and cvt in pcm_open(), need to restore pin and
cvt state after system resume to restart the playback which is
paused/stopped before system suspend.
So enable pin and cvt in playback_prepare and call prepare when trigger
cmd is paused/started and resume to reconfigure pin and cvt.

Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c602c4960924..1da4405ee435 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -114,6 +114,12 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
+static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
+			struct hdac_hdmi_dai_pin_map *dai_map);
+
+static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
+			struct hdac_hdmi_dai_pin_map *dai_map);
+
 static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 						int pcm_idx)
 {
@@ -411,6 +417,10 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
+	hdac_hdmi_enable_cvt(hdac, dai_map);
+	ret = hdac_hdmi_enable_pin(hdac, dai_map);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&pin->lock);
 	pin->channels = substream->runtime->channels;
 
@@ -464,12 +474,7 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
 	struct hdac_ext_dma_params *dd;
-	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
-
-	dai_map = &hdmi->dai_map[dai->id];
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 
@@ -622,11 +627,6 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map->pin = pin;
 
-	hdac_hdmi_enable_cvt(hdac, dai_map);
-	ret = hdac_hdmi_enable_pin(hdac, dai_map);
-	if (ret < 0)
-		return ret;
-
 	ret = hdac_hdmi_eld_limit_formats(substream->runtime,
 				pin->eld.eld_buffer);
 	if (ret < 0)
@@ -639,18 +639,15 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 static int hdac_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_hdmi_dai_pin_map *dai_map;
-	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	int ret;
-
-	dai_map = &hdmi->dai_map[dai->id];
-	if (cmd == SNDRV_PCM_TRIGGER_RESUME) {
-		ret = hdac_hdmi_enable_pin(hdac, dai_map);
-		if (ret < 0)
-			return ret;
 
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		return hdac_hdmi_playback_prepare(substream, dai);
+
+	default:
+		return 0;
 	}
 
 	return 0;
-- 
2.11.0
