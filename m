From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8825: cross talk suppression
	measurement function
Date: Fri, 29 Apr 2016 16:15:18 +0800
Message-ID: <1461917718-25211-2-git-send-email-KCHSU0@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF6252651A5
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 10:15:08 +0200 (CEST)
In-Reply-To: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The cross talk measurement function can reduce cross talk across the JKTIP
HPL) and JKR1(HPR) outputs which measures the cross talk signal level to
determine what is the cross talk reduction gain. This system works by
sending a 23Hz -24dBV sine wave into the headset output DAC and through
the PGA. The output of the PGA is then connected to an internal current
sense which measures the attenuated 23Hz signal and passing the output to
an ADC which converts the measurement to a binary code. With two separated
measurement, one for JKR1(HPR) and the other JKTIP(HPL), measurement data
can be separated read in IMM_RMS_L for HSR and HSL after each measurement.

Thus, the measurement function has four states to complete whole sequence.
(1)Prepare state : Prepare the resource for detection and transfer to HPR
IMM stat to make JKR1(HPR) impedance measure.
(2)HPR IMM state : Read out orignal signal level of JKR1(HPR) and transfer
to HPL IMM state to make JKTIP(HPL) impedance measure.
(3)HPL IMM state : Read out cross talk signal level of JKTIP(HPL) and
transfer to IMM state to determine suppression sidetone gain.
(4)IMM state : Computes cross talk suppression sidetone gain with orignal
and cross talk signal level. Apply this gain and then restore codec con-
figuration. Then transfer to Done state for ending.

In order to get the cross talk suppression sidetone gain, we need the
function to compute log10 value and the result is round off to 3 decimal.
This function takes reference to dvb-math. The source code locates as the
following. "Linux/drivers/media/dvb-core/dvb_math.c"
Then, the orignal and cross talk signal vlues need to be characterized.
The sidetone value can be converted to decibel with the equation below.
sidetone = 20 * log (original signal level / crosstalk signal level)

Besides, the state machine for cross talk process needs interruptions to
trigger worked. We have the RMS intrruption enabled with the internal VCO
clock when headset connected. In the interrupt handler, the driver will
judge the headset is high impedance or not. If yes, the cross talk supp-
ression shouldn't apply and do nothing but relieve the protection raised
before. Otherwise, apply the cross talk suppression in the headset and
start the process.

Because the process spends a lot of time, there is an resource race issue
easily between the application and interruption. They will control codec
power and clock concurrently. In one situaiton, the jack is inserted when
playback, and then the application changes to headset device. The applica-
tion prepares the playback and interrupt handler raises work for cross
talk process together. For this case, the solution is that driver delays
soc jack report until cross talk process completes. The mechanism can
avoid application to do playback preparation before cross talk detection
is still working.
In another situaiton, the system suspends when playback. After resume, the
system restarts playback, and meanwhile jack detection restarts. The play-
back preparation and cross talk process triggered by interruptions happens
concurrently. For the case, the driver provides the semaphone to syn-
chronize the playback and interrupt handler. In order to avoid the play-
back interfered by cross talk process, the driver make the playback prepa-
ration halted until cross talk process finish. After codec resume, the
driver finds the codec dai is active, and then the driver raises the pro-
tection for cross talk function to avoid the playback recovers before
cross talk process finish.

The driver also provides cancel method to forcely cancel the cross talk
task and restores the configuration to original status. Before the codec
remove, ejection, or suspend, the driver is obliged to cancel the cross
talk detection process. It can reduce the risk of failure when quickly and
continually doing jack insertion and ejection.


Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 786 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/nau8825.h |  82 ++++-
 2 files changed, 865 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 9386624..4e7f29d 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/acpi.h>
 #include <linux/math64.h>
+#include <linux/semaphore.h>
 
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -37,6 +38,12 @@
 #define NAU_FVCO_MAX 124000000
 #define NAU_FVCO_MIN 90000000
 
+/* cross talk suppression detection */
+#define LOG10_MAGIC 646456993
+#define GAIN_AUGMENT 22500
+#define SIDETONE_BASE 207000
+
+
 static int nau8825_configure_sysclk(struct nau8825 *nau8825,
 		int clk_id, unsigned int freq);
 
@@ -162,6 +169,661 @@ static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_CHARGE_PUMP, 0x0 },
 };
 
