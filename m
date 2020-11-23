Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A3C56202
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 16:19:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A5521D93
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 16:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AU8Uxfje";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OiN2AJSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A5521D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03260165D;
	Mon, 23 Nov 2020 17:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03260165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606148360;
	bh=fk88Wakb3kgLAGpqBBQiDJl86UlQBgL0CUwV0xSUvlw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AU8UxfjegGBmMsawwmdFAVXUbKBf0JnbMc27aGAxSAkZAOCIalPjIHRSRSS5Tu3IQ
	 RJzClZhKKMHiEx/mHS1UuBwhixY7f3vBPTfnkTpEtAUXTHoWZ1rsKul6g0bpQYx5+/
	 2UvSoMEKJMgH1CZSgWh4xltFWBYbrnZem0er6xWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BF58F80128;
	Mon, 23 Nov 2020 17:18:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F390FF80255; Mon, 23 Nov 2020 17:18:27 +0100 (CET)
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11AF4F80128
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 17:18:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11AF4F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="OiN2AJSl"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606148302; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DCVdJ0U1/vf1/gv5yxYpLfd9aBdMYosbbp4vkMRvG0Y=;
 b=OiN2AJSlATS3OSwwhQLcl6nYenCr+XGLmEIv3sii4mrUWXEjrICFwm3cJnqoWN5/HwmFVB/U
 ZvPDuo6As0f1z5AlKNg/VDxdXvHsBwwH8lgSkt1v3AY0aOeXH7TGF7ilDHSSjl9hnIdyTMdw
 dIgaybKIYidnP6MkE773bjw8xRY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fbbe0c7d64ea0b70312d964 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 16:18:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5CA89C43460; Mon, 23 Nov 2020 16:18:14 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 29188C43462;
 Mon, 23 Nov 2020 16:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29188C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=srivasam@codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Asoc: qcom: Fix enabling BCLK and LRCLK in LPAIF invalid state
Date: Mon, 23 Nov 2020 21:47:53 +0530
Message-Id: <1606148273-17325-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Fix enabling BCLK and LRCLK only when LPAIF is invalid state and
bit clock in enable state.
In device suspend/resume scenario LPAIF is going to reset state.
which is causing LRCLK disable and BCLK enable.
Avoid such inconsitency by removing unnecessary cpu dai prepare API,
which is doing LRCLK enable, and by maintaining BLCK  state information.

Fixes: 7e6799d8f87d ("ASoC: qcom: lpass-cpu: Enable MI2S BCLK and LRCLK together")

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c       | 62 ++++++++++++++++++++--------------------
 sound/soc/qcom/lpass-lpaif-reg.h |  7 +++++
 sound/soc/qcom/lpass-platform.c  | 20 +++++++++++--
 sound/soc/qcom/lpass.h           |  1 +
 4 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index d33eae6..af684fd 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -263,28 +263,6 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
-	struct lpaif_i2sctl *i2sctl = drvdata->i2sctl;
-	unsigned int id = dai->driver->id;
-	int ret;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ret = regmap_fields_write(i2sctl->spken, id,
-					 LPAIF_I2SCTL_SPKEN_ENABLE);
-	} else {
-		ret = regmap_fields_write(i2sctl->micen, id,
-					 LPAIF_I2SCTL_MICEN_ENABLE);
-	}
-
-	if (ret)
-		dev_err(dai->dev, "error writing to i2sctl enable: %d\n", ret);
-
-	return ret;
-}
-
 static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
@@ -292,6 +270,18 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	struct lpaif_i2sctl *i2sctl = drvdata->i2sctl;
 	unsigned int id = dai->driver->id;
 	int ret = -EINVAL;
+	unsigned int val = 0;
+
+	ret = regmap_read(drvdata->lpaif_map,
+				LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id), &val);
+	if (ret) {
+		dev_err(dai->dev, "error reading from i2sctl reg: %d\n", ret);
+		return ret;
+	}
+	if (val == LPAIF_I2SCTL_RESET_STATE) {
+		dev_err(dai->dev, "error in i2sctl register state\n");
+		return -ENOTRECOVERABLE;
+	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -308,11 +298,14 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
 
-		ret = clk_enable(drvdata->mi2s_bit_clk[id]);
-		if (ret) {
-			dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
-			clk_disable(drvdata->mi2s_osr_clk[id]);
-			return ret;
+		if (drvdata->bit_clk_state[id] == LPAIF_BIT_CLK_DISABLE) {
+			ret = clk_enable(drvdata->mi2s_bit_clk[id]);
+			if (ret) {
+				dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
+				clk_disable(drvdata->mi2s_osr_clk[id]);
+				return ret;
+			}
+			drvdata->bit_clk_state[id] = LPAIF_BIT_CLK_ENABLE;
 		}
 
 		break;
@@ -329,7 +322,10 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 		if (ret)
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
-		clk_disable(drvdata->mi2s_bit_clk[dai->driver->id]);
+		if (drvdata->bit_clk_state[id] == LPAIF_BIT_CLK_ENABLE) {
+			clk_disable(drvdata->mi2s_bit_clk[dai->driver->id]);
+			drvdata->bit_clk_state[id] = LPAIF_BIT_CLK_DISABLE;
+		}
 		break;
 	}
 
@@ -341,7 +337,6 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
 	.startup	= lpass_cpu_daiops_startup,
 	.shutdown	= lpass_cpu_daiops_shutdown,
 	.hw_params	= lpass_cpu_daiops_hw_params,
-	.prepare	= lpass_cpu_daiops_prepare,
 	.trigger	= lpass_cpu_daiops_trigger,
 };
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_dai_ops);
@@ -459,16 +454,20 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 	struct lpass_variant *v = drvdata->variant;
 	int i;
 
