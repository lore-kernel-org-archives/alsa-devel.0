From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: fix kernel doc descriptions" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:28 +0000 (GMT)
Message-ID: <20190107185828.1AF941127491@debutante.sirena.org.uk>
References: <20190105020249.8639-5-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, liam.r.girdwood@linux.intel.com, Yangtao Li <tiny.windzz@gmail.com>broonie@kernel.org, Bard Liao <bardliao@realtek.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: fix kernel doc descriptions

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

>From dc22a4093f5d2973bef5f72b00da74ce61458bc0 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:32 -0600
Subject: [PATCH] ASoC: codecs: fix kernel doc descriptions

Missing or spurious parameter descriptions. Fix warnings with W=1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 1 +
 sound/soc/codecs/rt5514.c  | 1 +
 sound/soc/codecs/rt5677.c  | 8 ++++----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7bbcbf5f05c8..47e65cf99879 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -351,6 +351,7 @@ static void nau8825_hpvol_ramp(struct nau8825 *nau8825,
  * Computes log10 of a value; the result is round off to 3 decimal. This func-
  * tion takes reference to dvb-math. The source code locates as the following.
  * Linux/drivers/media/dvb-core/dvb_math.c
+ * @value:  input for log10
  *
  * return log10(value) * 1000
  */
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a67de68b6da6..f9ad6e36ab16 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -489,6 +489,7 @@ static const struct snd_kcontrol_new rt5514_sto2_dmic_mux =
 /**
  * rt5514_calc_dmic_clk - Calculate the frequency divider parameter of dmic.
  *
+ * @component: only used for dev_warn
  * @rate: base clock rate.
  *
  * Choose divider parameter that gives the highest possible DMIC frequency in
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9b7a1833d331..6fc70e441458 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -547,7 +547,7 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
  * @rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
- *
+ * @opcode: opcode value
  *
  * Returns 0 for success or negative error code.
  */
@@ -602,7 +602,7 @@ static int rt5677_dsp_mode_i2c_write_addr(struct rt5677_priv *rt5677,
 
 /**
  * rt5677_dsp_mode_i2c_read_addr - Read value from address on DSP mode.
- * rt5677: Private Data.
+ * @rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
  *
@@ -651,7 +651,7 @@ static int rt5677_dsp_mode_i2c_read_addr(
 
 /**
  * rt5677_dsp_mode_i2c_write - Write register on DSP mode.
- * rt5677: Private Data.
+ * @rt5677: Private Data.
  * @reg: Register index.
  * @value: Register data.
  *
@@ -667,7 +667,7 @@ static int rt5677_dsp_mode_i2c_write(struct rt5677_priv *rt5677,
 
 /**
  * rt5677_dsp_mode_i2c_read - Read register on DSP mode.
- * @codec: SoC audio codec device.
+ * @rt5677: Private Data
  * @reg: Register index.
  * @value: Register data.
  *
-- 
2.20.1
