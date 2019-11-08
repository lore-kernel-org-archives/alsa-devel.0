Return-Path: <SRS0=kTGd=ZB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F4C43331
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:50:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5F521848
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h5WoaUR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9503E1678;
	Sat,  9 Nov 2019 10:49:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9503E1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573293009;
	bh=0ZiQlFwEZOuXLZbYOH+SD9Q6ax200MdE1m4IyyiBFXE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5WoaUR1kXfX6VtuzoCBdlBOOut9AD/frbYz3NKwznK2enAQ2Klde/lxsXgOenF9b
	 xZF9p7O06o1d2yEpPwm2M6vtvmxcGYjQm7h9akA+/vTGw2G3xkCGAeFeW3aWhCjYfY
	 aazR1apgxwdj+PgilhjqC2nRZRN6n7EQziSig9q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 795E3F8065C;
	Sat,  9 Nov 2019 10:44:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C9A1F8048D; Fri,  8 Nov 2019 18:49:04 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57A79F803D0
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 18:48:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57A79F803D0
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 0430B29134E
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0408E4800A5; Fri,  8 Nov 2019 18:48:54 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Date: Fri,  8 Nov 2019 18:48:43 +0100
Message-Id: <20191108174843.11227-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108174843.11227-1-sebastian.reichel@collabora.com>
References: <20191108174843.11227-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 09 Nov 2019 10:43:39 +0100
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: [alsa-devel] [PATCHv1 5/5] ASoC: da7213: add default clock handling
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This adds default clock/PLL configuration to the driver
for usage with generic drivers like simple-card for usage
with a fixed rate clock.

Upstreaming this requires a good way to disable the automatic
clock handling for systems doing it manually to avoid breaking
existing setups.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/da7213.c | 34 +++++++++++++++++++++++++++++++++-
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 197609691525..a4ed382ddfc7 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1163,6 +1163,8 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int freq = 0;
 	u8 dai_ctrl = 0;
 	u8 fs;
 
@@ -1188,38 +1190,54 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 		fs = DA7213_SR_8000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 11025:
 		fs = DA7213_SR_11025;
+		freq = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 12000:
 		fs = DA7213_SR_12000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 16000:
 		fs = DA7213_SR_16000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 22050:
 		fs = DA7213_SR_22050;
+		freq = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 32000:
 		fs = DA7213_SR_32000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 44100:
 		fs = DA7213_SR_44100;
+		freq = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 48000:
 		fs = DA7213_SR_48000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 88200:
 		fs = DA7213_SR_88200;
+		freq = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 96000:
 		fs = DA7213_SR_96000;
+		freq = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* setup PLL */
+	if (da7213->fixed_clk_auto) {
+		snd_soc_component_set_pll(component, 0, DA7213_SYSCLK_PLL,
+					  da7213->mclk_rate, freq);
+	}
+
 	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_WORD_LENGTH_MASK,
 			    dai_ctrl);
 	snd_soc_component_write(component, DA7213_SR, fs);
@@ -1700,10 +1718,10 @@ static struct da7213_platform_data
 	return pdata;
 }
 
-
 static int da7213_probe(struct snd_soc_component *component)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	pm_runtime_get_sync(component->dev);
 
@@ -1836,6 +1854,20 @@ static int da7213_probe(struct snd_soc_component *component)
 			return PTR_ERR(da7213->mclk);
 		else
 			da7213->mclk = NULL;
+	} else {
+		/* Store clock rate for fixed clocks for automatic PLL setup */
+		ret = clk_prepare_enable(da7213->mclk);
+		if (ret) {
+			dev_err(component->dev, "Failed to enable mclk\n");
+			return ret;
+		}
+
+		da7213->mclk_rate = clk_get_rate(da7213->mclk);
+
+		clk_disable_unprepare(da7213->mclk);
+
+		/* assume fixed clock until set_sysclk() is being called */
+		da7213->fixed_clk_auto = true;
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 97a250ea39e6..00aca0126cdb 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -532,6 +532,7 @@ struct da7213_priv {
 	bool master;
 	bool alc_calib_auto;
 	bool alc_en;
+	bool fixed_clk_auto;
 	struct da7213_platform_data *pdata;
 };
 
-- 
2.24.0.rc1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
