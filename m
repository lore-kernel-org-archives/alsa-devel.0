From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Disable regulators on driver
	removal" to the asoc tree
Date: Fri,  5 Apr 2019 09:43:31 +0700 (+07)
Message-ID: <20190405024331.956B2441D3C@finisterre.ee.mobilebroadband>
References: <20190404162720.4995-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62708F8974E
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:43:36 +0200 (CEST)
In-Reply-To: <20190404162720.4995-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Disable regulators on driver removal

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

>From 47c4cc08cb5b34e93ab337b924c5ede77ca3c936 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 4 Apr 2019 17:27:20 +0100
Subject: [PATCH] ASoC: cs35l35: Disable regulators on driver removal

The chips main power supplies VA and VP are enabled during probe but
then never disabled, this will cause warnings from the regulator
framework on driver removal. Fix this by adding a remove callback and
disabling the supplies, whilst doing so follow best practice and put the
chip back into reset as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 9f4a59871cee..c71696146c5e 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1635,6 +1635,16 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	return ret;
 }
 
+static int cs35l35_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs35l35_private *cs35l35 = i2c_get_clientdata(i2c_client);
+
+	regulator_bulk_disable(cs35l35->num_supplies, cs35l35->supplies);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+
+	return 0;
+}
+
 static const struct of_device_id cs35l35_of_match[] = {
 	{.compatible = "cirrus,cs35l35"},
 	{},
@@ -1655,6 +1665,7 @@ static struct i2c_driver cs35l35_i2c_driver = {
 	},
 	.id_table = cs35l35_id,
 	.probe = cs35l35_i2c_probe,
+	.remove = cs35l35_i2c_remove,
 };
 
 module_i2c_driver(cs35l35_i2c_driver);
-- 
2.20.1
