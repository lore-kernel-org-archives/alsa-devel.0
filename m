From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add jack detection workaround
	for GPD Win" to the asoc tree
Date: Wed, 28 Jun 2017 20:23:59 +0100
Message-ID: <E1dQIZD-0004Mn-SN@finisterre>
References: <20170628124939.11696-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E51E2671EB
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:24:10 +0200 (CEST)
In-Reply-To: <20170628124939.11696-5-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add jack detection workaround for GPD Win

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

>From ea2b5a6e3a386b89d7f9148ff8be6c78d13542a0 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 28 Jun 2017 14:49:39 +0200
Subject: [PATCH] ASoC: rt5645: Add jack detection workaround for GPD Win

GPD Win requires jd_mode=3 and the inverted flag for making the jack
detection working.  Unfortunately, the BIOS doesn't give a nice way to
match with DMI strings, and the only working way so far is to match
with the board vendor/name/version/date to some known patterns.

Hopefully other vendors won't do such a stupid setup, too...

Thanks to Hans de Goede for the DMI matching suggestion.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 162044d82632..308c22f5909a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3599,6 +3599,33 @@ static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{ }
 };
 
+static struct rt5645_platform_data gpd_win_platform_data = {
+	.jd_mode = 3,
+	.inv_jd1_1 = true,
+};
+
+static const struct dmi_system_id dmi_platform_gpd_win[] = {
+	{
+		/*
+		 * Match for the GPDwin which unfortunately uses somewhat
+		 * generic dmi strings, which is why we test for 4 strings.
+		 * Comparing against 23 other byt/cht boards, board_vendor
+		 * and board_name are unique to the GPDwin, where as only one
+		 * other board has the same board_serial and 3 others have
+		 * the same default product_name. Also the GPDwin is the
+		 * only device to have both board_ and product_name not set.
+		 */
+		.ident = "GPD Win",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		},
+	},
+	{}
+};
+
 static bool rt5645_check_dp(struct device *dev)
 {
 	if (device_property_present(dev, "realtek,in2-differential") ||
@@ -3649,6 +3676,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645_parse_dt(rt5645, &i2c->dev);
 	else if (dmi_check_system(dmi_platform_intel_braswell))
 		rt5645->pdata = general_platform_data;
+	else if (dmi_check_system(dmi_platform_gpd_win))
+		rt5645->pdata = gpd_win_platform_data;
 
 	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
 						       GPIOD_IN);
-- 
2.13.2
