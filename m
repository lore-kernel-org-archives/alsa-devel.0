From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98926: Constify max98926_reg and
	max98926_regmap" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:35 +0900
Message-ID: <E1aXBzH-0001kq-2l@finisterre>
References: <1455937018.19371.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 782422606D3
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:45 +0100 (CET)
In-Reply-To: <1455937018.19371.3.camel@ingics.com>
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

   ASoC: max98926: Constify max98926_reg and max98926_regmap

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

>From e354d86e551656668e879c833de9890b5053cc88 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Feb 2016 10:56:58 +0800
Subject: [PATCH] ASoC: max98926: Constify max98926_reg and max98926_regmap

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 5245e10..8d14ada 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -40,7 +40,7 @@ static const char *const max98926_hpf_cutoff_txt[] = {
 	"200Hz", "400Hz", "800Hz",
 };
 
-static struct reg_default max98926_reg[] = {
+static const struct reg_default max98926_reg[] = {
 	{ 0x0B, 0x00 }, /* IRQ Enable0 */
 	{ 0x0C, 0x00 }, /* IRQ Enable1 */
 	{ 0x0D, 0x00 }, /* IRQ Enable2 */
@@ -506,7 +506,7 @@ static struct snd_soc_codec_driver soc_codec_dev_max98926 = {
 	.num_dapm_widgets = ARRAY_SIZE(max98926_dapm_widgets),
 };
 
-static struct regmap_config max98926_regmap = {
+static const struct regmap_config max98926_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= MAX98926_VERSION,
-- 
2.7.0
