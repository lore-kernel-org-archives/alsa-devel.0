Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF62C2D0A6
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:43:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467722083B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cKiULoFH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1i4ipnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467722083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2D911AC2;
	Thu,  3 Sep 2020 22:42:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2D911AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165812;
	bh=+BRrs+1WRm+B7o1a0KJTJ/f7DnQsrAWTTc5Od/pyKok=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKiULoFHN0tq4vGkA7HpPA21//NXTMXy8s0HdVtlTUdCh2yZKjY2n3s0QcmdR4fhr
	 YZwqWwYhUG7Uxhhs0XAR/3/QpcgdVTsqbxSzO3TCzMArtAfKwEU9WvYONquKcg+4GU
	 IbB+YUgKRsewnT0DR+A00QEUDAztNFqpvM9FC81I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EAAAF80383;
	Thu,  3 Sep 2020 22:31:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DD99F8021D; Thu,  3 Sep 2020 22:31:39 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FCECF8021D
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FCECF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="B1i4ipnV"
Received: by mail-wm1-x343.google.com with SMTP id e11so6105459wme.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zzSizsn0JK1opavfeNDCJSC51EiA+520JWwYUTToFg8=;
 b=B1i4ipnViNrUEV2JHX8TUYJ3Z0gwvr/GwZEih3uo/PltUB7AlyF9ndTBtShkSn+gJg
 2OjNSLNClUh9Ic3lCV65+aG6L+ulDpX5Qh9bAEeHpqjv2V29KnHcj3N9sl234yaGX1vX
 OnTlhWoigt5UsIgpBVpyv6sibbZJWSITViQwbhoQdH7dZRoo1nEXEmpRq9Pdzy9bPhPN
 0zCF385PLtbxl0l/6NDEbHH1xO+kQ0QgouvCpdSYChZe1D6vhg+S491ZR1wr4OK7sNDV
 K6ujaMiPGauLpXatRIoeFxman5CJHybeZL1tenav9IwZ5419uEXT1Lxa+RKgfE4mwyqd
 UcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zzSizsn0JK1opavfeNDCJSC51EiA+520JWwYUTToFg8=;
 b=tPdFvI5ZN+jCvYQxfKNUwHrXBYXP3RHt/h0FhEEmMK1KdSDvY3LN9Sp3bZMFnSgQqz
 D9+i0z7dxmWFHL6HirFLuy9jZTS5P7zzKZ3s0/aF4uRC5RMwLu57d/NO9BhXLdeyUri9
 pbkAbJUPV8nbK3mnM43a8KxMQZPamGb0cbDPpngw2WZ1OvmcbZz4VDHQYuMl9MN4FcFa
 kcnmqmMAVO0sWS8XDW2C5yDpZNxe4gd2fEpQYaPPmdk3kWUGq8K0QOIGTuPrsIvbdOVB
 8LqgTL/PK1R/n9upJer8i7u7llv6HaMAh6ovER3/rkrgBY7sI/XcNb6uk9Ya7xDihmr1
 YZmw==
X-Gm-Message-State: AOAM532lDA+qCf0mN4ELFOO3PsKjrHeUM3rFl/R78yxmgNyCRh09eTYy
 93eLxXOPCESWNhjreJ5F3Rw=
X-Google-Smtp-Source: ABdhPJzdWnGyw9y0NOy0KkQZDlOL6GQL1RBDwzjesZGtBXIRxrFg1/S9SqdPLKpYayoQlmlIk++8TA==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4427918wmi.105.1599165051810; 
 Thu, 03 Sep 2020 13:30:51 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:51 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 07/20] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date: Thu,  3 Sep 2020 22:30:21 +0200
Message-Id: <20200903203034.1057334-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
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

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index df73cd5751c0..aa162e76d671 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1135,12 +1135,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

