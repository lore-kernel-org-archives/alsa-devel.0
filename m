From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: remove rt5668 support" to the
	asoc tree
Date: Mon, 12 Feb 2018 12:27:47 +0000
Message-ID: <E1elDD1-0002pV-HU@debutante>
References: <1517224538-29983-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F64267338
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:27:50 +0100 (CET)
In-Reply-To: <1517224538-29983-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, shawn.lee@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: remove rt5668 support

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

>From 20ebbd2f89a9b2c61c4d432aa1156fc09e37f37c Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 29 Jan 2018 19:15:38 +0800
Subject: [PATCH] ASoC: rt5665: remove rt5668 support

Remove rt5668 support from rt5665 codec driver since rt5668 will
not go into mass production.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5665.txt | 4 ++--
 sound/soc/codecs/rt5665.c                          | 5 -----
 sound/soc/codecs/rt5665.h                          | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5665.txt b/Documentation/devicetree/bindings/sound/rt5665.txt
index 419c89219681..8df170506986 100644
--- a/Documentation/devicetree/bindings/sound/rt5665.txt
+++ b/Documentation/devicetree/bindings/sound/rt5665.txt
@@ -1,10 +1,10 @@
-RT5665/RT5666/RT5668 audio CODEC
+RT5665/RT5666 audio CODEC
 
 This device supports I2C only.
 
 Required properties:
 
-- compatible : One of "realtek,rt5665", "realtek,rt5666" or "realtek,rt5668".
+- compatible : One of "realtek,rt5665", "realtek,rt5666".
 
 - reg : The I2C address of the device.
 
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 819df1a32dd4..6ba99f5ed3f4 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4826,9 +4826,6 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	case 0x0:
 		rt5665->id = CODEC_5666;
 		break;
-	case 0x6:
-		rt5665->id = CODEC_5668;
-		break;
 	case 0x3:
 	default:
 		rt5665->id = CODEC_5665;
@@ -4955,7 +4952,6 @@ static void rt5665_i2c_shutdown(struct i2c_client *client)
 static const struct of_device_id rt5665_of_match[] = {
 	{.compatible = "realtek,rt5665"},
 	{.compatible = "realtek,rt5666"},
-	{.compatible = "realtek,rt5668"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt5665_of_match);
@@ -4965,7 +4961,6 @@ MODULE_DEVICE_TABLE(of, rt5665_of_match);
 static const struct acpi_device_id rt5665_acpi_match[] = {
 	{"10EC5665", 0,},
 	{"10EC5666", 0,},
-	{"10EC5668", 0,},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt5665_acpi_match);
diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index b528e416b592..b0a98ca39c5b 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1978,7 +1978,6 @@ enum {
 enum {
 	CODEC_5665,
 	CODEC_5666,
-	CODEC_5668,
 };
 
 /* filter mask */
-- 
2.16.1
