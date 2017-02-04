From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxt: add channel map support in
	rt298 machine" to the asoc tree
Date: Sat, 04 Feb 2017 13:12:53 +0100
Message-ID: <E1cZzD3-0004TY-Hz@finisterre>
References: <1484589477-7630-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 472C7266C43
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 13:13:04 +0100 (CET)
In-Reply-To: <1484589477-7630-6-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxt: add channel map support in rt298 machine

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

>From 51e0f3c825f0f800479aa6fd2066587b425d1010 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 24 Jan 2017 21:49:06 +0530
Subject: [PATCH] ASoC: Intel: bxt: add channel map support in rt298 machine

HDMI registers channel map controls per pcm. As PCMs are not
registered during dai_link init callback, store the pcm ids and
codec DAIs during this init callback.

Register for late probe and call the jack_init API which registers
channel map in the late probe callback handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 52 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1309405b3808..bc9ee0975073 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -26,8 +26,18 @@
 #include "../../codecs/hdac_hdmi.h"
 #include "../../codecs/rt298.h"
 
-static struct snd_soc_jack broxton_headset;
 /* Headset jack detection DAPM pins */
+static struct snd_soc_jack broxton_headset;
+
+struct bxt_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct bxt_rt286_private {
+	struct list_head hdmi_pcm_list;
+};
 
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
@@ -139,9 +149,20 @@ static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int broxton_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct bxt_hdmi_pcm *pcm;
 
-	return hdac_hdmi_jack_init(dai, BXT_DPCM_AUDIO_HDMI1_PB + dai->id);
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = BXT_DPCM_AUDIO_HDMI1_PB + dai->id;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 static int broxton_ssp5_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -432,6 +453,22 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	},
 };
 
+static int bxt_card_late_probe(struct snd_soc_card *card)
+{
+	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(card);
+	struct bxt_hdmi_pcm *pcm;
+	int err;
+
+	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+
 /* broxton audio machine driver for SPT + RT298S */
 static struct snd_soc_card broxton_rt298 = {
 	.name = "broxton-rt298",
@@ -445,11 +482,22 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.late_probe = bxt_card_late_probe,
+
 };
 
 static int broxton_audio_probe(struct platform_device *pdev)
 {
+	struct bxt_rt286_private *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
 	broxton_rt298.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&broxton_rt298, ctx);
 
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
 }
-- 
2.11.0
