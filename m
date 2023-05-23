Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E184AC7EE2D
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 15:47:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D72991EC;
	Tue, 23 May 2023 17:47:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D72991EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684856876;
	bh=DZAJhfnYRSa7iGmUkW2ZPvzu87HPo+s2rOulnRFJEGc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mDWoZ+4aO25Z8Pe8uiwuvbHo2ppGrbw3NdW44D2ssMrLWaqXprvQOLXEV5B81YWm6
	 FdBoQzZJr4GEdepIrZnZ1VIuobx5/IfOv6vL6hZRvLjL85VmtLZQtdnuSiVY+8lRiR
	 uxPaeQh3NioCp5kna0vS/pk94AcTkzjpNjrXTGmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D01EF800DF; Tue, 23 May 2023 17:46:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE6FDF800DF;
	Tue, 23 May 2023 17:46:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19135F8026A; Tue, 23 May 2023 17:46:32 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7B312F80086
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 17:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B312F80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nWNoA6Sj
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6042d60b5so26592655e9.2
        for <alsa-devel@alsa-project.org>;
 Tue, 23 May 2023 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684856783; x=1687448783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRw2ALokx9vLy8rQUgzg1qNBvtdQEE/4htl4GPyFIo=;
        b=nWNoA6Sjt7sar6bT5Wo7aS7Yc7m34FIb/IPgWD81u2XmfxqZy8KlLpQjOWv16/jon5
         r9ollhVW6YH7NfbuUpGGiFI2PoQsBLoeInpaFEAFlbMtNr/hC+EMEAcNhtOpzJEyLd54
         7C+AXOqYLclUAvF/sNsb2Bph/vJoPsj+7wFJnrV9n36DSEjRrJ5DivQ7lCMZJVhG2E+x
         osQRnx+JV6XS7XazzwU6kFsLuDGgV0o3IEblDcwD6iDseVAZKJZb3xcMuuydJ0O53+D/
         1kAnyuwPYstnRQs46f5u26CXhFu20A3z+IeYSdm+azQaZs3NGE6eO/K3Ila8h2n5Gpqw
         TGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856783; x=1687448783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfRw2ALokx9vLy8rQUgzg1qNBvtdQEE/4htl4GPyFIo=;
        b=gPEY0V6p9FJL64uzhPvxcr95c1LyotVDgI0Qd/MDGUFhdaS6p27RFQdltRAR6FZV8S
         3KsTCSaPB1t2QWm0A4aQ+R/U3PNlwdxSsBnj4tjsBwo7+aIo3ntR31rUXO19ZcfWEcNH
         QOYBNNKXknu0SKGPogADJwyyoF7XzOuED4Tg+S9jdQhN5ceQWXw4fU8Zp3R/1wfGCbyu
         KaiKbYT3LZPeysIAu3gCzi9BomwsrHPWtmn2TU8pIbByutfjKvPzkadCCKh4aTRXglLY
         ncNwjhalwWk9hcIfnTEp635JwWveBuq/PyTTdrHFVxtnjurREovtJFUXxHbH/WLzI1tS
         rJCg==
X-Gm-Message-State: AC+VfDw69Y50ePrncbz3vLcM5d7PeNGxN0LXjuettXg3a+eDIXDMR3tN
	94zdjzuMH/4aQSsPRAwLbT+3Dw==
X-Google-Smtp-Source: 
 ACHHUZ71Rz/9C0SXOP97Z5WNP/e5538De6w5FC/OjCJcrWWF8rV5viic9V4O3MIuQsYQihYn5e5MXA==
X-Received: by 2002:a1c:e905:0:b0:3f5:fbd0:94ab with SMTP id
 q5-20020a1ce905000000b003f5fbd094abmr7809138wmc.3.1684856783483;
        Tue, 23 May 2023 08:46:23 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003f1978bbcd6sm3374063wmc.3.2023.05.23.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:46:22 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write flag
Date: Tue, 23 May 2023 16:46:04 +0100
Message-Id: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G6ZBEYNGQPEBNOBJOYSNAVXAA3HPJME3
X-Message-ID-Hash: G6ZBEYNGQPEBNOBJOYSNAVXAA3HPJME3
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G6ZBEYNGQPEBNOBJOYSNAVXAA3HPJME3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index b83b5b0d4bab..2faf66c60703 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -946,7 +946,6 @@ static struct regmap_config wsa883x_regmap_config = {
 	.writeable_reg = wsa883x_writeable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 	.use_single_read = true,
 };
 
-- 
2.21.0

