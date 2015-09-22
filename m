From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add dmi for Broadwell" to the
	asoc tree
Date: Tue, 22 Sep 2015 09:47:02 -0700
Message-ID: <E1ZeQic-00011O-Gh@finisterre>
References: <1442815921-19061-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9536C264F22
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 18:47:42 +0200 (CEST)
In-Reply-To: <1442815921-19061-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
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

>From e9159e7577cfd1ac8b3c5ea8916ad37bcd87e629 Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Mon, 21 Sep 2015 14:12:00 +0800
Subject: [PATCH] ASoC: rt5645: Add dmi for Broadwell

Add DMI data for Buddy project.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dbc1d76..e830688 100644
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
+			dmi_check_system(dmi_platform_intel_broadwell))
 		rt5645->pdata = *rt5645_pdata;
 	else
 		rt5645_parse_dt(rt5645, &i2c->dev);
-- 
2.5.0
