Return-Path: <SRS0=okCM=C5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC362C43463
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:10:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0540820829
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M+u+x8KO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbQmGy8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0540820829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 794BF1674;
	Sun, 20 Sep 2020 20:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 794BF1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600625442;
	bh=0uMJjcoh+v7O3ycDxnGACApaloI2rz7n+iKwoCsSDQE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+u+x8KObF39fTgHOMZ85wmTXQfpufyRNtvDQKfYddX8wi/VC5uwMrqBR4QOhCSO/
	 3pJbafr1jg+hFAp8J8NwU4rZrlqXoQdcdMfxpDN4P+nshRpLqMikhxCKJjdaAQezIP
	 vKZCxULtp8xvd7EG5GDB2+yqM4vBEteVqg5Be7TU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5050F802D2;
	Sun, 20 Sep 2020 20:08:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53EEEF802C3; Sun, 20 Sep 2020 20:08:18 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5723F80234
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2020 20:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5723F80234
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rbQmGy8/"
Received: by mail-wm1-x342.google.com with SMTP id e17so9970770wme.0
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vEHV1mvtoxOc6RfnQ/K6KV7HvIkD3k6AspYIp0zU0iE=;
 b=rbQmGy8/gZvujBAO0xznJrDT3RD8mpaq1L7GDarWMKT+SA6E+qlkgjxrN08GBuWFUo
 mCeect7gS/bp+5hf/jkLksCo3BANULXkLwbQJg7fvo+8dX1v8TXVrQEbaBgmnoIMU8st
 WWPBTTcg2g2suUDjJPTqfHSDEAmhxsBkaA6G7sPLll+w94Nx9S0rlvM1OWe54w9+XTTF
 mr4aj/TGjUDZPQQOkcsHlgQxsI/7TLsZD3sEfjbHBtdWQNikggNzUYtHUrqIwiQvmPlt
 TLbpJeqJG/vFKHx9Aq6EmawQghzVv+xoOJ7GFdHOHVAv/OUxGtNFmhbf0fZHwEszfWQN
 3YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vEHV1mvtoxOc6RfnQ/K6KV7HvIkD3k6AspYIp0zU0iE=;
 b=hC9L5HLdM00nBA97qRGvO/AgP5zRwj1PV3UZI6hbWsxtXu03OPHTPhznpc3HTFnhm9
 tcwTzSoj70bkPxBnkDuqZBUVnZVDFRr7zYG66XaXQqf1D2D996ozM1erF7EjeHgpU3L8
 yMk+7SyyQt3sqhY9I/fuNMXdbQ35skf81cQMscKtL6SomYnYgR/e+ZYtVv5gvF+hNiOO
 Yf494q2srX5xqoqvR3JXzNIsmIrVSO/dV+QBYP+6+4PQdWuMjMi/54rgVitl3idvB4UW
 1BCwEqn+zX/t+iDC2JXJ+DYc5D6e+cVHEyJ69okHONlbA9qS0oLmMvuK/aw7QmrGKfbF
 TIOA==
X-Gm-Message-State: AOAM5303XNTK7YiuBvm9VIdhJtYrHlYQe0WLIQvQcu/HVyiHuIhAAtJY
 sjFmmLhPeV9E8zHmtetREfc=
X-Google-Smtp-Source: ABdhPJynjCIkH84YYEMQOzwHd2jsYfTmhmUVjTKO1BgzcBTrvHNWezNxxN/Zu7AJ7CS11i7flg0eKQ==
X-Received: by 2002:a05:600c:ce:: with SMTP id
 u14mr27167924wmm.137.1600625288017; 
 Sun, 20 Sep 2020 11:08:08 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 11:08:07 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 02/19] ASoC: sun4i-i2s: Change set_chan_cfg params
Date: Sun, 20 Sep 2020 20:07:41 +0200
Message-Id: <20200920180758.592217-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

As slots and slot_width can be overwritter in case set_tdm() is
called. Avoid to have this logic in set_chan_cfg().

Instead pass the required values as params to set_chan_cfg().

This also fix a bug when i2s->slot_width is set for TDM but not
properly used in set_chan_cfg().

Suggested-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 348057464bed..246d4a45edae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -177,8 +177,8 @@ struct sun4i_i2s_quirks {
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
-	int	(*set_chan_cfg)(const struct sun4i_i2s *,
-				const struct snd_pcm_hw_params *);
+	int	(*set_chan_cfg)(const struct sun4i_i2s *, unsigned int,
+	                        unsigned int, unsigned int);
 	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
 };
 
@@ -414,10 +414,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				  const struct snd_pcm_hw_params *params)
+				  unsigned int channels, unsigned int slots,
+				  unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
@@ -434,15 +433,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 }
 
 static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				  const struct snd_pcm_hw_params *params)
+				  unsigned int channels, unsigned int slots,
+				  unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-	unsigned int slots = channels;
 	unsigned int lrck_period;
 
-	if (i2s->slots)
-		slots = i2s->slots;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
@@ -467,11 +462,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
-		lrck_period = params_physical_width(params) * slots;
+		lrck_period = slot_width * slots;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		lrck_period = slot_width;
 		break;
 
 	default:
@@ -490,15 +485,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 }
 
 static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				      const struct snd_pcm_hw_params *params)
+				      unsigned int channels, unsigned int slots,
+				      unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-	unsigned int slots = channels;
 	unsigned int lrck_period;
 
-	if (i2s->slots)
-		slots = i2s->slots;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
@@ -523,11 +514,11 @@ static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
-		lrck_period = params_physical_width(params) * slots;
+		lrck_period = slot_width * slots;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		lrck_period = slot_width;
 		break;
 
 	default:
@@ -563,7 +554,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (i2s->slot_width)
 		slot_width = i2s->slot_width;
 
-	ret = i2s->variant->set_chan_cfg(i2s, params);
+	ret = i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
 		return ret;
-- 
2.25.1

