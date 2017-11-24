From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8825: improve crosstalk
	measurement protection
Date: Fri, 24 Nov 2017 18:08:27 +0800
Message-ID: <1511518107-7488-2-git-send-email-KCHSU0@nuvoton.com>
References: <1511518107-7488-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 502172678EF
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 11:08:40 +0100 (CET)
In-Reply-To: <1511518107-7488-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

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
The sequence is still under protection from playback.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 45 +++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/nau8825.h |  1 +
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index d3c1a02..e696f6c 100644
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
@@ -454,22 +454,32 @@ static void nau8825_xtalk_backup(struct nau8825 *nau8825)
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
@@ -479,6 +489,8 @@ static void nau8825_xtalk_restore(struct nau8825 *nau8825)
 		regmap_write(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
 				nau8825_xtalk_baktab[i].def);
 	}
+
+	nau8825->xtalk_baktab_initialized = false;
 }
 
 static void nau8825_xtalk_prepare_dac(struct nau8825 *nau8825)
@@ -644,7 +656,7 @@ static void nau8825_xtalk_clean_adc(struct nau8825 *nau8825)
 		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK, 0);
 }
 
-static void nau8825_xtalk_clean(struct nau8825 *nau8825)
+static void nau8825_xtalk_clean(struct nau8825 *nau8825, bool cause_cancel)
 {
 	/* Enable internal VCO needed for interruptions */
 	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
@@ -660,7 +672,7 @@ static void nau8825_xtalk_clean(struct nau8825 *nau8825)
 		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_SLAVE);
 	/* Restore value of specific register for cross talk */
-	nau8825_xtalk_restore(nau8825);
+	nau8825_xtalk_restore(nau8825, cause_cancel);
 }
 
 static void nau8825_xtalk_imm_start(struct nau8825 *nau8825, int vol)
@@ -779,7 +791,7 @@ static void nau8825_xtalk_measure(struct nau8825 *nau8825)
 		dev_dbg(nau8825->dev, "cross talk sidetone: %x\n", sidetone);
 		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
 					(sidetone << 8) | sidetone);
-		nau8825_xtalk_clean(nau8825);
+		nau8825_xtalk_clean(nau8825, false);
 		nau8825->xtalk_state = NAU8825_XTALK_DONE;
 		break;
 	default:
@@ -822,7 +834,7 @@ static void nau8825_xtalk_cancel(struct nau8825 *nau8825)
 	if (nau8825->xtalk_enable && nau8825->xtalk_state !=
 		NAU8825_XTALK_DONE) {
 		cancel_work_sync(&nau8825->xtalk_work);
-		nau8825_xtalk_clean(nau8825);
+		nau8825_xtalk_clean(nau8825, true);
 	}
 	/* Reset parameters for cross talk suppression function */
 	nau8825_sema_reset(nau8825);
@@ -1705,8 +1717,11 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
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
@@ -1733,7 +1748,8 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 			nau8825->xtalk_event_mask = event_mask;
 		}
 	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
-		if (nau8825->xtalk_enable) {
+		/* crosstalk detection enable and process on going */
+		if (nau8825->xtalk_enable && nau8825->xtalk_protect) {
 			schedule_work(&nau8825->xtalk_work);
 			clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
 		}
@@ -2571,6 +2587,7 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 	 */
 	nau8825->xtalk_state = NAU8825_XTALK_DONE;
 	nau8825->xtalk_protect = false;
+	nau8825->xtalk_baktab_initialized = false;
 	sema_init(&nau8825->xtalk_sem, 1);
 	INIT_WORK(&nau8825->xtalk_work, nau8825_xtalk_work);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 199d6ea..f7e7321 100644
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
2.6.4
