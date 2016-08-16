From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/3] ASoC: Intel: bytcr_rt5640: quirk for Acer
	Aspire SWS-012
Date: Tue, 16 Aug 2016 18:28:22 -0500
Message-ID: <1471390103-915-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471390103-915-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 651B926685D
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 01:28:35 +0200 (CEST)
In-Reply-To: <1471390103-915-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, sfr@canb.auug.org.au, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Baytrail-CR platform needing SSP0-AIF1 routing
Also fix SSP0 while we are at it.

Suggested-by: Andrei Lavreniyuk <andy.lavr@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 2548815..bff77a1 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -378,6 +378,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 						BYT_RT5640_MCLK_EN |
 						BYT_RT5640_SSP0_AIF1),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
+						 BYT_RT5640_MCLK_EN |
+						 BYT_RT5640_SSP0_AIF1),
+
+	},
 	{}
 };
 
@@ -527,7 +538,7 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
 		(byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
 
-		/* set SSP2 to 16-bit */
+		/* set SSP0 to 16-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 
 		/*
-- 
2.7.4
