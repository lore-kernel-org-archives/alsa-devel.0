From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Fix max_register setting for
	cs4349_regmap" to the asoc tree
Date: Mon, 20 Jul 2015 18:52:28 +0100
Message-ID: <E1ZHFEq-0002xE-5y@debutante>
References: <1437147514.1229.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C9626167A
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:35 +0200 (CEST)
In-Reply-To: <1437147514.1229.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Tim Howe <tim.howe@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: Fix max_register setting for cs4349_regmap

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

>From dd9283e23f674281c02cd8cbf894cb3132a4e3a6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 17 Jul 2015 23:38:34 +0800
Subject: [PATCH] ASoC: cs4349: Fix max_register setting for cs4349_regmap

The max_register should be the maximum valid register index rather than
number of registers. Also remove unused defines.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Tim Howe <tim.howe@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 2 +-
 sound/soc/codecs/cs4349.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a8df8a749607..9273b06e918b 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -268,7 +268,7 @@ static struct regmap_config cs4349_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 
-	.max_register		= CS4349_NUMREGS,
+	.max_register		= CS4349_MISC,
 	.reg_defaults		= cs4349_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(cs4349_reg_defaults),
 	.readable_reg		= cs4349_readable_register,
diff --git a/sound/soc/codecs/cs4349.h b/sound/soc/codecs/cs4349.h
index 3884a8907d23..7effa0acec28 100644
--- a/sound/soc/codecs/cs4349.h
+++ b/sound/soc/codecs/cs4349.h
@@ -36,9 +36,6 @@ struct cs4349_platform_data {
 #define CS4349_RMPFLT		0x07	/* Ramp and Filter Control */
 #define CS4349_MISC		0x08	/* Power Down,Freeze Control,Pop Stop*/
 
-#define CS4349_FIRSTREG		0x01
-#define CS4349_LASTREG		0x08
-#define CS4349_NUMREGS		(CS4349_LASTREG - CS4349_FIRSTREG + 1)
 #define CS4349_I2C_INCR		0x80
 
 
-- 
2.1.4