+	for (i = 0; i < v->i2s_ports; ++i)
+		if (reg == LPAIF_I2SCTL_REG(v, i))
+			return true;
 	for (i = 0; i < v->irq_ports; ++i)
 		if (reg == LPAIF_IRQSTAT_REG(v, i))
 			return true;
 
 	for (i = 0; i < v->rdma_channels; ++i)
-		if (reg == LPAIF_RDMACURR_REG(v, i))
+		if (reg == LPAIF_RDMACURR_REG(v, i) || reg == LPAIF_RDMACTL_REG(v, i))
 			return true;
 
 	for (i = 0; i < v->wrdma_channels; ++i)
-		if (reg == LPAIF_WRDMACURR_REG(v, i + v->wrdma_channel_start))
+		if (reg == LPAIF_WRDMACURR_REG(v, i + v->wrdma_channel_start) ||
+			reg == LPAIF_WRDMACTL_REG(v, i + v->wrdma_channel_start))
 			return true;
 
 	return false;
@@ -861,6 +860,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
 			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
 		}
+		drvdata->bit_clk_state[dai_id] = LPAIF_BIT_CLK_DISABLE;
 	}
 
 	/* Allocation for i2sctl regmap fields */
diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 08f3fe5..4055428 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -60,6 +60,13 @@
 #define LPAIF_I2SCTL_BITWIDTH_24	1
 #define LPAIF_I2SCTL_BITWIDTH_32	2
 
+#define LPAIF_BIT_CLK_DISABLE		0
+#define LPAIF_BIT_CLK_ENABLE		1
+
+#define LPAIF_I2SCTL_RESET_STATE	0x003C0004
+#define LPAIF_DMACTL_RESET_STATE	0x00200000
+
+
 /* LPAIF IRQ */
 #define LPAIF_IRQ_REG_ADDR(v, addr, port) \
 	(v->irq_reg_base + (addr) + v->irq_reg_stride * (port))
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 7a3fdf8..80b09de 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -110,6 +110,7 @@ static int lpass_platform_pcmops_open(struct snd_soc_component *component,
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
+	component->id = dai_id;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -451,19 +452,34 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
 	unsigned int reg_irqclr = 0, val_irqclr = 0;
 	unsigned int  reg_irqen = 0, val_irqen = 0, val_mask = 0;
 	unsigned int dai_id = cpu_dai->driver->id;
+	unsigned int dma_ctrl_reg = 0;
 
 	ch = pcm_data->dma_ch;
 	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
 		id = pcm_data->dma_ch;
-		if (dai_id == LPASS_DP_RX)
+		if (dai_id == LPASS_DP_RX) {
 			dmactl = drvdata->hdmi_rd_dmactl;
-		else
+			map = drvdata->hdmiif_map;
+		} else {
 			dmactl = drvdata->rd_dmactl;
+			map = drvdata->lpaif_map;
+		}
 	} else {
 		dmactl = drvdata->wr_dmactl;
 		id = pcm_data->dma_ch - v->wrdma_channel_start;
+		map = drvdata->lpaif_map;
+	}
+	ret = regmap_read(map, LPAIF_DMACTL_REG(v, ch, dir, dai_id), &dma_ctrl_reg);
+	if (ret) {
+		dev_err(soc_runtime->dev, "error reading from rdmactl reg: %d\n", ret);
+		return ret;
 	}
 
+	if (dma_ctrl_reg == LPAIF_DMACTL_RESET_STATE ||
+		dma_ctrl_reg == LPAIF_DMACTL_RESET_STATE + 1) {
+		dev_err(soc_runtime->dev, "error in rdmactl register state\n");
+		return -ENOTRECOVERABLE;
+	}
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 32a68c4..0195372 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -68,6 +68,7 @@ struct lpass_data {
 	unsigned int mi2s_playback_sd_mode[LPASS_MAX_MI2S_PORTS];
 	unsigned int mi2s_capture_sd_mode[LPASS_MAX_MI2S_PORTS];
 	int hdmi_port_enable;
+	int bit_clk_state[LPASS_MAX_MI2S_PORTS];
 
 	/* low-power audio interface (LPAIF) registers */
 	void __iomem *lpaif;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

