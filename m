From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 03/10] ASoC: Intel: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:19:07 -0700
Message-ID: <63f080c9ef444ef32486914be97ed5f8c8c55d9f.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre-louis.bossart@linux.intel.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---

Changes in v2:
-add missed occurrences.

 sound/soc/intel/boards/bytcht_da7213.c       | 6 ++----
 sound/soc/intel/boards/bytcht_es8316.c       | 6 ++----
 sound/soc/intel/boards/bytcht_nocodec.c      | 6 ++----
 sound/soc/intel/boards/bytcr_rt5640.c        | 7 ++-----
 sound/soc/intel/boards/bytcr_rt5651.c        | 7 ++-----
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 ++----
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 6 ++----
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 6 ++----
 8 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 18873e23f404..f43ced5288af 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -260,12 +260,10 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	}
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev,
 			"snd_soc_register_card failed %d\n", ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, card);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 52635462dac6..c3213f320869 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -278,11 +278,9 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &byt_cht_es8316_card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed %d\n", ret);
-		return ret;
-	}
-	platform_set_drvdata(pdev, &byt_cht_es8316_card);
+
 	return ret;
 }
 
diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 1dd9441806fa..b9adde0e2a9f 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -185,12 +185,10 @@ static int snd_bytcht_nocodec_mc_probe(struct platform_device *pdev)
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &bytcht_nocodec_card);
 
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, &bytcht_nocodec_card);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4a76b099a508..9a5775c89393 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -912,13 +912,10 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
-
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, &byt_rt5640_card);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4a3516b38c2c..c50a3834d0eb 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -304,13 +304,10 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	byt_rt5651_card.dev = &pdev->dev;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
-
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, &byt_rt5651_card);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 20755ecc7f9e..62d45e0badc5 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -295,12 +295,10 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev,
 			"snd_soc_register_card failed %d\n", ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, &snd_soc_card_cht);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 5bcde01d15e6..511d4d9b24bf 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -694,12 +694,10 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev,
 			"snd_soc_register_card failed %d\n", ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, card);
+
 	return ret_val;
 }
 
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index bc2a52de06a3..656cef7da054 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -443,12 +443,10 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	/* register the soc card */
 	snd_soc_card_cht.dev = &pdev->dev;
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
-	if (ret_val) {
+	if (ret_val)
 		dev_err(&pdev->dev,
 			"snd_soc_register_card failed %d\n", ret_val);
-		return ret_val;
-	}
-	platform_set_drvdata(pdev, &snd_soc_card_cht);
+
 	return ret_val;
 }
 
-- 
2.14.1