+/* register backup table when cross talk detection */
+static struct reg_default nau8825_xtalk_baktab[] = {
+	{ NAU8825_REG_ADC_DGAIN_CTRL, 0 },
+	{ NAU8825_REG_HSVOL_CTRL, 0 },
+	{ NAU8825_REG_DACL_CTRL, 0 },
+	{ NAU8825_REG_DACR_CTRL, 0 },
+};
+
+static const unsigned short logtable[256] = {
+	0x0000, 0x0171, 0x02e0, 0x044e, 0x05ba, 0x0725, 0x088e, 0x09f7,
+	0x0b5d, 0x0cc3, 0x0e27, 0x0f8a, 0x10eb, 0x124b, 0x13aa, 0x1508,
+	0x1664, 0x17bf, 0x1919, 0x1a71, 0x1bc8, 0x1d1e, 0x1e73, 0x1fc6,
+	0x2119, 0x226a, 0x23ba, 0x2508, 0x2656, 0x27a2, 0x28ed, 0x2a37,
+	0x2b80, 0x2cc8, 0x2e0f, 0x2f54, 0x3098, 0x31dc, 0x331e, 0x345f,
+	0x359f, 0x36de, 0x381b, 0x3958, 0x3a94, 0x3bce, 0x3d08, 0x3e41,
+	0x3f78, 0x40af, 0x41e4, 0x4319, 0x444c, 0x457f, 0x46b0, 0x47e1,
+	0x4910, 0x4a3f, 0x4b6c, 0x4c99, 0x4dc5, 0x4eef, 0x5019, 0x5142,
+	0x526a, 0x5391, 0x54b7, 0x55dc, 0x5700, 0x5824, 0x5946, 0x5a68,
+	0x5b89, 0x5ca8, 0x5dc7, 0x5ee5, 0x6003, 0x611f, 0x623a, 0x6355,
+	0x646f, 0x6588, 0x66a0, 0x67b7, 0x68ce, 0x69e4, 0x6af8, 0x6c0c,
+	0x6d20, 0x6e32, 0x6f44, 0x7055, 0x7165, 0x7274, 0x7383, 0x7490,
+	0x759d, 0x76aa, 0x77b5, 0x78c0, 0x79ca, 0x7ad3, 0x7bdb, 0x7ce3,
+	0x7dea, 0x7ef0, 0x7ff6, 0x80fb, 0x81ff, 0x8302, 0x8405, 0x8507,
+	0x8608, 0x8709, 0x8809, 0x8908, 0x8a06, 0x8b04, 0x8c01, 0x8cfe,
+	0x8dfa, 0x8ef5, 0x8fef, 0x90e9, 0x91e2, 0x92db, 0x93d2, 0x94ca,
+	0x95c0, 0x96b6, 0x97ab, 0x98a0, 0x9994, 0x9a87, 0x9b7a, 0x9c6c,
+	0x9d5e, 0x9e4f, 0x9f3f, 0xa02e, 0xa11e, 0xa20c, 0xa2fa, 0xa3e7,
+	0xa4d4, 0xa5c0, 0xa6ab, 0xa796, 0xa881, 0xa96a, 0xaa53, 0xab3c,
+	0xac24, 0xad0c, 0xadf2, 0xaed9, 0xafbe, 0xb0a4, 0xb188, 0xb26c,
+	0xb350, 0xb433, 0xb515, 0xb5f7, 0xb6d9, 0xb7ba, 0xb89a, 0xb97a,
+	0xba59, 0xbb38, 0xbc16, 0xbcf4, 0xbdd1, 0xbead, 0xbf8a, 0xc065,
+	0xc140, 0xc21b, 0xc2f5, 0xc3cf, 0xc4a8, 0xc580, 0xc658, 0xc730,
+	0xc807, 0xc8de, 0xc9b4, 0xca8a, 0xcb5f, 0xcc34, 0xcd08, 0xcddc,
+	0xceaf, 0xcf82, 0xd054, 0xd126, 0xd1f7, 0xd2c8, 0xd399, 0xd469,
+	0xd538, 0xd607, 0xd6d6, 0xd7a4, 0xd872, 0xd93f, 0xda0c, 0xdad9,
+	0xdba5, 0xdc70, 0xdd3b, 0xde06, 0xded0, 0xdf9a, 0xe063, 0xe12c,
+	0xe1f5, 0xe2bd, 0xe385, 0xe44c, 0xe513, 0xe5d9, 0xe69f, 0xe765,
+	0xe82a, 0xe8ef, 0xe9b3, 0xea77, 0xeb3b, 0xebfe, 0xecc1, 0xed83,
+	0xee45, 0xef06, 0xefc8, 0xf088, 0xf149, 0xf209, 0xf2c8, 0xf387,
+	0xf446, 0xf505, 0xf5c3, 0xf680, 0xf73e, 0xf7fb, 0xf8b7, 0xf973,
+	0xfa2f, 0xfaea, 0xfba5, 0xfc60, 0xfd1a, 0xfdd4, 0xfe8e, 0xff47
+};
+
+static struct snd_soc_dai *nau8825_get_codec_dai(struct nau8825 *nau8825)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(nau8825->dapm);
+	struct snd_soc_component *component = &codec->component;
+	struct snd_soc_dai *codec_dai, *_dai;
+
+	list_for_each_entry_safe(codec_dai, _dai, &component->dai_list, list) {
+		if (!strncmp(codec_dai->name, NUVOTON_CODEC_DAI,
+			strlen(NUVOTON_CODEC_DAI)))
+			return codec_dai;
+	}
+	return NULL;
+}
+
+static bool nau8825_dai_is_active(struct nau8825 *nau8825)
+{
+	struct snd_soc_dai *codec_dai = nau8825_get_codec_dai(nau8825);
+
+	if (codec_dai) {
+		if (codec_dai->playback_active || codec_dai->capture_active)
+			return true;
+	}
+	return false;
+}
+
+/**
+ * nau8825_sema_acquire - acquire the semaphore of nau88l25
+ * @nau8825:  component to register the codec private data with
+ * @timeout: how long in jiffies to wait before failure or zero to wait
+ * until release
+ *
+ * Attempts to acquire the semaphore with number of jiffies. If no more
+ * tasks are allowed to acquire the semaphore, calling this function will
+ * put the task to sleep. If the semaphore is not released within the
+ * specified number of jiffies, this function returns.
+ * Acquires the semaphore without jiffies. If no more tasks are allowed
+ * to acquire the semaphore, calling this function will put the task to
+ * sleep until the semaphore is released.
+ * It returns if the semaphore was acquired.
+ */
+static void nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
+{
+	int ret;
+
+	if (timeout)
+		ret = down_timeout(&nau8825->xtalk_sem, timeout);
+	else
+		ret = down_interruptible(&nau8825->xtalk_sem);
+
+	if (ret < 0)
+		dev_warn(nau8825->dev, "Acquire semaphone fail\n");
+}
+
+/**
+ * nau8825_sema_release - release the semaphore of nau88l25
+ * @nau8825:  component to register the codec private data with
+ *
+ * Release the semaphore which may be called from any context and
+ * even by tasks which have never called down().
+ */
+static inline void nau8825_sema_release(struct nau8825 *nau8825)
+{
+	up(&nau8825->xtalk_sem);
+}
+
+/**
+ * nau8825_sema_reset - reset the semaphore for nau88l25
+ * @nau8825:  component to register the codec private data with
+ *
+ * Reset the counter of the semaphore. Call this function to restart
+ * a new round task management.
+ */
+static inline void nau8825_sema_reset(struct nau8825 *nau8825)
+{
+	nau8825->xtalk_sem.count = 1;
+}
+
+/**
+ * Ramp up the headphone volume change gradually to target level.
+ *
+ * @nau8825:  component to register the codec private data with
+ * @vol_from: the volume to start up
+ * @vol_to: the target volume
+ * @step: the volume span to move on
+ *
+ * The headphone volume is from 0dB to minimum -54dB and -1dB per step.
+ * If the volume changes sharp, there is a pop noise heard in headphone. We
+ * provide the function to ramp up the volume up or down by delaying 10ms
+ * per step.
+ */
+static void nau8825_hpvol_ramp(struct nau8825 *nau8825,
+	unsigned int vol_from, unsigned int vol_to, unsigned int step)
+{
+	unsigned int value, volume, ramp_up, from, to;
+
+	if (vol_from == vol_to || step == 0) {
+		return;
+	} else if (vol_from < vol_to) {
+		ramp_up = true;
+		from = vol_from;
+		to = vol_to;
+	} else {
+		ramp_up = false;
+		from = vol_to;
+		to = vol_from;
+	}
+	/* only handle volume from 0dB to minimum -54dB */
+	if (to > NAU8825_HP_VOL_MIN)
+		to = NAU8825_HP_VOL_MIN;
+
+	for (volume = from; volume < to; volume += step) {
+		if (ramp_up)
+			value = volume;
+		else
+			value = to - volume + from;
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_HSVOL_CTRL,
+			NAU8825_HPL_VOL_MASK | NAU8825_HPR_VOL_MASK,
+			(value << NAU8825_HPL_VOL_SFT) | value);
+		usleep_range(10000, 10500);
+	}
+	if (ramp_up)
+		value = to;
+	else
+		value = from;
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSVOL_CTRL,
+		NAU8825_HPL_VOL_MASK | NAU8825_HPR_VOL_MASK,
+		(value << NAU8825_HPL_VOL_SFT) | value);
+}
+
+/**
+ * Computes log10 of a value; the result is round off to 3 decimal. This func-
+ * tion takes reference to dvb-math. The source code locates as the following.
+ * Linux/drivers/media/dvb-core/dvb_math.c
+ *
+ * return log10(value) * 1000
+ */
+static u32 nau8825_intlog10_dec3(u32 value)
+{
+	u32 msb, logentry, significand, interpolation, log10val;
+	u64 log2val;
+
+	/* first detect the msb (count begins at 0) */
+	msb = fls(value) - 1;
+	/**
+	 *      now we use a logtable after the following method:
+	 *
+	 *      log2(2^x * y) * 2^24 = x * 2^24 + log2(y) * 2^24
+	 *      where x = msb and therefore 1 <= y < 2
+	 *      first y is determined by shifting the value left
+	 *      so that msb is bit 31
+	 *              0x00231f56 -> 0x8C7D5800
+	 *      the result is y * 2^31 -> "significand"
+	 *      then the highest 9 bits are used for a table lookup
+	 *      the highest bit is discarded because it's always set
+	 *      the highest nine bits in our example are 100011000
+	 *      so we would use the entry 0x18
+	 */
+	significand = value << (31 - msb);
+	logentry = (significand >> 23) & 0xff;
+	/**
+	 *      last step we do is interpolation because of the
+	 *      limitations of the log table the error is that part of
+	 *      the significand which isn't used for lookup then we
+	 *      compute the ratio between the error and the next table entry
+	 *      and interpolate it between the log table entry used and the
+	 *      next one the biggest error possible is 0x7fffff
+	 *      (in our example it's 0x7D5800)
+	 *      needed value for next table entry is 0x800000
+	 *      so the interpolation is
+	 *      (error / 0x800000) * (logtable_next - logtable_current)
+	 *      in the implementation the division is moved to the end for
+	 *      better accuracy there is also an overflow correction if
+	 *      logtable_next is 256
+	 */
+	interpolation = ((significand & 0x7fffff) *
+		((logtable[(logentry + 1) & 0xff] -
+		logtable[logentry]) & 0xffff)) >> 15;
+
+	log2val = ((msb << 24) + (logtable[logentry] << 8) + interpolation);
+	/**
+	 *      log10(x) = log2(x) * log10(2)
+	 */
+	log10val = (log2val * LOG10_MAGIC) >> 31;
+	/**
+	 *      the result is round off to 3 decimal
+	 */
+	return log10val / ((1 << 24) / 1000);
+}
+
+/**
+ * computes cross talk suppression sidetone gain.
+ *
+ * @sig_org: orignal signal level
+ * @sig_cros: cross talk signal level
+ *
+ * The orignal and cross talk signal vlues need to be characterized.
+ * Once these values have been characterized, this sidetone value
+ * can be converted to decibel with the equation below.
+ * sidetone = 20 * log (original signal level / crosstalk signal level)
+ *
+ * return cross talk sidetone gain
+ */
+static u32 nau8825_xtalk_sidetone(u32 sig_org, u32 sig_cros)
+{
+	u32 gain, sidetone;
+
+	if (unlikely(sig_org == 0) || unlikely(sig_cros == 0)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	sig_org = nau8825_intlog10_dec3(sig_org);
+	sig_cros = nau8825_intlog10_dec3(sig_cros);
+	if (sig_org >= sig_cros)
+		gain = (sig_org - sig_cros) * 20 + GAIN_AUGMENT;
+	else
+		gain = (sig_cros - sig_org) * 20 + GAIN_AUGMENT;
+	sidetone = SIDETONE_BASE - gain * 2;
+	sidetone /= 1000;
+
+	return sidetone;
+}
+
+static int nau8825_xtalk_baktab_index_by_reg(unsigned int reg)
+{
+	int index;
+
+	for (index = 0; index < ARRAY_SIZE(nau8825_xtalk_baktab); index++)
+		if (nau8825_xtalk_baktab[index].reg == reg)
+			return index;
+	return -EINVAL;
+}
+
+static void nau8825_xtalk_backup(struct nau8825 *nau8825)
+{
+	int i;
+
+	/* Backup some register values to backup table */
+	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++)
+		regmap_read(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
+				&nau8825_xtalk_baktab[i].def);
+}
+
+static void nau8825_xtalk_restore(struct nau8825 *nau8825)
+{
+	int i, volume;
+
+	/* Restore register values from backup table; When the driver restores
+	 * the headphone volumem, it needs recover to original level gradually
+	 * with 3dB per step for less pop noise.
+	 */
+	for (i = 0; i < ARRAY_SIZE(nau8825_xtalk_baktab); i++) {
+		if (nau8825_xtalk_baktab[i].reg == NAU8825_REG_HSVOL_CTRL) {
+			/* Ramping up the volume change to reduce pop noise */
+			volume = nau8825_xtalk_baktab[i].def &
+				NAU8825_HPR_VOL_MASK;
+			nau8825_hpvol_ramp(nau8825, 0, volume, 3);
+			continue;
+		}
+		regmap_write(nau8825->regmap, nau8825_xtalk_baktab[i].reg,
+				nau8825_xtalk_baktab[i].def);
+	}
+}
+
+static void nau8825_xtalk_prepare_dac(struct nau8825 *nau8825)
+{
+	/* Enable power of DAC path */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACR | NAU8825_ENABLE_DACL |
+		NAU8825_ENABLE_ADC | NAU8825_ENABLE_ADC_CLK |
+		NAU8825_ENABLE_DAC_CLK, NAU8825_ENABLE_DACR |
+		NAU8825_ENABLE_DACL | NAU8825_ENABLE_ADC |
+		NAU8825_ENABLE_ADC_CLK | NAU8825_ENABLE_DAC_CLK);
+	/* Prevent startup click by letting charge pump to ramp up and
+	 * change bump enable
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_JAMNODCLOW | NAU8825_CHANRGE_PUMP_EN,
+		NAU8825_JAMNODCLOW | NAU8825_CHANRGE_PUMP_EN);
+	/* Enable clock sync of DAC and DAC clock */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_RDAC,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN |
+		NAU8825_RDAC_FS_BCLK_ENB,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN);
+	/* Power up output driver with 2 stage */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L,
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L);
+	/* HP outputs not shouted to ground  */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L, 0);
+	/* Enable HP boost driver */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_HP_BOOST_DIS, NAU8825_HP_BOOST_DIS);
+	/* Enable class G compare path to supply 1.8V or 0.9V. */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
+		NAU8825_CLASSG_LDAC_EN | NAU8825_CLASSG_RDAC_EN,
+		NAU8825_CLASSG_LDAC_EN | NAU8825_CLASSG_RDAC_EN);
+}
+
+static void nau8825_xtalk_prepare_adc(struct nau8825 *nau8825)
+{
+	/* Power up left ADC and raise 5dB than Vmid for Vref  */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ANALOG_ADC_2,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_VMID_PLUS_0_5DB);
+}
+
+static void nau8825_xtalk_clock(struct nau8825 *nau8825)
+{
+	/* Recover FLL default value */
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL1, 0x0);
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL2, 0x3126);
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL3, 0x0008);
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL4, 0x0010);
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL5, 0x0);
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL6, 0x6000);
+	/* Enable internal VCO clock for detection signal generated */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+		NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN,
+		NAU8825_DCO_EN);
+	/* Given specific clock frequency of internal clock to
+	 * generate signal.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+		NAU8825_CLK_MCLK_SRC_MASK, 0xf);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
+		NAU8825_FLL_RATIO_MASK, 0x10);
+}
+
+static void nau8825_xtalk_prepare(struct nau8825 *nau8825)
+{
+	int volume, index;
+
+	/* Backup those registers changed by cross talk detection */
+	nau8825_xtalk_backup(nau8825);
+	/* Config IIS as master to output signal by codec */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_MASTER |
+		(0x2 << NAU8825_I2S_DRV_SFT) | 0x1);
+	/* Ramp up headphone volume to 0dB to get better performance and
+	 * avoid pop noise in headphone.
+	 */
+	index = nau8825_xtalk_baktab_index_by_reg(NAU8825_REG_HSVOL_CTRL);
+	if (index != -EINVAL) {
+		volume = nau8825_xtalk_baktab[index].def &
+				NAU8825_HPR_VOL_MASK;
+		nau8825_hpvol_ramp(nau8825, volume, 0, 3);
+	}
+	nau8825_xtalk_clock(nau8825);
+	nau8825_xtalk_prepare_dac(nau8825);
+	nau8825_xtalk_prepare_adc(nau8825);
+	/* Config channel path and digital gain */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACL_CTRL,
+		NAU8825_DACL_CH_SEL_MASK | NAU8825_DACL_CH_VOL_MASK,
+		NAU8825_DACL_CH_SEL_L | 0xab);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
+		NAU8825_DACR_CH_SEL_MASK | NAU8825_DACR_CH_VOL_MASK,
+		NAU8825_DACR_CH_SEL_R | 0xab);
+	/* Config cross talk parameters and generate the 23Hz sine wave with
+	 * 1/16 full scale of signal level for impedance measurement.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL,
+		NAU8825_IMM_THD_MASK | NAU8825_IMM_GEN_VOL_MASK |
+		NAU8825_IMM_CYC_MASK | NAU8825_IMM_DAC_SRC_MASK,
+		(0x9 << NAU8825_IMM_THD_SFT) | NAU8825_IMM_GEN_VOL_1_16th |
+		NAU8825_IMM_CYC_8192 | NAU8825_IMM_DAC_SRC_SIN);
+	/* RMS intrruption enable */
+	regmap_update_bits(nau8825->regmap,
+		NAU8825_REG_INTERRUPT_MASK, NAU8825_IRQ_RMS_EN, 0);
+	/* Power up left and right DAC */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL, 0);
+}
+
+static void nau8825_xtalk_clean_dac(struct nau8825 *nau8825)
+{
+	/* Disable HP boost driver */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_HP_BOOST_DIS, 0);
+	/* HP outputs shouted to ground  */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+		NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+	/* Power down left and right DAC */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL,
+		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL);
+	/* Enable the TESTDAC and  disable L/R HP impedance */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP |
+		NAU8825_BIAS_TESTDAC_EN, NAU8825_BIAS_TESTDAC_EN);
+	/* Power down output driver with 2 stage */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_HP_DRV_R | NAU8825_POWERUP_HP_DRV_L, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_POWER_UP_CONTROL,
+		NAU8825_POWERUP_INTEGR_R | NAU8825_POWERUP_INTEGR_L |
+		NAU8825_POWERUP_DRV_IN_R | NAU8825_POWERUP_DRV_IN_L, 0);
+	/* Disable clock sync of DAC and DAC clock */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_RDAC,
+		NAU8825_RDAC_EN | NAU8825_RDAC_CLK_EN, 0);
+	/* Disable charge pump ramp up function and change bump */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
+		NAU8825_JAMNODCLOW | NAU8825_CHANRGE_PUMP_EN, 0);
+	/* Disable power of DAC path */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACR | NAU8825_ENABLE_DACL |
+		NAU8825_ENABLE_ADC_CLK | NAU8825_ENABLE_DAC_CLK, 0);
+	if (!nau8825->irq)
+		regmap_update_bits(nau8825->regmap,
+			NAU8825_REG_ENA_CTRL, NAU8825_ENABLE_ADC, 0);
+}
+
+static void nau8825_xtalk_clean_adc(struct nau8825 *nau8825)
+{
+	/* Power down left ADC and restore voltage to Vmid */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ANALOG_ADC_2,
+		NAU8825_POWERUP_ADCL | NAU8825_ADC_VREFSEL_MASK, 0);
+}
+
+static void nau8825_xtalk_clean(struct nau8825 *nau8825)
+{
+	/* Enable internal VCO needed for interruptions */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
+	nau8825_xtalk_clean_dac(nau8825);
+	nau8825_xtalk_clean_adc(nau8825);
+	/* Clear cross talk parameters and disable */
+	regmap_write(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL, 0);
+	/* RMS intrruption disable */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_RMS_EN, NAU8825_IRQ_RMS_EN);
+	/* Recover default value for IIS */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_SLAVE);
+	/* Restore value of specific register for cross talk */
+	nau8825_xtalk_restore(nau8825);
+}
+
+static void nau8825_xtalk_imm_start(struct nau8825 *nau8825, int vol)
+{
+	/* Apply ADC volume for better cross talk performance */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_ADC_DGAIN_CTRL,
+				NAU8825_ADC_DIG_VOL_MASK, vol);
+	/* Disables JKTIP(HPL) DAC channel for right to left measurement.
+	 * Do it before sending signal in order to erase pop noise.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_TESTDACR_EN | NAU8825_BIAS_TESTDACL_EN,
+		NAU8825_BIAS_TESTDACL_EN);
+	switch (nau8825->xtalk_state) {
+	case NAU8825_XTALK_HPR_R2L:
+		/* Enable right headphone impedance */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP,
+			NAU8825_BIAS_HPR_IMP);
+		break;
+	case NAU8825_XTALK_HPL_R2L:
+		/* Enable left headphone impedance */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+			NAU8825_BIAS_HPR_IMP | NAU8825_BIAS_HPL_IMP,
+			NAU8825_BIAS_HPL_IMP);
+		break;
+	default:
+		break;
+	}
+	msleep(100);
+	/* Impedance measurement mode enable */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_IMM_MODE_CTRL,
+				NAU8825_IMM_EN, NAU8825_IMM_EN);
+}
+
+static void nau8825_xtalk_imm_stop(struct nau8825 *nau8825)
+{
+	/* Impedance measurement mode disable */
+	regmap_update_bits(nau8825->regmap,
+		NAU8825_REG_IMM_MODE_CTRL, NAU8825_IMM_EN, 0);
+}
+
+/* The cross talk measurement function can reduce cross talk across the
+ * JKTIP(HPL) and JKR1(HPR) outputs which measures the cross talk signal
+ * level to determine what cross talk reduction gain is. This system works by
+ * sending a 23Hz -24dBV sine wave into the headset output DAC and through
+ * the PGA. The output of the PGA is then connected to an internal current
+ * sense which measures the attenuated 23Hz signal and passing the output to
+ * an ADC which converts the measurement to a binary code. With two separated
+ * measurement, one for JKR1(HPR) and the other JKTIP(HPL), measurement data
+ * can be separated read in IMM_RMS_L for HSR and HSL after each measurement.
+ * Thus, the measurement function has four states to complete whole sequence.
+ * 1. Prepare state : Prepare the resource for detection and transfer to HPR
+ *     IMM stat to make JKR1(HPR) impedance measure.
+ * 2. HPR IMM state : Read out orignal signal level of JKR1(HPR) and transfer
+ *     to HPL IMM state to make JKTIP(HPL) impedance measure.
+ * 3. HPL IMM state : Read out cross talk signal level of JKTIP(HPL) and
+ *     transfer to IMM state to determine suppression sidetone gain.
+ * 4. IMM state : Computes cross talk suppression sidetone gain with orignal
+ *     and cross talk signal level. Apply this gain and then restore codec
+ *     configuration. Then transfer to Done state for ending.
+ */
+static void nau8825_xtalk_measure(struct nau8825 *nau8825)
+{
+	u32 sidetone;
+
+	switch (nau8825->xtalk_state) {
+	case NAU8825_XTALK_PREPARE:
+		/* In prepare state, set up clock, intrruption, DAC path, ADC
+		 * path and cross talk detection parameters for preparation.
+		 */
+		nau8825_xtalk_prepare(nau8825);
+		msleep(280);
+		/* Trigger right headphone impedance detection */
+		nau8825->xtalk_state = NAU8825_XTALK_HPR_R2L;
+		nau8825_xtalk_imm_start(nau8825, 0x00d2);
+		break;
+	case NAU8825_XTALK_HPR_R2L:
+		/* In right headphone IMM state, read out right headphone
+		 * impedance measure result, and then start up left side.
+		 */
+		regmap_read(nau8825->regmap, NAU8825_REG_IMM_RMS_L,
+			&nau8825->imp_rms[NAU8825_XTALK_HPR_R2L]);
+		dev_dbg(nau8825->dev, "HPR_R2L imm: %x\n",
+			nau8825->imp_rms[NAU8825_XTALK_HPR_R2L]);
+		/* Disable then re-enable IMM mode to update */
+		nau8825_xtalk_imm_stop(nau8825);
+		/* Trigger left headphone impedance detection */
+		nau8825->xtalk_state = NAU8825_XTALK_HPL_R2L;
+		nau8825_xtalk_imm_start(nau8825, 0x00ff);
+		break;
+	case NAU8825_XTALK_HPL_R2L:
+		/* In left headphone IMM state, read out left headphone
+		 * impedance measure result, and delay some time to wait
+		 * detection sine wave output finish. Then, we can calculate
+		 * the cross talk suppresstion side tone according to the L/R
+		 * headphone imedance.
+		 */
+		regmap_read(nau8825->regmap, NAU8825_REG_IMM_RMS_L,
+			&nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		dev_dbg(nau8825->dev, "HPL_R2L imm: %x\n",
+			nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		nau8825_xtalk_imm_stop(nau8825);
+		msleep(150);
+		nau8825->xtalk_state = NAU8825_XTALK_IMM;
+		break;
+	case NAU8825_XTALK_IMM:
+		/* In impedance measure state, the orignal and cross talk
+		 * signal level vlues are ready. The side tone gain is deter-
+		 * mined with these signal level. After all, restore codec
+		 * configuration.
+		 */
+		sidetone = nau8825_xtalk_sidetone(
+			nau8825->imp_rms[NAU8825_XTALK_HPR_R2L],
+			nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
+		dev_dbg(nau8825->dev, "cross talk sidetone: %x\n", sidetone);
+		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
+					(sidetone << 8) | sidetone);
+		nau8825_xtalk_clean(nau8825);
+		nau8825->xtalk_state = NAU8825_XTALK_DONE;
+		break;
+	default:
+		break;
+	}
+}
+
+static void nau8825_xtalk_work(struct work_struct *work)
+{
+	struct nau8825 *nau8825 = container_of(
+		work, struct nau8825, xtalk_work);
+
+	nau8825_xtalk_measure(nau8825);
+	/* To determine the cross talk side tone gain when reach
+	 * the impedance measure state.
+	 */
+	if (nau8825->xtalk_state == NAU8825_XTALK_IMM)
+		nau8825_xtalk_measure(nau8825);
+
+	/* Delay jack report until cross talk detection process
+	 * completed. It can avoid application to do playback
+	 * preparation before cross talk detection is still working.
+	 * Meanwhile, the protection of the cross talk detection
+	 * is released.
+	 */
+	if (nau8825->xtalk_state == NAU8825_XTALK_DONE) {
+		snd_soc_jack_report(nau8825->jack, nau8825->xtalk_event,
+				nau8825->xtalk_event_mask);
+		nau8825_sema_release(nau8825);
+		nau8825->xtalk_protect = false;
+	}
+}
+
+static void nau8825_xtalk_cancel(struct nau8825 *nau8825)
+{
+	/* If the xtalk_protect is true, that means the process is still
+	 * on going. The driver forces to cancel the cross talk task and
+	 * restores the configuration to original status.
+	 */
+	if (nau8825->xtalk_protect) {
+		cancel_work_sync(&nau8825->xtalk_work);
+		nau8825_xtalk_clean(nau8825);
+	}
+	/* Reset parameters for cross talk suppression function */
+	nau8825_sema_reset(nau8825);
+	nau8825->xtalk_state = NAU8825_XTALK_DONE;
+	nau8825->xtalk_protect = false;
+}
+
 static bool nau8825_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -674,6 +1336,9 @@ static void nau8825_eject_jack(struct nau8825 *nau8825)
 	struct snd_soc_dapm_context *dapm = nau8825->dapm;
 	struct regmap *regmap = nau8825->regmap;
 
+	/* Force to cancel the cross talk detection process */
+	nau8825_xtalk_cancel(nau8825);
+
 	snd_soc_dapm_disable_pin(dapm, "SAR");
 	snd_soc_dapm_disable_pin(dapm, "MICBIAS");
 	/* Detach 2kOhm Resistors from MICBIAS to MICGND1/2 */
@@ -776,6 +1441,11 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 
 	regmap_read(regmap, NAU8825_REG_GENERAL_STATUS, &jack_status_reg);
 	mic_detected = (jack_status_reg >> 10) & 3;
+	/* The JKSLV and JKR2 all detected in high impedance headset */
+	if (mic_detected == 0x3)
+		nau8825->high_imped = true;
+	else
+		nau8825->high_imped = false;
 
 	switch (mic_detected) {
 	case 0:
@@ -873,6 +1543,33 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
+			if (!nau8825->high_imped) {
+				/* Apply the cross talk suppression in the
+				 * headset without high impedance.
+				 */
+				if (!nau8825->xtalk_protect) {
+					/* Raise protection for cross talk de-
+					 * tection if no protection before.
+					 * The driver has to cancel the pro-
+					 * cess and restore changes if process
+					 * is ongoing when ejection.
+					 */
+					nau8825->xtalk_protect = true;
+					nau8825_sema_acquire(nau8825, 0);
+				}
+				/* Startup cross talk detection process */
+				nau8825->xtalk_state = NAU8825_XTALK_PREPARE;
+				schedule_work(&nau8825->xtalk_work);
+			} else {
+				/* The cross talk suppression shouldn't apply
+				 * in the headset with high impedance. Thus,
+				 * relieve the protection raised before.
+				 */
+				if (nau8825->xtalk_protect) {
+					nau8825_sema_release(nau8825);
+					nau8825->xtalk_protect = false;
+				}
+			}
 		} else {
 			dev_warn(nau8825->dev, "Headset completion IRQ fired but no headset connected\n");
 			nau8825_eject_jack(nau8825);
@@ -880,6 +1577,17 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 
 		event_mask |= SND_JACK_HEADSET;
 		clear_irq = NAU8825_HEADSET_COMPLETION_IRQ;
+		/* Record the interruption report event for driver to report
+		 * the event later. The jack report will delay until cross
+		 * talk detection process is done.
+		 */
+		if (nau8825->xtalk_state == NAU8825_XTALK_PREPARE) {
+			nau8825->xtalk_event = event;
+			nau8825->xtalk_event_mask = event_mask;
+		}
+	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
+		schedule_work(&nau8825->xtalk_work);
+		clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
 	} else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
 		NAU8825_JACK_INSERTION_DETECTED) {
 		/* One more step to check GPIO status directly. Thus, the
@@ -907,7 +1615,12 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	/* clears the rightmost interruption */
 	regmap_write(regmap, NAU8825_REG_INT_CLR_KEY_STATUS, clear_irq);
 
-	if (event_mask)
+	/* Delay jack report until cross talk detection is done. It can avoid
+	 * application to do playback preparation when cross talk detection
+	 * process is still working. Otherwise, the resource like clock and
+	 * power will be issued by them at the same time and conflict happens.
+	 */
+	if (event_mask && nau8825->xtalk_state == NAU8825_XTALK_DONE)
 		snd_soc_jack_report(nau8825->jack, event, event_mask);
 
 	return IRQ_HANDLED;
@@ -1077,6 +1790,16 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int nau8825_codec_remove(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	/* Cancel and reset cross tak suppresstion detection funciton */
+	nau8825_xtalk_cancel(nau8825);
+
+	return 0;
+}
+
 /**
  * nau8825_calc_fll_param - Calculate FLL parameters.
  * @fll_in: external clock provided to codec.
@@ -1265,12 +1988,21 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_MCLK:
+		/* Acquire the semaphone to synchronize the playback and
+		 * interrupt handler. In order to avoid the playback inter-
+		 * fered by cross talk process, the driver make the playback
+		 * preparation halted until cross talk process finish.
+		 */
+		nau8825_sema_acquire(nau8825, 2 * HZ);
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
 		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
 		/* MCLK not changed by clock tree */
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_MCLK_SRC_MASK, 0);
+		/* Release the semaphone. */
+		nau8825_sema_release(nau8825);
+
 		ret = nau8825_mclk_prepare(nau8825, freq);
 		if (ret)
 			return ret;
@@ -1295,16 +2027,34 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_FLL_MCLK:
+		/* Acquire the semaphone to synchronize the playback and
+		 * interrupt handler. In order to avoid the playback inter-
+		 * fered by cross talk process, the driver make the playback
+		 * preparation halted until cross talk process finish.
+		 */
+		nau8825_sema_acquire(nau8825, 2 * HZ);
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
 			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
+		/* Release the semaphone. */
+		nau8825_sema_release(nau8825);
+
 		ret = nau8825_mclk_prepare(nau8825, freq);
 		if (ret)
 			return ret;
 
 		break;
 	case NAU8825_CLK_FLL_BLK:
+		/* Acquire the semaphone to synchronize the playback and
+		 * interrupt handler. In order to avoid the playback inter-
+		 * fered by cross talk process, the driver make the playback
+		 * preparation halted until cross talk process finish.
+		 */
+		nau8825_sema_acquire(nau8825, 2 * HZ);
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
 			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
+		/* Release the semaphone. */
+		nau8825_sema_release(nau8825);
+
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
@@ -1312,8 +2062,17 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_FLL_FS:
+		/* Acquire the semaphone to synchronize the playback and
+		 * interrupt handler. In order to avoid the playback inter-
+		 * fered by cross talk process, the driver make the playback
+		 * preparation halted until cross talk process finish.
+		 */
+		nau8825_sema_acquire(nau8825, 2 * HZ);
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
 			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_FS);
