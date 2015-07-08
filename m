From: Mark Brown <broonie@kernel.org>
Subject: Applied "mfd: wm5110: Add registers for custom write
	sequence triggers" to the asoc tree
Date: Wed, 08 Jul 2015 20:23:38 +0100
Message-ID: <E1ZCuwU-0005to-M5@debutante>
References: <1435838281-15873-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8DFC265A2B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:23:46 +0200 (CEST)
In-Reply-To: <1435838281-15873-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   mfd: wm5110: Add registers for custom write sequence triggers

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

>From f089d4d20fcbcf16a62ef3b4b57f41ecf59a5d83 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 7 Jul 2015 15:28:12 +0100
Subject: [PATCH] mfd: wm5110: Add registers for custom write sequence triggers

This register will be needed as part of some additional support for the
headphone path on wm5110, so this patch adds the register and sets up
its regmap config.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm5110-tables.c           |  2 ++
 include/linux/mfd/arizona/registers.h | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 12cad94b4035..62a4aa13cb98 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -676,6 +676,7 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000032, 0x0100 },    /* R50    - PWM Drive 3 */
 	{ 0x00000040, 0x0000 },    /* R64    - Wake control */
 	{ 0x00000041, 0x0000 },    /* R65    - Sequence control */
+	{ 0x00000042, 0x0000 },    /* R66    - Spare Triggers */
 	{ 0x00000061, 0x01FF },    /* R97    - Sample Rate Sequence Select 1 */
 	{ 0x00000062, 0x01FF },    /* R98    - Sample Rate Sequence Select 2 */
 	{ 0x00000063, 0x01FF },    /* R99    - Sample Rate Sequence Select 3 */
@@ -1716,6 +1717,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_PWM_DRIVE_3:
 	case ARIZONA_WAKE_CONTROL:
 	case ARIZONA_SEQUENCE_CONTROL:
+	case ARIZONA_SPARE_TRIGGERS:
 	case ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_1:
 	case ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_2:
 	case ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_3:
diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index 3499d36e6067..11affb3c2768 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -39,6 +39,7 @@
 #define ARIZONA_PWM_DRIVE_3                      0x32
 #define ARIZONA_WAKE_CONTROL                     0x40
 #define ARIZONA_SEQUENCE_CONTROL                 0x41
+#define ARIZONA_SPARE_TRIGGERS                   0x42
 #define ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_1    0x61
 #define ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_2    0x62
 #define ARIZONA_SAMPLE_RATE_SEQUENCE_SELECT_3    0x63
@@ -1431,6 +1432,42 @@
 #define ARIZONA_WSEQ_ENA_JD2_RISE_WIDTH               1  /* WSEQ_ENA_JD2_RISE */
 
 /*
+ * R66 (0x42) - Spare Triggers
+ */
+#define ARIZONA_WS_TRG8                          0x0080  /* WS_TRG8 */
+#define ARIZONA_WS_TRG8_MASK                     0x0080  /* WS_TRG8 */
+#define ARIZONA_WS_TRG8_SHIFT                         7  /* WS_TRG8 */
+#define ARIZONA_WS_TRG8_WIDTH                         1  /* WS_TRG8 */
+#define ARIZONA_WS_TRG7                          0x0040  /* WS_TRG7 */
+#define ARIZONA_WS_TRG7_MASK                     0x0040  /* WS_TRG7 */
+#define ARIZONA_WS_TRG7_SHIFT                         6  /* WS_TRG7 */
+#define ARIZONA_WS_TRG7_WIDTH                         1  /* WS_TRG7 */
+#define ARIZONA_WS_TRG6                          0x0020  /* WS_TRG6 */
+#define ARIZONA_WS_TRG6_MASK                     0x0020  /* WS_TRG6 */
+#define ARIZONA_WS_TRG6_SHIFT                         5  /* WS_TRG6 */
+#define ARIZONA_WS_TRG6_WIDTH                         1  /* WS_TRG6 */
+#define ARIZONA_WS_TRG5                          0x0010  /* WS_TRG5 */
+#define ARIZONA_WS_TRG5_MASK                     0x0010  /* WS_TRG5 */
+#define ARIZONA_WS_TRG5_SHIFT                         4  /* WS_TRG5 */
+#define ARIZONA_WS_TRG5_WIDTH                         1  /* WS_TRG5 */
+#define ARIZONA_WS_TRG4                          0x0008  /* WS_TRG4 */
+#define ARIZONA_WS_TRG4_MASK                     0x0008  /* WS_TRG4 */
+#define ARIZONA_WS_TRG4_SHIFT                         3  /* WS_TRG4 */
+#define ARIZONA_WS_TRG4_WIDTH                         1  /* WS_TRG4 */
+#define ARIZONA_WS_TRG3                          0x0004  /* WS_TRG3 */
+#define ARIZONA_WS_TRG3_MASK                     0x0004  /* WS_TRG3 */
+#define ARIZONA_WS_TRG3_SHIFT                         2  /* WS_TRG3 */
+#define ARIZONA_WS_TRG3_WIDTH                         1  /* WS_TRG3 */
+#define ARIZONA_WS_TRG2                          0x0002  /* WS_TRG2 */
+#define ARIZONA_WS_TRG2_MASK                     0x0002  /* WS_TRG2 */
+#define ARIZONA_WS_TRG2_SHIFT                         1  /* WS_TRG2 */
+#define ARIZONA_WS_TRG2_WIDTH                         1  /* WS_TRG2 */
+#define ARIZONA_WS_TRG1                          0x0001  /* WS_TRG1 */
+#define ARIZONA_WS_TRG1_MASK                     0x0001  /* WS_TRG1 */
+#define ARIZONA_WS_TRG1_SHIFT                         0  /* WS_TRG1 */
+#define ARIZONA_WS_TRG1_WIDTH                         1  /* WS_TRG1 */
+
+/*
  * R97 (0x61) - Sample Rate Sequence Select 1
  */
 #define ARIZONA_WSEQ_SAMPLE_RATE_DETECT_A_SEQ_ADDR_MASK 0x01FF  /* WSEQ_SAMPLE_RATE_DETECT_A_SEQ_ADDR - [8:0] */
-- 
2.1.4
