Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89DC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 09:53:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE71661413
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 09:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE71661413
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E491D1689;
	Tue, 15 Jun 2021 11:52:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E491D1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623750818;
	bh=qt03VhLkPxvlNRkTZglKEWWOWNalIbNL2MWsCoHDins=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DNFhQju4XWERQVYUgUB0ug1O6io4pzzPBPcDQ64XrJ5H2MOrNWvuzFzRlClStAFlC
	 yNSgPN1Z7wn77wwNPB3/oR/P+OMS4Mmok4LRJTyaRare0JSnSRrAFqF5v4XDWiAQ5S
	 BZ1zsoSM+Ydf66/hsNOItXoGIzKqaOBXT2Ax45dg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97166F8049E;
	Tue, 15 Jun 2021 11:51:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7DB2F80218; Sat, 12 Jun 2021 22:07:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2014F800FA
 for <alsa-devel@alsa-project.org>; Sat, 12 Jun 2021 22:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2014F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com
 header.b="c8pQ+o+1"
Received: by mail-wm1-x331.google.com with SMTP id b205so5133509wmb.3
 for <alsa-devel@alsa-project.org>; Sat, 12 Jun 2021 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9LjSjYijj0EfqsEdoSIw7/BzTxcNazaz65qdvp2jts0=;
 b=c8pQ+o+1xZdLNWcyuWJ03l1ewGoL3lMIS6/vjwJllwwrYLVb2B6wuMxXKaiycDK79m
 5OpUhsPSyrkgNlt/hGhFbBesBpDWm7mazBZE/z5+6Hwkh2nUcXRz3JXhpmAx8KoaDr5D
 9boDu/ueOKhKYB8uLY1pVDDd6BmtL+Zf+q2omq7jyTwLd83riT5v+MGODd2WXmQiPwAj
 vU2+6x19wn0ik+ny6g7/LyDwq0U3Z7jFIG4v148tSdvhgGRbj5/TZLiENynDOWnamJRX
 DTrQsBmMd8wVPHn1mx7hN+tlOzLmzFuXK7SBXZwq9bVc0yMyjChv5HhGVvUsbkyuuEqB
 kVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9LjSjYijj0EfqsEdoSIw7/BzTxcNazaz65qdvp2jts0=;
 b=Vvhtx55Ds31VVhnlAMILFgf8upnBdmlMz+TOBT49UJ/BUjNiUWyM/HI7YRMDEn6XLv
 UBkxZVcuCj5EVl9Gyjvtia8x3ThfLqAWa6bFPStFvi/IO4Ll0nDnGdkUdGSma8l/FI91
 uRcDMwgr4C8PFDzI1SToanotdcL4/HkGi713RjSyWzbc/GUc7we0XVg3vRLHq61mTl6i
 FX2Db0ISyalwnkVm4/fLXxITKw9YkqXcOysU3pg19HPHtrKRxQ8b5oojFcPt62pvS+M3
 H2FA3+hJ/MmW46V3+RJfE4YknB2VIgYWZSK1n8eYnIMGnE53ZtFza3pEvo6RrFI/Xv2D
 lQRg==
X-Gm-Message-State: AOAM531BgKOMN/EuxBJmR1Zmd0k9FlHFMTtECP0iwGxOqdxW2bvMXPq9
 sWCi5POWmWDGsvjWm5j93CuHG55Rd88=
X-Google-Smtp-Source: ABdhPJzmy+LX9c5Oh4Zq9XpAlIR6k7Unme1vwt4gpaoD97v8U1+HgFkeMX5uW7GkIWAhXCbRaqV/0g==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr9257228wmf.86.1623528419402; 
 Sat, 12 Jun 2021 13:06:59 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a01-0c22-7608-e300-f22f-74ff-fe21-0725.c22.pool.telefonica.de.
 [2a01:c22:7608:e300:f22f:74ff:fe21:725])
 by smtp.googlemail.com with ESMTPSA id v17sm13716193wrp.36.2021.06.12.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jun 2021 13:06:59 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: alsa-devel@alsa-project.org
Subject: [RESEND PATCH] ASoC: rt5640: Make codec selectable
Date: Sat, 12 Jun 2021 22:06:50 +0200
Message-Id: <20210612200650.1301661-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jun 2021 11:51:53 +0200
Cc: lgirdwood@gmail.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
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

The Realtek rt5640 codec driver can be used with the generic sound card
drivers, so it should be selectable. For example, with the addition
of #sound-dai-cells = <0> property in DT, it can be used with simple and
graph card drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Re-sent because my last mail did not make it to the list

This will be used in arch/arm/boot/dts/meson8b-ec100.dts


 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a7b3e363069..96fc0144f9fc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1180,7 +1180,7 @@ config SND_SOC_RT5631
 	depends on I2C
 
 config SND_SOC_RT5640
-	tristate
+	tristate "Realtek RT5640/RT5639 Codec"
 	depends on I2C
 
 config SND_SOC_RT5645
-- 
2.31.1