+		/* Release the semaphone. */
+		nau8825_sema_release(nau8825);
+
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
@@ -1399,6 +2158,8 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		/* Cancel and reset cross talk detection funciton */
+		nau8825_xtalk_cancel(nau8825);
 		/* Turn off all interruptions before system shutdown. Keep the
 		 * interruption quiet before resume setup completes.
 		 */
@@ -1433,7 +2194,20 @@ static int nau8825_codec_resume(struct snd_soc_codec *codec)
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_cache_only(nau8825->regmap, false);
-	if (!nau8825_is_jack_inserted(nau8825->regmap)) {
+	if (nau8825_is_jack_inserted(nau8825->regmap)) {
+		/* If the jack is inserted, we need to check whether the play-
+		 * back is active before suspend. If active, the driver has to
+		 * raise the protection for cross talk function to avoid the
+		 * playback recovers before cross talk process finish. Other-
+		 * wise, the playback will be interfered by cross talk func-
+		 * tion. It is better to apply hardware related parameters
+		 * before starting playback or record.
+		 */
+		if (nau8825_dai_is_active(nau8825)) {
+			nau8825->xtalk_protect = true;
+			nau8825_sema_acquire(nau8825, 0);
+		}
+	} else {
 		/* Check the jack plug status directly. If the headset is un-
 		 * plugged during S3 when the chip has no power, there will
 		 * be no jack detection irq event after restarting jack detec-
@@ -1454,6 +2228,7 @@ static int nau8825_codec_resume(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
+	.remove = nau8825_codec_remove,
 	.set_sysclk = nau8825_set_sysclk,
 	.set_pll = nau8825_set_pll,
 	.set_bias_level = nau8825_set_bias_level,
@@ -1597,6 +2372,13 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 		return PTR_ERR(nau8825->regmap);
 	nau8825->dev = dev;
 	nau8825->irq = i2c->irq;
+	/* Initiate parameters, semaphone and work queue which are needed in
+	 * cross talk suppression measurment function.
+	 */
+	nau8825->xtalk_state = NAU8825_XTALK_DONE;
+	nau8825->xtalk_protect = false;
+	sema_init(&nau8825->xtalk_sem, 1);
+	INIT_WORK(&nau8825->xtalk_work, nau8825_xtalk_work);
 
 	nau8825_print_device_properties(nau8825);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 1100385..188c769 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -101,8 +101,13 @@
 #define NAU8825_ENABLE_DACR_SFT	10
 #define NAU8825_ENABLE_DACR	(1 << NAU8825_ENABLE_DACR_SFT)
 #define NAU8825_ENABLE_DACL_SFT	9
+#define NAU8825_ENABLE_DACL		(1 << NAU8825_ENABLE_DACL_SFT)
 #define NAU8825_ENABLE_ADC_SFT	8
 #define NAU8825_ENABLE_ADC		(1 << NAU8825_ENABLE_ADC_SFT)
+#define NAU8825_ENABLE_ADC_CLK_SFT	7
+#define NAU8825_ENABLE_ADC_CLK	(1 << NAU8825_ENABLE_ADC_CLK_SFT)
+#define NAU8825_ENABLE_DAC_CLK_SFT	6
+#define NAU8825_ENABLE_DAC_CLK	(1 << NAU8825_ENABLE_DAC_CLK_SFT)
 #define NAU8825_ENABLE_SAR_SFT	1
 
 /* CLK_DIVIDER (0x3) */
@@ -158,6 +163,7 @@
 /* INTERRUPT_MASK (0xf) */
 #define NAU8825_IRQ_OUTPUT_EN (1 << 11)
 #define NAU8825_IRQ_HEADSET_COMPLETE_EN (1 << 10)
+#define NAU8825_IRQ_RMS_EN (1 << 8)
 #define NAU8825_IRQ_KEY_RELEASE_EN (1 << 7)
 #define NAU8825_IRQ_KEY_SHORT_PRESS_EN (1 << 5)
 #define NAU8825_IRQ_EJECT_EN (1 << 2)
@@ -232,10 +238,13 @@
 
 /* I2S_PCM_CTRL2 (0x1d) */
 #define NAU8825_I2S_TRISTATE	(1 << 15) /* 0 - normal mode, 1 - Hi-Z output */
+#define NAU8825_I2S_DRV_SFT	12
+#define NAU8825_I2S_DRV_MASK	(0x3 << NAU8825_I2S_DRV_SFT)
 #define NAU8825_I2S_MS_SFT	3
 #define NAU8825_I2S_MS_MASK	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
+#define NAU8825_I2S_BLK_DIV_MASK	0x7
 
 /* ADC_RATE (0x2b) */
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
@@ -254,28 +263,72 @@
 #define NAU8825_DAC_OVERSAMPLE_128	2
 #define NAU8825_DAC_OVERSAMPLE_32	4
 
+/* ADC_DGAIN_CTRL (0x30) */
+#define NAU8825_ADC_DIG_VOL_MASK	0xff
+
 /* MUTE_CTRL (0x31) */
 #define NAU8825_DAC_ZERO_CROSSING_EN	(1 << 9)
 #define NAU8825_DAC_SOFT_MUTE	(1 << 9)
 
 /* HSVOL_CTRL (0x32) */
 #define NAU8825_HP_MUTE	(1 << 15)
+#define NAU8825_HP_MUTE_AUTO	(1 << 14)
+#define NAU8825_HPL_MUTE	(1 << 13)
+#define NAU8825_HPR_MUTE	(1 << 12)
+#define NAU8825_HPL_VOL_SFT	6
+#define NAU8825_HPL_VOL_MASK	(0x3f << NAU8825_HPL_VOL_SFT)
+#define NAU8825_HPR_VOL_SFT	0
+#define NAU8825_HPR_VOL_MASK	(0x3f << NAU8825_HPR_VOL_SFT)
+#define NAU8825_HP_VOL_MIN	0x36
 
 /* DACL_CTRL (0x33) */
 #define NAU8825_DACL_CH_SEL_SFT	9
 #define NAU8825_DACL_CH_SEL_MASK (0x1 << NAU8825_DACL_CH_SEL_SFT)
 #define NAU8825_DACL_CH_SEL_L    (0x0 << NAU8825_DACL_CH_SEL_SFT)
 #define NAU8825_DACL_CH_SEL_R    (0x1 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_VOL_MASK	0xff
 
 /* DACR_CTRL (0x34) */
 #define NAU8825_DACR_CH_SEL_SFT	9
 #define NAU8825_DACR_CH_SEL_MASK (0x1 << NAU8825_DACR_CH_SEL_SFT)
 #define NAU8825_DACR_CH_SEL_L    (0x0 << NAU8825_DACR_CH_SEL_SFT)
 #define NAU8825_DACR_CH_SEL_R    (0x1 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_VOL_MASK	0xff
+
+/* IMM_MODE_CTRL (0x4C) */
+#define NAU8825_IMM_THD_SFT		8
+#define NAU8825_IMM_THD_MASK		(0x3f << NAU8825_IMM_THD_SFT)
+#define NAU8825_IMM_GEN_VOL_SFT	6
+#define NAU8825_IMM_GEN_VOL_MASK	(0x3 << NAU8825_IMM_GEN_VOL_SFT)
+#define NAU8825_IMM_GEN_VOL_1_2nd	(0x0 << NAU8825_IMM_GEN_VOL_SFT)
+#define NAU8825_IMM_GEN_VOL_1_4th	(0x1 << NAU8825_IMM_GEN_VOL_SFT)
+#define NAU8825_IMM_GEN_VOL_1_8th	(0x2 << NAU8825_IMM_GEN_VOL_SFT)
+#define NAU8825_IMM_GEN_VOL_1_16th	(0x3 << NAU8825_IMM_GEN_VOL_SFT)
+
+#define NAU8825_IMM_CYC_SFT		4
+#define NAU8825_IMM_CYC_MASK		(0x3 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_1024		(0x0 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_2048		(0x1 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_4096		(0x2 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_CYC_8192		(0x3 << NAU8825_IMM_CYC_SFT)
+#define NAU8825_IMM_EN			(1 << 3)
+#define NAU8825_IMM_DAC_SRC_MASK	0x7
+#define NAU8825_IMM_DAC_SRC_BIQ	0x0
+#define NAU8825_IMM_DAC_SRC_DRC	0x1
+#define NAU8825_IMM_DAC_SRC_MIX	0x2
+#define NAU8825_IMM_DAC_SRC_SIN	0x3
 
 /* CLASSG_CTRL (0x50) */
 #define NAU8825_CLASSG_TIMER_SFT	8
 #define NAU8825_CLASSG_TIMER_MASK	(0x3f << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_1ms	(0x1 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_2ms	(0x2 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_8ms	(0x4 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_16ms	(0x8 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_32ms	(0x10 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_TIMER_64ms	(0x20 << NAU8825_CLASSG_TIMER_SFT)
+#define NAU8825_CLASSG_LDAC_EN		(0x1 << 2)
+#define NAU8825_CLASSG_RDAC_EN		(0x1 << 1)
 #define NAU8825_CLASSG_EN		(1 << 0)
 
 /* I2C_DEVICE_ID (0x58) */
@@ -284,7 +337,12 @@
 #define NAU8825_SOFTWARE_ID_NAU8825	0x0
 
 /* BIAS_ADJ (0x66) */
-#define NAU8825_BIAS_TESTDAC_EN	(0x3 << 8)
+#define NAU8825_BIAS_HPR_IMP		(1 << 15)
+#define NAU8825_BIAS_HPL_IMP		(1 << 14)
+#define NAU8825_BIAS_TESTDAC_SFT	8
+#define NAU8825_BIAS_TESTDAC_EN	(0x3 << NAU8825_BIAS_TESTDAC_SFT)
+#define NAU8825_BIAS_TESTDACR_EN	(0x2 << NAU8825_BIAS_TESTDAC_SFT)
+#define NAU8825_BIAS_TESTDACL_EN	(0x1 << NAU8825_BIAS_TESTDAC_SFT)
 #define NAU8825_BIAS_VMID	(1 << 6)
 #define NAU8825_BIAS_VMID_SEL_SFT	4
 #define NAU8825_BIAS_VMID_SEL_MASK	(3 << NAU8825_BIAS_VMID_SEL_SFT)
@@ -303,6 +361,11 @@
 #define NAU8825_POWERUP_ADCL	(1 << 6)
 
 /* RDAC (0x73) */
+#define NAU8825_RDAC_FS_BCLK_ENB	(1 << 15)
+#define NAU8825_RDAC_EN_SFT		12
+#define NAU8825_RDAC_EN		(0x3 << NAU8825_RDAC_EN_SFT)
+#define NAU8825_RDAC_CLK_EN_SFT	8
+#define NAU8825_RDAC_CLK_EN		(0x3 << NAU8825_RDAC_CLK_EN_SFT)
 #define NAU8825_RDAC_CLK_DELAY_SFT	4
 #define NAU8825_RDAC_CLK_DELAY_MASK	(0x7 << NAU8825_RDAC_CLK_DELAY_SFT)
 #define NAU8825_RDAC_VREF_SFT	2
@@ -347,12 +410,23 @@ enum {
 	NAU8825_CLK_FLL_FS,
 };
 
+/* Cross talk detection state */
+enum {
+	NAU8825_XTALK_PREPARE = 0,
+	NAU8825_XTALK_HPR_R2L,
+	NAU8825_XTALK_HPL_R2L,
+	NAU8825_XTALK_IMM,
+	NAU8825_XTALK_DONE,
+};
+
 struct nau8825 {
 	struct device *dev;
 	struct regmap *regmap;
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack *jack;
 	struct clk *mclk;
+	struct work_struct xtalk_work;
+	struct semaphore xtalk_sem;
 	int irq;
 	int mclk_freq; /* 0 - mclk is disabled */
 	int button_pressed;
@@ -371,6 +445,12 @@ struct nau8825 {
 	int key_debounce;
 	int jack_insert_debounce;
 	int jack_eject_debounce;
+	int high_imped;
+	int xtalk_state;
+	int xtalk_event;
+	int xtalk_event_mask;
+	bool xtalk_protect;
+	int imp_rms[NAU8825_XTALK_IMM];
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.6.4
