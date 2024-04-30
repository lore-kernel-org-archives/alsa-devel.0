Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC34C19F53
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:05:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8017B1D9;
	Tue, 30 Apr 2024 16:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8017B1D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714485953;
	bh=ZJVoQsuYVbU6eX1WKifNhQyvCwwvs/Q4umjN6N4+yu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F6LgCmDyMyBcGN70Z+0g01V0weYkLqtkXiMczpMzsmnHGQVv7C1K5vFDq1/28BJR2
	 AeHKgSXy4nDcSsb9jT8WykQimkPMBGwwTarQ3Vsjm+hjreoYs9KdRPnuKuHq1wGEv4
	 hwp87lNc4WWiPpsa2d+aaAjtDSFV19NKfLRS+hRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86D79F806FA; Tue, 30 Apr 2024 16:03:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 596CBF806D5;
	Tue, 30 Apr 2024 16:03:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF15EF806AF; Tue, 30 Apr 2024 16:03:27 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7D268F8003A
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2024 16:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D268F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zkWk3XeV
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so7010186a12.1
        for <alsa-devel@alsa-project.org>;
 Tue, 30 Apr 2024 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485781; x=1715090581;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wnYPNchoJMJHPXPE9uqd4IXLQ1+2DNP0wbgQTer3qE=;
        b=zkWk3XeVLcJALYok9AKZUXmeiy6J2jUuwg+AGa8nClyn6rnmW4vm7UuHcHM4L1D2cC
         XPKKO+Y3conpf6FAjBfyAPlOoYZHFIBwNSSJYUrpqEWczYvVdLHG4MFINoaHYGnrRpXE
         me+vc1wYqc4sC7G5pUzrVooE1z7NhIalwDbv13ExpNi+jknca2hVEnxxXRE4IjY9ML6w
         IDYAh+ER8GqXBW91l695iBuIBNGGJNftxINEkydI9zqR9e6cOmYnMZgdKph5y+3iuwh0
         GD1G31uMBA0OgS6LCc6z3yFM509ob/Ekt+sZhdutd3rQu6hkW1mOFX4OQhSNEOicO/38
         KGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485781; x=1715090581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wnYPNchoJMJHPXPE9uqd4IXLQ1+2DNP0wbgQTer3qE=;
        b=dK0lLKQSUt2V3275MsAQwi6jLVsLQA+Tx28mctsWQUp/UZcMq3l7IZt1DsuVkDf0+m
         Nw1ibeOqpUUlQ6Z0ZOXkKLGOCr+oejKUCkBkAk/6ZDjYXEsZalVbXN+MO+dNRLkG40Vg
         RC5pcepet5h6AlsrA/T8lfnLiYQQN7P1I1tjDmWNlvYA/hFQI/cAh3ckc3EwekLgre4g
         hW0ogbPFVPjNDTRsSIObn3stx+51GTAp5mTvoJalihKDucfWODXbhkTLgpC5seLVdGuN
         a4gMkU0Gtvu5iVyFXq40SMpYYHoPE3ZEuvkvTt2f6LUFsRfQ8sLOFo9XqNj6sYq0UpUR
         yXqQ==
X-Gm-Message-State: AOJu0Yzs3v/oHH4qn6770pSWYcRcVmkAXGZo9EROCd4Q30+W/0Qn+QFf
	QpYq2C6C80NCT+yW9nEF42JWy65Ab/PU4PyHQkkdQF9tCtExxxxRLIaNuhvSprM=
X-Google-Smtp-Source: 
 AGHT+IHfqH0vbD3bQInQbBF2YUx3yEJaJuYtVm+BQiqXb8Xkd6Z+iJPnJ+JbD3G3lpGOTc/Xz5AyMg==
X-Received: by 2002:a17:907:76a4:b0:a58:94c1:88c9 with SMTP id
 jw4-20020a17090776a400b00a5894c188c9mr10358426ejc.54.1714485780892;
        Tue, 30 Apr 2024 07:03:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:03:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:16 +0200
Subject: [PATCH 07/13] ASoC: img: Use snd_soc_substream_to_rtd() for
 accessing private_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-7-6f8a8902b479@linaro.org>
References: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
In-Reply-To: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Ban Tao <fengzheng923@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZJVoQsuYVbU6eX1WKifNhQyvCwwvs/Q4umjN6N4+yu4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPnz7LqN72vQN5f6xW+8v1IAmdOUCMPS6bcOV
 4KOBcs83WmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD58wAKCRDBN2bmhouD
 12uLD/wJ78QXDNb2piUOxSHgAlHla7As9001viT+koWXU/H7+DT8NtdMhT51dhbsQHiwJTtlPtD
 v3rC/wbLFAMaGDIiWvpnu6k+B052j/BXEI/AehuKgv4cRWhNtPKvFOKq1xqdWsRw0716H2t9hFG
 2jji38Y55VThEkJU2s/2A+dyolipm/A2PYgxMVJTO2l5DA469GyAQo6sBIY2U/cunIB3Nd5iXjE
 Q3am7Lu9EXrAVEs3BW97SbLIHkYf0T5TAzmd8NGKPpDxyuCZXX18ORVI6i9N7ObF7t002ooK2kS
 ojdOtbdfw+8odlw1cUk0WmcG2BmcKgq60G25WepWhGsaV86YzAG4j0PmBLoDpKaIajgntlgaXru
 C59rV1W8tr/ZE1ju9NExCpppLGnkJdg1uS/O8ht/KxBbXbi7EIaeuB9CgaJ61HQpTjOo7fl4Wbf
 Rpr2d48ma59TnUEfG2V3VYPvbYQlMec8a+1gOtwjG9C7eGdUDWFPtphMaW/PQOdGdwQE6of966h
 08q8aydTVqPyc6BlBswO7GuRGZvbVbSjXzYlnWR3btBq5N/fAyyLJVZQAR/CLmHCNxuMnquGLnh
 Ki9ObapaRsHnKsbyLXLqmRwcEn/t2Ywexl6X3EbXj9/YMjD5OQJehn/bvQ8tFvT1+BObAtIFNxa
 lE5v1KAME9l6c0Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Message-ID-Hash: 7DDCGAE6QDITYIT2MM5VMFVYOTZZHZ5R
X-Message-ID-Hash: 7DDCGAE6QDITYIT2MM5VMFVYOTZZHZ5R
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7DDCGAE6QDITYIT2MM5VMFVYOTZZHZ5R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/img/img-i2s-in.c  | 2 +-
 sound/soc/img/img-i2s-out.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index dacc29fcf24b..b69a364d619e 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -395,7 +395,7 @@ static int img_i2s_in_dma_prepare_slave_config(struct snd_pcm_substream *st,
 	struct snd_pcm_hw_params *params, struct dma_slave_config *sc)
 {
 	unsigned int i2s_channels = params_channels(params) / 2;
-	struct snd_soc_pcm_runtime *rtd = st->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(st);
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	int ret;
 
diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index f442d985ab87..6f9831c6d6e0 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -401,7 +401,7 @@ static int img_i2s_out_dma_prepare_slave_config(struct snd_pcm_substream *st,
 	struct snd_pcm_hw_params *params, struct dma_slave_config *sc)
 {
 	unsigned int i2s_channels = params_channels(params) / 2;
-	struct snd_soc_pcm_runtime *rtd = st->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(st);
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	int ret;
 

-- 
2.43.0

