From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add quirk override by module
	option" to the asoc tree
Date: Fri, 30 Jun 2017 12:58:40 +0100
Message-ID: <E1dQuZM-0007vM-9B@finisterre>
References: <20170629160833.28413-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 100A12674A1
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:58:53 +0200 (CEST)
In-Reply-To: <20170629160833.28413-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add quirk override by module option

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

>From 4999b0214b05a08b42bbafcb29a0b9c413002d3f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 29 Jun 2017 18:08:33 +0200
Subject: [PATCH] ASoC: rt5645: Add quirk override by module option

For making the development easier, add quirk module option to override
the platform data setup.  For example, a platform with inverted jack
detection with jd_mode=2, pass the value 0x21 (0x1 = inv_jd1_1, 0x20 =
jd_mode=2).  It overrides the whole pdata fields, so pass it
carefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Tested-by: James Cameron <quozl@laptop.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 630374ee692a..909f4a6aaef1 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -34,6 +34,17 @@
 #include "rl6231.h"
 #include "rt5645.h"
 
+#define QUIRK_INV_JD1_1(q)	((q) & 1)
+#define QUIRK_LEVEL_IRQ(q)	(((q) >> 1) & 1)
+#define QUIRK_IN2_DIFF(q)	(((q) >> 2) & 1)
+#define QUIRK_JD_MODE(q)	(((q) >> 4) & 7)
+#define QUIRK_DMIC1_DATA_PIN(q)	(((q) >> 8) & 3)
+#define QUIRK_DMIC2_DATA_PIN(q)	(((q) >> 12) & 3)
+
+static unsigned int quirk = -1;
+module_param(quirk, uint, 0444);
+MODULE_PARM_DESC(quirk, "RT5645 pdata quirk override");
+
 #define RT5645_DEVICE_ID 0x6308
 #define RT5650_DEVICE_ID 0x6419
 
@@ -3679,6 +3690,15 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	else if (dmi_check_system(dmi_platform_gpd_win))
 		rt5645->pdata = gpd_win_platform_data;
 
+	if (quirk != -1) {
+		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
+		rt5645->pdata.level_trigger_irq = QUIRK_LEVEL_IRQ(quirk);
+		rt5645->pdata.inv_jd1_1 = QUIRK_INV_JD1_1(quirk);
+		rt5645->pdata.jd_mode = QUIRK_JD_MODE(quirk);
+		rt5645->pdata.dmic1_data_pin = QUIRK_DMIC1_DATA_PIN(quirk);
+		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
+	}
+
 	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
 						       GPIOD_IN);
 
-- 
2.13.2
