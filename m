From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: Intel: use platform_data for machine
	drivers
Date: Fri, 16 Nov 2018 18:47:06 -0600
Message-ID: <20181117004706.15911-4-pierre-louis.bossart@linux.intel.com>
References: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE912679C0
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 01:47:18 +0100 (CET)
In-Reply-To: <20181117004706.15911-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

For some reason we have different mechanisms for passing data to
machine drivers. Use the solution used by Atom/SST and SOF instead of
using drv_data as done by Skylake.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        |  2 +-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c |  2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c        |  2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     |  2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       |  2 +-
 sound/soc/intel/skylake/skl.c                       | 13 ++++++++++---
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index c2a96940f9f2..d71475200b08 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -984,7 +984,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
-	mach = dev_get_drvdata(&pdev->dev);
+	mach = (&pdev->dev)->platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index d7df307b406f..7044d8c2b187 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -659,7 +659,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&kabylake_audio_card, ctx);
 
-	mach = dev_get_drvdata(&pdev->dev);
+	mach = (&pdev->dev)->platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 15c502d6774d..b9a21e64ead2 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -146,7 +146,7 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	mach = dev_get_drvdata(&pdev->dev);
+	mach = (&pdev->dev)->platform_data;
 	if (!mach)
 		return -EINVAL;
 
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 931890f9aa74..0922106bd323 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -652,7 +652,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	mach = dev_get_drvdata(&pdev->dev);
+	mach = (&pdev->dev)->platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 657c650766fc..8433c521d39f 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -705,7 +705,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
-	mach = dev_get_drvdata(&pdev->dev);
+	mach = (&pdev->dev)->platform_data;
 	if (mach)
 		dmic_constraints = mach->mach_params.dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index c05618c6392f..00a754a8e216 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -534,6 +534,16 @@ static int skl_machine_device_register(struct skl *skl)
 		return -EIO;
 	}
 
+	mach->mach_params.platform = dev_name(bus->dev);
+	mach->mach_params.codec_mask = bus->codec_mask;
+
+	ret = platform_device_add_data(pdev, (const void *)mach, sizeof(*mach));
+	if (ret) {
+		dev_err(bus->dev, "failed to add machine device platform data\n");
+		platform_device_put(pdev);
+		return ret;
+	}
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 		dev_err(bus->dev, "failed to add machine device\n");
@@ -541,9 +551,6 @@ static int skl_machine_device_register(struct skl *skl)
 		return -EIO;
 	}
 
-	mach->mach_params.platform = dev_name(bus->dev);
-	mach->mach_params.codec_mask = bus->codec_mask;
-	dev_set_drvdata(&pdev->dev, mach);
 
 	skl->i2s_dev = pdev;
 
-- 
2.17.1
