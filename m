Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A6C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:04:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B5320715
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LOPGH+Oo";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgVeDome"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B5320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E9101687;
	Tue, 25 Aug 2020 13:04:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E9101687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598353497;
	bh=1uCCo+zRDac/TIKFujUUy8t9ULj+uQ5Pkv51R+kYyiU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LOPGH+OocMLg15JNkc47pYgo9PGTfDl9U0hBo+geix9kt7HC7CaUUzUSR/X7eRdWN
	 adG0syVTIgSceJBgXW8JaLxnHmiI+xgYOt2uVKkhDXS8wSBYgGl5XZ/5+UAr+Plxea
	 QfChJcqA4Ecv7r5b2cfkSWREUZ1lkHghr5CGW54o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7322DF802DD;
	Tue, 25 Aug 2020 13:01:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 126BCF801D9; Tue, 25 Aug 2020 00:46:09 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68B1DF800B8
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 00:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68B1DF800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YgVeDome"
Received: by mail-qv1-xf41.google.com with SMTP id v1so4666364qvn.3
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eAiEogNeolRoj2/VtKr8pVb7vPSSO2EkW9IVhYV3vjo=;
 b=YgVeDomeVr5sG7NWB5LRg75GNwmE+8AOdlkN6ZFMZJb4BxEGet2ceR5juK0V6jjbeR
 QD1xYb7GCdEYm42mNPZJcNUMt9v7S/Pu0W6fQkB0ggOJ+eJvY6XnLLB9ALn8TPvT5ZLb
 oKMlhHT7gL4rDvs9kJKuHpP7Po51wFHsjqDUn/ag4q+Uo5mHzNXHsEgLjfMdbbb5WBoB
 Ni6wrAE+EIa7RX23X2HNgIfw045lqpMZl40j5j9+DlVKIa7CEttk+u4FbmmQjB+cPNfF
 kCR5vpWpor9bMfK/1bS0+jzu6JdwaSoH8BnZYg88DfBPv5iHqhah+Tm7bIn0i5+f1qvT
 vz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eAiEogNeolRoj2/VtKr8pVb7vPSSO2EkW9IVhYV3vjo=;
 b=RwnVuwIs0K17Ukks0TE4+L8wvoMn3sAezzEgapb6PzBksWrxK1SUKt9969/S47+LyI
 mX0uZiu4+oPP7d6a/uwxQC0sh06wGnVQXPsYyy3J7r2tx72YMajTcYdSZPpzWUHJbT5w
 DBoyX0UYO52JMXeo3guxHGK4zhUi9kD5FR9zyRlis2PbHMmpioz+Ld3NWRC+kgXuL04L
 5lFXRqGbkxvoAAee9lW3eozWezPqG7I8kHRvn9Ha4re010Mz52OTm7eHHPeVn1VqTu23
 WKmGcx+UegMAx6CFVzArQBcft7ZsYSpr7Xs5MFPNaEKnqVRlpIM8eK3prP6jsHGi6nuh
 T3Pw==
X-Gm-Message-State: AOAM5303/T++Kn+ewgb1TAyzKdrEbJ7sIPtB7YBZEy4Y8C4rPj3iqmlD
 anl5d7ZhBxjNpZCADeXagyc=
X-Google-Smtp-Source: ABdhPJz9vCMVFc0A67rZn3gO+XapGv78ArS8GnlgkiZvXjrrLWmuQoS/DKcbg4Ac/+7E4eqhIols4w==
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr7160022qvo.178.1598309158933; 
 Mon, 24 Aug 2020 15:45:58 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:e9aa:e42d:21e4:5150])
 by smtp.googlemail.com with ESMTPSA id t12sm10421258qkt.56.2020.08.24.15.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 15:45:58 -0700 (PDT)
From: Tong Zhang <ztong0001@gmail.com>
To: perex@perex.cz, tiwai@suse.com, ztong0001@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ca0106: fix error code handling
Date: Mon, 24 Aug 2020 18:45:41 -0400
Message-Id: <20200824224541.1260307-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2020 13:01:32 +0200
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

snd_ca0106_spi_write() returns 1 on error, snd_ca0106_pcm_power_dac()
is returning the error code directly, and the caller is expecting an
negative error code

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/ca0106/ca0106_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 70d775ff967e..c189f70c82cb 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -537,7 +537,8 @@ static int snd_ca0106_pcm_power_dac(struct snd_ca0106 *chip, int channel_id,
 		else
 			/* Power down */
 			chip->spi_dac_reg[reg] |= bit;
-		return snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+		if (snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]) != 0)
+			return -ENXIO;
 	}
 	return 0;
 }
-- 
2.25.1

