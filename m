From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: The ACPI also should use the
	function rt5514_parse_dp()" to the asoc tree
Date: Fri,  3 Nov 2017 11:46:52 +0000 (GMT)
Message-ID: <20171103114652.3760944005B@finisterre.ee.mobilebroadband>
References: <1509621676-14608-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DC347266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 12:46:53 +0100 (CET)
In-Reply-To: <1509621676-14608-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: The ACPI also should use the function rt5514_parse_dp()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 28aef24d726f8d503fde24ccf8a14b214355cfb5 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Thu, 2 Nov 2017 19:21:16 +0800
Subject: [PATCH] ASoC: rt5514: The ACPI also should use the function
 rt5514_parse_dp()

The patch fixed that the ACPI cannot access the device property from the
function rt5514_parse_dp().

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index d7956ababd11..2a5b5d74e697 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1143,7 +1143,7 @@ static const struct acpi_device_id rt5514_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5514_acpi_match);
 #endif
 
-static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
+static int rt5514_parse_dp(struct rt5514_priv *rt5514, struct device *dev)
 {
 	device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
 		&rt5514->pdata.dmic_init_delay);
@@ -1183,8 +1183,8 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5514->pdata = *pdata;
-	else if (i2c->dev.of_node)
-		rt5514_parse_dt(rt5514, &i2c->dev);
+	else
+		rt5514_parse_dp(rt5514, &i2c->dev);
 
 	rt5514->i2c_regmap = devm_regmap_init_i2c(i2c, &rt5514_i2c_regmap);
 	if (IS_ERR(rt5514->i2c_regmap)) {
-- 
2.14.1
