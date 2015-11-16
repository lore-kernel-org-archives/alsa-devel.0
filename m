From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: correct addresses for HPF_C_0/1" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:52 +0000
Message-ID: <E1ZyNwW-0006q1-DJ@debutante>
References: <1447178038-11156-1-git-send-email-sachinpandhare@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1447178038-11156-1-git-send-email-sachinpandhare@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Sachin Pandhare <sachinpandhare@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: correct addresses for HPF_C_0/1

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

>From e9f96bc53c1b959859599cb30ce6fd4fbb4448c2 Mon Sep 17 00:00:00 2001
From: Sachin Pandhare <sachinpandhare@gmail.com>
Date: Tue, 10 Nov 2015 23:38:02 +0530
Subject: [PATCH] ASoC: wm8962: correct addresses for HPF_C_0/1

>From datasheet:
R17408 (4400h) HPF_C_1
R17409 (4401h) HPF_C_0
17048 -> 17408 (0x4400)
17049 -> 17409 (0x4401)

Signed-off-by: Sachin Pandhare <sachinpandhare@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 39ebd7bf4f53..a7e79784fc16 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -365,8 +365,8 @@ static const struct reg_default wm8962_reg[] = {
 	{ 16924, 0x0059 },   /* R16924 - HDBASS_PG_1 */
 	{ 16925, 0x999A },   /* R16925 - HDBASS_PG_0 */
 
-	{ 17048, 0x0083 },   /* R17408 - HPF_C_1 */
-	{ 17049, 0x98AD },   /* R17409 - HPF_C_0 */
+	{ 17408, 0x0083 },   /* R17408 - HPF_C_1 */
+	{ 17409, 0x98AD },   /* R17409 - HPF_C_0 */
 
 	{ 17920, 0x007F },   /* R17920 - ADCL_RETUNE_C1_1 */
 	{ 17921, 0xFFFF },   /* R17921 - ADCL_RETUNE_C1_0 */
-- 
2.6.2
