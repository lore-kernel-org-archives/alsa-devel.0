From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add dmi for Broadwell" to the
	asoc tree
Date: Sat, 19 Sep 2015 17:13:05 -0700
Message-ID: <E1ZdSFd-00042e-8q@finisterre>
References: <1442543948-10486-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A52A726065A
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:34 +0200 (CEST)
In-Reply-To: <1442543948-10486-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add dmi for Broadwell

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

>From 3dbabe60c832fe874617166b8fdcf18ae992de46 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 18 Sep 2015 10:55:58 +0800
Subject: [PATCH] ASoC: rt5645: Add dmi for Broadwell

Add DMI data for Buddy project.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dbc1d76..006dd02 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3209,6 +3209,31 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{ }
 };
 
+static struct rt5645_platform_data buddy_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.jd_mode = 3,
+};
+
+static int buddy_quirk_cb(const struct dmi_system_id *id)
+{
+	rt5645_pdata = &buddy_platform_data;
+
+	return 1;
+}
+
+static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
+	{
+		.ident = "Chrome Buddy",
+		.callback = buddy_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Buddy"),
+		},
+	},
+	{ }
+};
+
+
 static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 {
 	rt5645->pdata.in2_diff = device_property_read_bool(dev,
@@ -3241,7 +3266,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5645->pdata = *pdata;
-	else if (dmi_check_system(dmi_platform_intel_braswell))
+	else if (dmi_check_system(dmi_platform_intel_braswell) ||
+			dmi_check_system(dmi_platform_intel_broadwel)
 		rt5645->pdata = *rt5645_pdata;
 	else
 		rt5645_parse_dt(rt5645, &i2c->dev);
-- 
2.5.0
