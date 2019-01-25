From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/15] ASoC: Intel: bytcht_es8316: platform
	name fixup support
Date: Fri, 25 Jan 2019 14:35:02 -0600
Message-ID: <20190125203509.22994-9-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 44056267974
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:20 +0100 (CET)
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
 sound/soc/intel/boards/bytcht_es8316.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index fa9c4cf97686..26d8c6ad4d95 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -441,6 +441,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
 	const char *i2c_name = NULL;
 	struct device *codec_dev;
 	int dai_index = 0;
@@ -469,6 +470,14 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		byt_cht_es8316_dais[dai_index].codec_name = codec_name;
 	}
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_es8316_card,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	/* Check for BYTCR or other platform and setup quirks */
 	if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
-- 
2.17.1
