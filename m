From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: Add clock adjustement control" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:01:22 +0100
Message-ID: <E1ZFqHS-0001hh-Bm@finisterre>
References: <1437039367-30842-6-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ECAE2666E9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:31 +0200 (CEST)
In-Reply-To: <1437039367-30842-6-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: Add clock adjustement control

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

>From fa050796b35c80ac948c4d24c95262daa905e2ef Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 16 Jul 2015 11:36:06 +0200
Subject: [PATCH] ASoC: sti: Add clock adjustement control

Add capability to adjust player clock, for clocks drift management.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h        |   2 +
 sound/soc/sti/uniperif_player.c | 149 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index f1e583d..ee462f7 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1175,6 +1175,7 @@ struct uniperif {
 	/* Clocks */
 	struct clk *clk;
 	int mclk;
+	int clk_adj;
 
 	/* Runtime data */
 	enum uniperif_state state;
@@ -1183,6 +1184,7 @@ struct uniperif {
 
 	/* Specific to IEC958 player */
 	struct uniperif_iec958_settings stream_settings;
+	struct mutex ctrl_lock; /* For resource updated by stream and controls*/
 
 	/*alsa ctrl*/
 	struct snd_kcontrol_new *snd_ctrls;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d12d050..d990d2c 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -36,6 +36,9 @@
 	(UNIPERIF_PLAYER_TYPE_IS_HDMI(p) || \
 		UNIPERIF_PLAYER_TYPE_IS_SPDIF(p))
 
+#define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
+#define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
+
 /*
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
  * integrate  DAI_CPU capability in term of rate and supported channels
@@ -172,6 +175,70 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+int uni_player_clk_set_rate(struct uniperif *player, unsigned long rate)
+{
+	int rate_adjusted, rate_achieved, delta, ret;
+	int adjustment = player->clk_adj;
+
+	/*
+	 *             a
+	 * F = f + --------- * f = f + d
+	 *          1000000
+	 *
+	 *         a
+	 * d = --------- * f
+	 *      1000000
+	 *
+	 * where:
+	 *   f - nominal rate
+	 *   a - adjustment in ppm (parts per milion)
+	 *   F - rate to be set in synthesizer
+	 *   d - delta (difference) between f and F
+	 */
+	if (adjustment < 0) {
+		/* div64_64 operates on unsigned values... */
+		delta = -1;
+		adjustment = -adjustment;
+	} else {
+		delta = 1;
+	}
+	/* 500000 ppm is 0.5, which is used to round up values */
+	delta *= (int)div64_u64((uint64_t)rate *
+				(uint64_t)adjustment + 500000, 1000000);
+	rate_adjusted = rate + delta;
+
+	/* Adjusted rate should never be == 0 */
+	if (!rate_adjusted)
+		return -EINVAL;
+
+	ret = clk_set_rate(player->clk, rate_adjusted);
+	if (ret < 0)
+		return ret;
+
+	rate_achieved = clk_get_rate(player->clk);
+	if (!rate_achieved)
+		/* If value is 0 means that clock or parent not valid */
+		return -EINVAL;
+
+	/*
+	 * Using ALSA's adjustment control, we can modify the rate to be up
+	 * to twice as much as requested, but no more
+	 */
+	delta = rate_achieved - rate;
+	if (delta < 0) {
+		/* div64_64 operates on unsigned values... */
+		delta = -delta;
+		adjustment = -1;
+	} else {
+		adjustment = 1;
+	}
+	/* Frequency/2 is added to round up result */
+	adjustment *= (int)div64_u64((uint64_t)delta * 1000000 + rate / 2,
+				     rate);
+	player->clk_adj = adjustment;
+	return 0;
+}
+
 static void uni_player_set_channel_status(struct uniperif *player,
 					  struct snd_pcm_runtime *runtime)
 {
@@ -470,6 +537,78 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	return 0;
 }
 
+/*
+ * uniperif rate adjustement control
+ */
+static int snd_sti_clk_adjustment_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = UNIPERIF_PLAYER_CLK_ADJ_MIN;
+	uinfo->value.integer.max = UNIPERIF_PLAYER_CLK_ADJ_MAX;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+
+	ucontrol->value.integer.value[0] = player->clk_adj;
+
+	return 0;
+}
+
+static int snd_sti_clk_adjustment_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+	int ret = 0;
+
+	if ((ucontrol->value.integer.value[0] < UNIPERIF_PLAYER_CLK_ADJ_MIN) ||
+	    (ucontrol->value.integer.value[0] > UNIPERIF_PLAYER_CLK_ADJ_MAX))
+		return -EINVAL;
+
+	mutex_lock(&player->ctrl_lock);
+	player->clk_adj = ucontrol->value.integer.value[0];
+
+	if (player->mclk)
+		ret = uni_player_clk_set_rate(player, player->mclk);
+	mutex_unlock(&player->ctrl_lock);
+
+	return ret;
+}
+
+static struct snd_kcontrol_new uni_player_clk_adj_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name = "PCM Playback Oversampling Freq. Adjustment",
+	.info = snd_sti_clk_adjustment_info,
+	.get = snd_sti_clk_adjustment_get,
+	.put = snd_sti_clk_adjustment_put,
+};
+
+static struct snd_kcontrol_new *snd_sti_ctl[] = {
+	&uni_player_clk_adj_ctl,
+};
+
+static int uni_player_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+
+	player->clk_adj = 0;
+
+	return 0;
+}
+
 static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 				 unsigned int freq, int dir)
 {
@@ -483,9 +622,11 @@ static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	if (clk_id != 0)
 		return -EINVAL;
 
-	ret = clk_set_rate(player->clk, freq);
+	mutex_lock(&player->ctrl_lock);
+	ret = uni_player_clk_set_rate(player, freq);
 	if (!ret)
 		player->mclk = freq;
+	mutex_unlock(&player->ctrl_lock);
 
 	return ret;
 }
@@ -816,6 +957,7 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 }
 
 const struct snd_soc_dai_ops uni_player_dai_ops = {
+		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
 		.prepare = uni_player_prepare,
 		.trigger = uni_player_trigger,
@@ -863,6 +1005,8 @@ int uni_player_init(struct platform_device *pdev,
 	if (ret < 0)
 		return ret;
 
+	mutex_init(&player->ctrl_lock);
+
 	/* Ensure that disabled by default */
 	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
 	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
@@ -889,6 +1033,9 @@ int uni_player_init(struct platform_device *pdev,
 					IEC958_AES4_CON_WORDLEN_24_20;
 	}
 
+	player->num_ctrls = ARRAY_SIZE(snd_sti_ctl);
+	player->snd_ctrls = snd_sti_ctl[0];
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_player_init);
-- 
2.1.4
