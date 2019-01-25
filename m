From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 06/15] ASoC: Intel: bytcr_rt5651: platform name
	fixup support
Date: Fri, 25 Jan 2019 14:35:00 -0600
Message-ID: <20190125203509.22994-7-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FDB8267350
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:18 +0100 (CET)
In-Reply-To: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b618d984e2d5..784144cccf83 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -922,6 +922,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
 	struct device *codec_dev;
 	const char *i2c_name = NULL;
 	const char *hp_swapped;
@@ -1137,6 +1138,14 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)], hp_swapped);
 	byt_rt5651_card.long_name = byt_rt5651_long_name;
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(&byt_rt5651_card,
+							platform_name);
+	if (ret_val)
+		return ret_val;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
 
 	if (ret_val) {
-- 
2.17.1
