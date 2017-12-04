From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: improve crosstalk measurement
	protection" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:00 +0000
Message-ID: <E1eLvnY-0000Lx-5R@debutante>
References: <1512093697-11043-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B2D2675E7
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:17 +0100 (CET)
In-Reply-To: <1512093697-11043-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: improve crosstalk measurement protection

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

>From fa25b4f59f1de9536104b632ec4c4c0b8f8e54ec Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 1 Dec 2017 10:01:37 +0800
Subject: [PATCH] ASoC: nau8825: improve crosstalk measurement protection

The sequence of crosstalk measurement is not robust. The driver
add more protections to make it stronger. The improvements as follows:
(1)Give backup table the default value. The values are the same
with the default of hardware registers. The impact will decline
once restoring the backup table in the wrong way.
(2)Add xtalk_baktab_initialized flag. The flag can keep the
initiation status of backup table. It helps to backup and restore
the backup-table correctly.
(3)Add cancel parameter in the restore function. The volume ramping
should do in crosstalk DONE state only. Otherwise, the delay action
is not allowed because the restore may happen during the jack
eject interruption.
(4)Add xtalk_protect condition check before scheduling work in ISR.
It makes sure the semaphore hold during the crosstalk measurement.
The sequence is still under protection from playback interference.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 45 +++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/nau8825.h |  1 +
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5778eadbf9e6..2aea642b4a5d 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -194,10 +194,10 @@ static const struct reg_default nau8825_reg_defaults[] = {
 
 /* register backup table when cross talk detection */
 static struct reg_default nau8825_xtalk_baktab[] = {
-	{ NAU8825_REG_ADC_DGAIN_CTRL, 0 },
+	{ NAU8825_REG_ADC_DGAIN_CTRL, 0x00cf },
 	{ NAU8825_REG_HSVOL_CTRL, 0 },
-	{ NAU8825_REG_DACL_CTRL, 0 },
-	{ NAU8825_REG_DACR_CTRL, 0 },
+	{ NAU8825_REG_DACL_CTRL, 0x00cf },
+	{ NAU8825_REG_DACR_CTRL, 0x02cf },
 };
 
 static const unsigned short logtable[256] = {
@@ -455,22 +455,32 @@ static void nau8825_xtalk_backup(struct nau8825 *nau8825)
 {
 	int i;
 
+	if (nau8825->xtalk_baktab_initialized)
+		return;
+
 	/* Backup some register values to backup table */
 	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++)
 		regmap_read(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
 				&nau8825_xtalk_baktab[i].def);
+
+	nau8825->xtalk_baktab_initialized = true;
 }
 
-static void nau8825_xtalk_restore(struct nau8825 *nau8825)
+static void nau8825_xtalk_restore(struct nau8825 *nau8825, bool cause_cancel)
 {
 	int i, volume;
 
+	if (!nau8825->xtalk_baktab_initialized)
+		return;
+
 	/* Restore register values from backup table; When the driver restores
-	 * the headphone volumem, it needs recover to original level gradually
-	 * with 3dB per step for less pop noise.
+	 * the headphone volume in XTALK_DONE state, it needs recover to
+	 * original level gradually with 3dB per step for less pop noise.
+	 * Otherwise, the restore should do ASAP.
 	 */
 	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++) {
-		if (nau8825_xtalk_baktab[i].reg == NAU8825_REG_HSVOL_CTRL) {
+		if (!cause_cancel && nau8825_xtalk_baktab[i].reg ==
+			NAU8825_REG_HSVOL_CTRL) {
 			/* Ramping up the volume change to reduce pop noise */
 			volume = nau8825_xtalk_baktab[i].def &
 				NAU8825_HPR_VOL_MASK;
@@ -480,6 +490,8 @@ static void nau8825_xtalk_restore(struct nau8825 *nau8825)
 		regmap_write(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
 				nau8825_xtalk_baktab[i].def);
 	}
+
+	nau8825->xtalk_baktab_initialized = false;
 }
 
 static void nau8825_xtalk_prepare_dac(struct nau8825 *nau8825)
@@ -645,7 +657,7 @@ static void nau8825_xtalk_clean_adc(struct nau8825 *nau8825)
 		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK, 0);
 }
 
-static void nau8825_xtalk_clean(struct nau8825 *nau8825)
+static void nau8825_xtalk_clean(struct nau8825 *nau8825, bool cause_cancel)
 {
 	/* Enable internal VCO needed for interruptions */
 	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
@@ -661,7 +673,7 @@ static void nau8825_xtalk_clean(struct nau8825 *nau8825)
 		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_SLAVE);
 	/* Restore value of specific register for cross talk */
-	nau8825_xtalk_restore(nau8825);
+	nau8825_xtalk_restore(nau8825, cause_cancel);
 }
 
 static void nau8825_xtalk_imm_start(struct nau8825 *nau8825, int vol)
@@ -780,7 +792,7 @@ static void nau8825_xtalk_measure(struct nau8825 *nau8825)
 		dev_dbg(nau8825->dev, "cross talk sidetone: %x\n", sidetone);
 		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
 					(sidetone << 8) | sidetone);
-		nau8825_xtalk_clean(nau8825);
+		nau8825_xtalk_clean(nau8825, false);
 		nau8825->xtalk_state = NAU8825_XTALK_DONE;
 		break;
 	default:
@@ -823,7 +835,7 @@ static void nau8825_xtalk_cancel(struct nau8825 *nau8825)
 	if (nau8825->xtalk_enable && nau8825->xtalk_state !=
 		NAU8825_XTALK_DONE) {
 		cancel_work_sync(&nau8825->xtalk_work);
-		nau8825_xtalk_clean(nau8825);
+		nau8825_xtalk_clean(nau8825, true);
 	}
 	/* Reset parameters for cross talk suppression function */
 	nau8825_sema_reset(nau8825);
@@ -1713,8 +1725,11 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 						nau8825->xtalk_protect = false;
 				}
 				/* Startup cross talk detection process */
-				nau8825->xtalk_state = NAU8825_XTALK_PREPARE;
-				schedule_work(&nau8825->xtalk_work);
+				if (nau8825->xtalk_protect) {
+					nau8825->xtalk_state =
+						NAU8825_XTALK_PREPARE;
+					schedule_work(&nau8825->xtalk_work);
+				}
 			} else {
 				/* The cross talk suppression shouldn't apply
 				 * in the headset with high impedance. Thus,
@@ -1741,7 +1756,8 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 			nau8825->xtalk_event_mask = event_mask;
 		}
 	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
-		if (nau8825->xtalk_enable)
+		/* crosstalk detection enable and process on going */
+		if (nau8825->xtalk_enable && nau8825->xtalk_protect)
 			schedule_work(&nau8825->xtalk_work);
 		clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
 	} else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
@@ -2578,6 +2594,7 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 	 */
 	nau8825->xtalk_state = NAU8825_XTALK_DONE;
 	nau8825->xtalk_protect = false;
+	nau8825->xtalk_baktab_initialized = false;
 	sema_init(&nau8825->xtalk_sem, 1);
 	INIT_WORK(&nau8825->xtalk_work, nau8825_xtalk_work);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 199d6ea4dcdc..f7e732125882 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -477,6 +477,7 @@ struct nau8825 {
 	bool xtalk_protect;
 	int imp_rms[NAU8825_XTALK_IMM];
 	int xtalk_enable;
+	bool xtalk_baktab_initialized; /* True if initialized. */
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.15.0
