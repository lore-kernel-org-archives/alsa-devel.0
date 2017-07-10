From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Update the HW default values
	based on the shipping version" to the asoc tree
Date: Mon, 10 Jul 2017 19:41:59 +0100
Message-ID: <E1dUdd9-0000AE-Db@debutante>
References: <1499656497-3986-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF2CA266DEE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 20:42:08 +0200 (CEST)
In-Reply-To: <1499656497-3986-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Update the HW default values based on the shipping version

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

>From 9f8f5b5f6c515e0c9d9bc14996fa8b9414c5ce1a Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 10 Jul 2017 11:14:57 +0800
Subject: [PATCH] ASoC: rt5663: Update the HW default values based on the
 shipping version

The patch update the HW default values based on the shipping version.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a33202affeb1..fa550e3c1332 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -466,7 +466,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0006, 0x1000 },
 	{ 0x000a, 0x0000 },
 	{ 0x0010, 0x000f },
-	{ 0x0015, 0x42c1 },
+	{ 0x0015, 0x42f1 },
 	{ 0x0016, 0x0000 },
 	{ 0x0018, 0x000b },
 	{ 0x0019, 0xafaf },
@@ -509,7 +509,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x008a, 0x0000 },
 	{ 0x008b, 0x0000 },
 	{ 0x008c, 0x0003 },
-	{ 0x008e, 0x0004 },
+	{ 0x008e, 0x0008 },
 	{ 0x008f, 0x1000 },
 	{ 0x0090, 0x0646 },
 	{ 0x0091, 0x0e3e },
@@ -520,7 +520,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0098, 0x0000 },
 	{ 0x009a, 0x0000 },
 	{ 0x009f, 0x0000 },
-	{ 0x00ae, 0x2000 },
+	{ 0x00ae, 0x6000 },
 	{ 0x00af, 0x0000 },
 	{ 0x00b6, 0x0000 },
 	{ 0x00b7, 0x0000 },
@@ -538,7 +538,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x00d9, 0x08f9 },
 	{ 0x00db, 0x0008 },
 	{ 0x00dc, 0x00c0 },
-	{ 0x00dd, 0x6724 },
+	{ 0x00dd, 0x6729 },
 	{ 0x00de, 0x3131 },
 	{ 0x00df, 0x0008 },
 	{ 0x00e0, 0x4000 },
@@ -578,7 +578,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0116, 0x0000 },
 	{ 0x0117, 0x0f00 },
 	{ 0x0118, 0x0006 },
-	{ 0x0125, 0x2224 },
+	{ 0x0125, 0x2424 },
 	{ 0x0126, 0x5550 },
 	{ 0x0127, 0x0400 },
 	{ 0x0128, 0x7711 },
@@ -596,8 +596,8 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0145, 0x0002 },
 	{ 0x0146, 0x0000 },
 	{ 0x0160, 0x0e80 },
-	{ 0x0161, 0x0020 },
-	{ 0x0162, 0x0080 },
+	{ 0x0161, 0x0080 },
+	{ 0x0162, 0x0200 },
 	{ 0x0163, 0x0800 },
 	{ 0x0164, 0x0000 },
 	{ 0x0165, 0x0000 },
@@ -676,8 +676,8 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0251, 0x0000 },
 	{ 0x0252, 0x028a },
 	{ 0x02fa, 0x0000 },
-	{ 0x02fb, 0x0000 },
-	{ 0x02fc, 0x0000 },
+	{ 0x02fb, 0x00a4 },
+	{ 0x02fc, 0x0300 },
 	{ 0x0300, 0x0000 },
 	{ 0x03d0, 0x0000 },
 	{ 0x03d1, 0x0000 },
-- 
2.13.2
