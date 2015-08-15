From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: Use case range at appropriate
	places" to the asoc tree
Date: Fri, 14 Aug 2015 19:14:42 -0700
Message-ID: <E1ZQQza-0004PG-Ag@finisterre>
References: <1439348866.3594.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3012D2664D9
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:14:52 +0200 (CEST)
In-Reply-To: <1439348866.3594.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l32: Use case range at appropriate places

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

>From c17633081a0dc4c9f8c28b7a77ac5b63a1780e49 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Aug 2015 11:07:46 +0800
Subject: [PATCH] ASoC: cs35l32: Use case range at appropriate places

Use case range syntax makes the code shorter with better readability when
we have a large number of continuous switch cases.

Below are the summary of readable/volatile/precious registers.

The readable registers:
        0x01 ~  0x0D, 0x0F ~ 0x1C
The volatile registers:
        0x01 ~ 0x05, 0x15 ~ 0x18
The precious registers:
        0x15 ~ 0x18

No functional change with this patch.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.c | 45 +++++----------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index f5f86b2..c84facc 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -74,33 +74,8 @@ static const struct reg_default cs35l32_reg_defaults[] = {
 static bool cs35l32_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS35L32_DEVID_AB:
-	case CS35L32_DEVID_CD:
-	case CS35L32_DEVID_E:
-	case CS35L32_FAB_ID:
-	case CS35L32_REV_ID:
-	case CS35L32_PWRCTL1:
-	case CS35L32_PWRCTL2:
-	case CS35L32_CLK_CTL:
-	case CS35L32_BATT_THRESHOLD:
-	case CS35L32_VMON:
-	case CS35L32_BST_CPCP_CTL:
-	case CS35L32_IMON_SCALING:
-	case CS35L32_AUDIO_LED_MNGR:
-	case CS35L32_ADSP_CTL:
-	case CS35L32_CLASSD_CTL:
-	case CS35L32_PROTECT_CTL:
-	case CS35L32_INT_MASK_1:
-	case CS35L32_INT_MASK_2:
-	case CS35L32_INT_MASK_3:
-	case CS35L32_INT_STATUS_1:
-	case CS35L32_INT_STATUS_2:
-	case CS35L32_INT_STATUS_3:
-	case CS35L32_LED_STATUS:
-	case CS35L32_FLASH_MODE:
-	case CS35L32_MOVIE_MODE:
-	case CS35L32_FLASH_TIMER:
-	case CS35L32_FLASH_INHIBIT:
+	case CS35L32_DEVID_AB ... CS35L32_AUDIO_LED_MNGR:
+	case CS35L32_ADSP_CTL ... CS35L32_FLASH_INHIBIT:
 		return true;
 	default:
 		return false;
@@ -110,15 +85,8 @@ static bool cs35l32_readable_register(struct device *dev, unsigned int reg)
 static bool cs35l32_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS35L32_DEVID_AB:
-	case CS35L32_DEVID_CD:
-	case CS35L32_DEVID_E:
-	case CS35L32_FAB_ID:
-	case CS35L32_REV_ID:
-	case CS35L32_INT_STATUS_1:
-	case CS35L32_INT_STATUS_2:
-	case CS35L32_INT_STATUS_3:
-	case CS35L32_LED_STATUS:
+	case CS35L32_DEVID_AB ... CS35L32_REV_ID:
+	case CS35L32_INT_STATUS_1 ... CS35L32_LED_STATUS:
 		return true;
 	default:
 		return false;
@@ -128,10 +96,7 @@ static bool cs35l32_volatile_register(struct device *dev, unsigned int reg)
 static bool cs35l32_precious_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS35L32_INT_STATUS_1:
-	case CS35L32_INT_STATUS_2:
-	case CS35L32_INT_STATUS_3:
-	case CS35L32_LED_STATUS:
+	case CS35L32_INT_STATUS_1 ... CS35L32_LED_STATUS:
 		return true;
 	default:
 		return false;
-- 
2.5.0
