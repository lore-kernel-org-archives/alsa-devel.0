Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D347CD8C9F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:31:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F0F16021A;
	Mon,  8 Jun 2026 13:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F0F16021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918296;
	bh=Q9CiSCpbrlysNjNdadEm+d6AwmaU+vEub4Zy77NpfiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=coJ/FIwBXb3b+U/9T8LhAEJN14C2mViQ2lGoxzNWlWSZSez8kNO9ooKWntUlM03O7
	 TOLIjVDS3YZ3jdbwhVvThfLAPwOQmLq9hE++ll8meHFSXSQeRZjNDOnahPG703g6Av
	 1k5Jf5+G04Dok/WRIpjBLywXB5b4mqXXlgsqyoZU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 748B7F80689; Mon,  8 Jun 2026 13:30:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19C07F8068E;
	Mon,  8 Jun 2026 13:30:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CD14F804F3; Mon,  8 Jun 2026 10:35:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=61.135.153.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907753;
	b=B/3LTSrWvvTfQmPUXnP7QjZv2+D8S1WXZXG12DOG+Ba3Wr501WXndrfjKGaT8UsrxU5p
	 s97LipizD9FsDGoj9dBbtlA3LWW3CoJ/oVBsEXnc8Xz6V+HxOkPwa54qctcl3I4dWovoK
	 2drpG/lXPi3BwgCeoRIzVQeKmFk2lpdb1OcgVmpWcejRB+dljMxeEU7YS9N7Ke3yVXNnb
	 E1KAfNbDajvV91GE29sChOsPfCUSDfe6jTmhJX6HzQJKW2E8zapSzBl82QmHrj67urlHe
	 kqb7gGvbkI3TEE8121PpRS9hySrUq9zXtxOe7bHVDda/SuZhOzSqrdCoVc3iDsjyX3A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907753;
	h=From:To:Subject:Date:Message-Id;
	bh=Q9CiSCpbrlysNjNdadEm+d6AwmaU+vEub4Zy77NpfiQ=;
	b=N24LZtWbXTRcXHBF7Uorbogwla7yd19m/FQ7E3v1XpXXQIW07CL7RnTh2tafGRtK0ucI
	 rHu6us4M4aRjntOiI0zk/5fUvDrQHp8KAsQx9XIm6fV4AbFVOmbXYyBOJ9uJPY1BY2onu
	 Jq2vfInx9yszR+1JIgWPyzwDoWIMDccwXO2YoAXdHXGTTKy3Ndt/wxWUmq+oK9s7Fs47e
	 CsBc0RifWSCiNVGPPggQTpA4A7TBfg22umvC8+vLSCNrkJkhVZFSKCWe/SMj3pEIvDU64
	 MZfADNnb7iJGwrmqZUzig9bU2skbhIQe7n2WW8lQRKTwLKtWdY6L9AV26LRJZXtG3Cw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=61.135.153.182
Received: from smtp153-182.sina.com.cn (smtp153-182.sina.com.cn
 [61.135.153.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4895FF80153
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4895FF80153
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:48 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 063491E7DCA444D29271C2B4BA647408
X-SMAIL-UIID: 063491E7DCA444D29271C2B4BA647408-20260608-163548
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 4/7] ASoC: codecs: ES8389: Modify the initial configuration
Date: Mon,  8 Jun 2026 16:35:37 +0800
Message-Id: <20260608083540.12581-5-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 56JH4VS7GDS5HKHOM3AKFUOMQXQ3EOPM
X-Message-ID-Hash: 56JH4VS7GDS5HKHOM3AKFUOMQXQ3EOPM
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/56JH4VS7GDS5HKHOM3AKFUOMQXQ3EOPM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Modify the initial configuration

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index cd8284da8c62..ad016c255c77 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -792,7 +792,7 @@ static void es8389_init(struct snd_soc_component *component)
 
 	regmap_read(es8389->regmap, ES8389_MAX_REGISTER, &reg);
 	es8389->version = reg;
-	regmap_write(es8389->regmap, ES8389_ISO_CTL, 0x00);
+	regmap_write(es8389->regmap, ES8389_ISO_CTL, 0x56);
 	regmap_write(es8389->regmap, ES8389_RESET, 0x7E);
 	regmap_write(es8389->regmap, ES8389_ISO_CTL, 0x38);
 	regmap_write(es8389->regmap, ES8389_ADC_HPF1, 0x64);
@@ -844,7 +844,7 @@ static void es8389_init(struct snd_soc_component *component)
 	regmap_write(es8389->regmap, ES8389_SCLK_DIV, 0x04);
 	regmap_write(es8389->regmap, ES8389_LRCK_DIV1, 0x01);
 	regmap_write(es8389->regmap, ES8389_LRCK_DIV2, 0x00);
-	regmap_write(es8389->regmap, ES8389_OSC_CLK, 0x00);
+	regmap_write(es8389->regmap, ES8389_OSC_CLK, 0x10);
 	regmap_write(es8389->regmap, ES8389_ADC_OSR, 0x1F);
 	regmap_write(es8389->regmap, ES8389_ADC_DSP, 0x7F);
 	regmap_write(es8389->regmap, ES8389_ADC_MUTE, 0xC0);
-- 
2.54.0.windows.1

