From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/10] ASoC: Intel: bytcr_rt5640: Unify
	BYTCR input defaults
Date: Fri, 11 May 2018 15:29:23 +0200
Message-ID: <20180511132928.7669-6-hdegoede@redhat.com>
References: <20180511132928.7669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9977E2677CF
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 15:29:39 +0200 (CEST)
In-Reply-To: <20180511132928.7669-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Currently we've 2 places with BYTCR defaults: 1. The generic catch-all
DMI_SYS_VENDOR=="Insyde" DMI quirk which selects SSP0-AIF1 for generic
Insyde BYTCR tablets without the ACPI channel package; and 2. the
defaults in the if (is_bytcr) {} code block.

Currently these are not identical, both select IN3 as the internal mic
output, but the "Insyde" DMI quirk leaves out the DIFF_MIC quirk. The
DIFF_MIC quirk should be enabled by default, because enabling diff. input
helps a lot for devices with a differential mic, where as it is a nop on
devices with a normal mic.

This commit adds the DIFF_MIC quirk to the "Insyde" DMI quirk path, by
adding a new BYTCR_INPUT_DEFAULTS define and using that in both code paths
which set BYTCR defaults.

Having a single place where the BYTCR input defaults are defined also
allows defining jack-detect defaults in a single place in a follow-up
commit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 47f6585ae864..cc111bf30935 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -82,6 +82,10 @@ enum {
 #define BYT_RT5640_MCLK_EN		BIT(22)
 #define BYT_RT5640_MCLK_25MHZ		BIT(23)
 
+#define BYTCR_INPUT_DEFAULTS				\
+	(BYT_RT5640_IN3_MAP |				\
+	 BYT_RT5640_DIFF_MIC)
+
 /* in-diff or dmic-pin + jdsrc + ovcd-th + -sf + jd-inv + terminating entry */
 #define MAX_NO_PROPS 6
 
@@ -475,7 +479,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 		},
-		.driver_data = (void *)(BYT_RT5640_IN3_MAP |
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
 					BYT_RT5640_MCLK_EN |
 					BYT_RT5640_SSP0_AIF1),
 
@@ -975,8 +979,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 
 		/* change defaults for Baytrail-CR capture */
-		byt_rt5640_quirk |= BYT_RT5640_IN3_MAP;
-		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
+		byt_rt5640_quirk |= BYTCR_INPUT_DEFAULTS;
 	} else {
 		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
 	}
-- 
2.17.0
