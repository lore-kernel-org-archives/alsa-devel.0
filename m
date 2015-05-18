From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 8/9] ASoC: sti: Add clock adjustement control
Date: Mon, 18 May 2015 14:12:55 +0200
Message-ID: <1431951176-24670-9-git-send-email-arnaud.pouliquen@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 454B9260881
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 14:13:30 +0200 (CEST)
In-Reply-To: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add capability to adjust player clock, for clocks drift management.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif.h        |   2 +-
 sound/soc/sti/uniperif_player.c | 149 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index c18584c..14f5595 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1196,7 +1196,7 @@ struct uniperif {
 
 	/* Specific to IEC958 player */
 	struct uniperif_iec958_settings stream_settings;
-	spinlock_t lock;  /* lock on resource updated by alsa controls */
+	spinlock_t lock;  /* lock on resource updated by alsa stream or controls */
 
 	/*alsa ctrl*/
 	struct snd_kcontrol_new *snd_ctrls;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index b41cc82..d8f83af 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -40,6 +40,9 @@
 	(UNIPERIF_PLAYER_TYPE_IS_HDMI(p) || \
 		UNIPERIF_PLAYER_TYPE_IS_SPDIF(p))
 
+#define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
+#define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
+
 /*
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
  * integrate  DAI_CPU capability in term of rate and supported channels
@@ -181,6 +184,70 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
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
@@ -512,6 +579,74 @@ static int uni_player_prepare_pcm(struct uniperif *player,
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
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = player->clk_adj;
+
+	return 0;
+}
+
+static int snd_sti_clk_adjustment_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	if ((ucontrol->value.integer.value[0] < UNIPERIF_PLAYER_CLK_ADJ_MIN) ||
+	    (ucontrol->value.integer.value[0] > UNIPERIF_PLAYER_CLK_ADJ_MAX))
+		return -EINVAL;
+
+	spin_lock(&player->lock);
+	player->clk_adj = ucontrol->value.integer.value[0];
+
+	if (player->rate)
+		ret = uni_player_clk_set_rate(player,
+					      player->rate * player->clk_div);
+	spin_unlock(&player->lock);
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
+static int uni_player_open(struct uniperif *player)
+{
+	spin_lock(&player->lock);
+	player->rate = 0;
+	player->clk_adj = 0;
+	spin_unlock(&player->lock);
+
+	return 0;
+}
+
 static int uni_player_prepare(struct uniperif *player,
 			      struct snd_pcm_runtime *runtime)
 {
@@ -605,12 +740,18 @@ static int uni_player_prepare(struct uniperif *player,
 	}
 
 	/* Set clock rate */
-	ret = clk_set_rate(player->clk, runtime->rate * player->clk_div);
+	spin_lock(&player->lock);
+	ret = uni_player_clk_set_rate(player,
+				      runtime->rate * player->clk_div);
 	if (ret) {
 		dev_err(player->dev, "Failed to set clock rate");
+		spin_unlock(&player->lock);
 		return ret;
 	}
 
+	player->rate = runtime->rate;
+	spin_unlock(&player->lock);
+
 	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(player, 0);
 
 	/* Reset uniperipheral player */
@@ -860,6 +1001,7 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 }
 
 const struct uniperif_ops uni_player_ops = {
+	.open = uni_player_open,
 	.close = uni_player_close,
 	.prepare = uni_player_prepare,
 	.trigger = uni_player_trigger
@@ -964,6 +1106,8 @@ int uni_player_init(struct platform_device *pdev, struct device_node *node,
 
 	*uni_player = player;
 
+	spin_lock_init(&player->lock);
+
 	/* Ensure that disabled by default */
 	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
 	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
@@ -990,6 +1134,9 @@ int uni_player_init(struct platform_device *pdev, struct device_node *node,
 					IEC958_AES4_CON_WORDLEN_24_20;
 	}
 
+	player->num_ctrls = ARRAY_SIZE(snd_sti_ctl);
+	player->snd_ctrls = snd_sti_ctl[0];
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_player_init);
-- 
1.9.1
