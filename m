From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH RESEND 3/4] ASoC: fsl_esai: Bypass divider
	settings if clock requirement is not changed
Date: Tue, 6 May 2014 16:56:01 +0800
Message-ID: <6cc52fe6747c31b7c3971a2a2be11402ad23f36b.1399366227.git.Guangyu.Chen@freescale.com>
References: <cover.1399366227.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A6CA260816
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:54:37 +0200 (CEST)
In-Reply-To: <cover.1399366227.git.Guangyu.Chen@freescale.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We don't need to change those dividers if bclk and mclk remains the same
directions and values.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 7e1916e..dd0b171 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -39,6 +39,8 @@
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @hck_rate: clock rate of desired HCKx clock
+ * @sck_rate: clock rate of desired SCKx clock
+ * @hck_dir: the direction of HCKx pads
  * @sck_div: if using PSR/PM dividers for SCKx clock
  * @slave_mode: if fully using DAI slave mode
  * @synchronous: if using tx/rx synchronous mode
@@ -55,6 +57,8 @@ struct fsl_esai {
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 hck_rate[2];
+	u32 sck_rate[2];
+	bool hck_dir[2];
 	bool sck_div[2];
 	bool slave_mode;
 	bool synchronous;
@@ -213,6 +217,10 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned long clk_rate;
 	int ret;
 
+	/* Bypass divider settings if the requirement doesn't change */
+	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
+		return 0;
+
 	/* sck_div can be only bypassed if ETO/ERO=0 and SNC_SOC_CLOCK_OUT */
 	esai_priv->sck_div[tx] = true;
 
@@ -278,6 +286,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	esai_priv->sck_div[tx] = false;
 
 out:
+	esai_priv->hck_dir[tx] = dir;
 	esai_priv->hck_rate[tx] = freq;
 
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_ECR,
@@ -295,9 +304,10 @@ static int fsl_esai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	u32 hck_rate = esai_priv->hck_rate[tx];
 	u32 sub, ratio = hck_rate / freq;
+	int ret;
 
-	/* Don't apply for fully slave mode*/
-	if (esai_priv->slave_mode)
+	/* Don't apply for fully slave mode or unchanged bclk */
+	if (esai_priv->slave_mode || esai_priv->sck_rate[tx] == freq)
 		return 0;
 
 	if (ratio * freq > hck_rate)
@@ -320,8 +330,15 @@ static int fsl_esai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		return -EINVAL;
 	}
 
-	return fsl_esai_divisor_cal(dai, tx, ratio, true,
+	ret = fsl_esai_divisor_cal(dai, tx, ratio, true,
 			esai_priv->sck_div[tx] ? 0 : ratio);
+	if (ret)
+		return ret;
+
+	/* Save current bclk rate */
+	esai_priv->sck_rate[tx] = freq;
+
+	return 0;
 }
 
 static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
-- 
1.8.4
