From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Constify max9867_reg and
	max9867_regmap" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:23 +0900
Message-ID: <E1aXBz5-0001jS-UL@finisterre>
References: <1455936851.19371.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38ED62606E8
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:34 +0100 (CET)
In-Reply-To: <1455936851.19371.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Constify max9867_reg and max9867_regmap

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

>From 250a99e70bf8628397901e10ad99a281dfc489d5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Feb 2016 10:54:11 +0800
Subject: [PATCH] ASoC: max9867: Constify max9867_reg and max9867_regmap

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 70b5406..ab7a94d 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -436,7 +436,7 @@ static bool max9867_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct reg_default max9867_reg[] = {
+static const struct reg_default max9867_reg[] = {
 	{ 0x04, 0x00 },
 	{ 0x05, 0x00 },
 	{ 0x06, 0x00 },
@@ -459,7 +459,7 @@ static struct reg_default max9867_reg[] = {
 	{ 0x17, 0x00 },
 };
 
-static struct regmap_config max9867_regmap = {
+static const struct regmap_config max9867_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= MAX9867_REVISION,
-- 
2.7.0
