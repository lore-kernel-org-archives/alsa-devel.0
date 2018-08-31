From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas6424: Add channel fault reporting"
	to the asoc tree
Date: Fri, 31 Aug 2018 16:24:15 +0100 (BST)
Message-ID: <20180831152415.3938F11226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB01267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:24:16 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas6424: Add channel fault reporting

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

>From 5fb6589acc3860304436aa436e7ea33712de6fc2 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Fri, 31 Aug 2018 10:14:07 -0500
Subject: [PATCH] ASoC: tas6424: Add channel fault reporting

The TAS6426 has a register that reports channel faults such as
overcurrent and continuous DC output. Add reporting of this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas6424.c | 52 +++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/tas6424.h | 10 ++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index aac559fffc1a..36aebdb8f55c 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -41,6 +41,7 @@ struct tas6424_data {
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[TAS6424_NUM_SUPPLIES];
 	struct delayed_work fault_check_work;
+	unsigned int last_cfault;
 	unsigned int last_fault1;
 	unsigned int last_fault2;
 	unsigned int last_warn;
@@ -406,6 +407,51 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	unsigned int reg;
 	int ret;
 
+	ret = regmap_read(tas6424->regmap, TAS6424_CHANNEL_FAULT, &reg);
+	if (ret < 0) {
+		dev_err(dev, "failed to read CHANNEL_FAULT register: %d\n", ret);
+		goto out;
+	}
+
+	if (!reg) {
+		tas6424->last_cfault = reg;
+		goto check_global_fault1_reg;
+	}
+
+	/*
+	 * Only flag errors once for a given occurrence. This is needed as
+	 * the TAS6424 will take time clearing the fault condition internally
+	 * during which we don't want to bombard the system with the same
+	 * error message over and over.
+	 */
+	if ((reg & TAS6424_FAULT_OC_CH1) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH1))
+		dev_crit(dev, "experienced a channel 1 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH2) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH2))
+		dev_crit(dev, "experienced a channel 2 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH3) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH3))
+		dev_crit(dev, "experienced a channel 3 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_OC_CH4) && !(tas6424->last_cfault & TAS6424_FAULT_OC_CH4))
+		dev_crit(dev, "experienced a channel 4 overcurrent fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH1) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH1))
+		dev_crit(dev, "experienced a channel 1 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH2) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH2))
+		dev_crit(dev, "experienced a channel 2 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH3) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH3))
+		dev_crit(dev, "experienced a channel 3 DC fault\n");
+
+	if ((reg & TAS6424_FAULT_DC_CH4) && !(tas6424->last_cfault & TAS6424_FAULT_DC_CH4))
+		dev_crit(dev, "experienced a channel 4 DC fault\n");
+
+	/* Store current fault1 value so we can detect any changes next time */
+	tas6424->last_cfault = reg;
+
+check_global_fault1_reg:
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT1, &reg);
 	if (ret < 0) {
 		dev_err(dev, "failed to read GLOB_FAULT1 register: %d\n", ret);
@@ -429,12 +475,6 @@ static void tas6424_fault_check_work(struct work_struct *work)
 		goto check_global_fault2_reg;
 	}
 
-	/*
-	 * Only flag errors once for a given occurrence. This is needed as
-	 * the TAS6424 will take time clearing the fault condition internally
-	 * during which we don't want to bombard the system with the same
-	 * error message over and over.
-	 */
 	if ((reg & TAS6424_FAULT_PVDD_OV) && !(tas6424->last_fault1 & TAS6424_FAULT_PVDD_OV))
 		dev_crit(dev, "experienced a PVDD overvoltage fault\n");
 
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index b5958c45ed0e..c67a7835ca66 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -115,6 +115,16 @@
 #define TAS6424_LDGBYPASS_SHIFT		0
 #define TAS6424_LDGBYPASS_MASK		BIT(TAS6424_LDGBYPASS_SHIFT)
 
+/* TAS6424_GLOB_FAULT1_REG */
+#define TAS6424_FAULT_OC_CH1		BIT(7)
+#define TAS6424_FAULT_OC_CH2		BIT(6)
+#define TAS6424_FAULT_OC_CH3		BIT(5)
+#define TAS6424_FAULT_OC_CH4		BIT(4)
+#define TAS6424_FAULT_DC_CH1		BIT(3)
+#define TAS6424_FAULT_DC_CH2		BIT(2)
+#define TAS6424_FAULT_DC_CH3		BIT(1)
+#define TAS6424_FAULT_DC_CH4		BIT(0)
+
 /* TAS6424_GLOB_FAULT1_REG */
 #define TAS6424_FAULT_CLOCK		BIT(4)
 #define TAS6424_FAULT_PVDD_OV		BIT(3)
-- 
2.19.0.rc1
