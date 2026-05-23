Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6FACD5BB1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:14:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43A7960264;
	Tue, 26 May 2026 17:14:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43A7960264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808484;
	bh=okkyOXF4a8RjgOUA8PQCQ2GiBj+BIMC42Zv76UjtEcQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jzjgEl/iz6aVu7OppOFUTCN95T4IdFyMziJGI7aBNuYth4sdPO3gokEy8pql6ADUh
	 VTBYpSYrkuyqZKCnEyneRwohi3aPGMm4I3rGWJu7UKUqsNxM0sfip7z/OMv45X4anI
	 esn6IMbMCR1A4q+n38uIM7obRalzIEhbXXtkLooM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99A65F8060E; Tue, 26 May 2026 17:14:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D40DF80602;
	Tue, 26 May 2026 17:14:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDBEFF80557; Mon, 25 May 2026 12:21:03 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F926F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 12:21:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F926F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JVaU/w2V
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso1554803f8f.3
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704461; x=1780309261;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8I0wfEgf6M9ALaEduDiT9+DQW6EsZnPU3ZXbwt+Sm00=;
        b=JVaU/w2VklhhCmI6IMHBiLs0i2f7tOzz6F84VY4KnPzXkT5Rl57+3aoaYZFY5BMwRm
         bBp/3yKMixlKnME1RnnYt2W/VjL/QKALaPiFt4ZdF/2ZQABGxtaqreTDOMNhhw6YFsW5
         b0OQruqZkrUDlsAopZfWWetlISNmuBw1WC1oNjjnB376WuCDqbrSr4BSy7uF9OEgyoTy
         Exj1iope2GmhasQ830gpdU5RCzVRi5ZZI8pMSjASZ/hfvqyOA29eY4zNfq4WDKgqwBYQ
         DnFgV3w5cSuuRedr7cb9svG1N+GAwfOGLmTmXBZOLx9p5Rjm2UB2vyeS0Qnaxch2dvO/
         n6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704461; x=1780309261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I0wfEgf6M9ALaEduDiT9+DQW6EsZnPU3ZXbwt+Sm00=;
        b=OpiKCUitpwnoThyrybndIklZGSIari167gBwlJGTGvN578CPiUiqeZGlInOzAfgiNC
         Z01MBTdT5GY8ZIsigkt/ykVAUlKkr3m7SkJSl3ikE5CEhs0t8BppSRXDcgVrovIcrl+a
         wQHV6yIDhTIkt7FpK1W0KO4fokAwF/mUG8IefU26WT4IylqnHiL5XTyR66nd7uRIRUCp
         qiggn4TZFXWPoahWPCegpE3/bQaAgWkp0EdKTgI6sVXcZqFvD7Bc+Q6ay2VfbLJRbvH8
         QlCuHuOWZbFErZHhHKrNMU+qVVJJ77eaVqPRS3OFmDJC0BO0Wyr9j3Z3A5QEEKMmvghP
         D+NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IU3qrCYEGlRVxWzFkEkH+EpnH/RllvZpr/zJvwavfWLmzSzOMiyxVB5jQ6Hx2vpTYP3FEBRh3Usuv@alsa-project.org
X-Gm-Message-State: AOJu0Yz3VbhdFWkWcFLygbiz0KE58jKmHHn7bh3uYgZpMcyoW74I5AHd
	hujfIaYw5KG8h9i7PmzhNikG+1dLOfcBOYRB3Lx5G9bIoj+tYEpv87Mpd0lOoYTGZLk=
X-Gm-Gg: Acq92OHoom9yji+dt5pqz+P1zH5gVMd1lub6v2eZrCk3daxrfqjnH2jx0kYNcjr/QL+
	4gpsE4IT3tUDli1nRRsx3EBLyv2fPHJU9Iy4xkhHHBLtZDI5yE5vNeUGkU4o3hd0T6DJath/ISA
	OSnIeOxr4f5bBZEYID8PzmHsvP8Q33cS+EB2V7Lv3FJQ9+7A5YheOWwV95Fph7jNqT4BNHEbcNh
	w8xVlSPDUMTbL9KIr0Ode4lDXYfgB5tWXY3LvWAeyHAMQUiqpFInZA0EOMxkygi5B30679eyJtk
	giROJPD8l4jupqLIJHQ3kYV+cLUz3WCB6LwHkyuyTD7x2au0xsV2hA8mxRfU25R2BsaXViCMqNs
	hSI62X5N3jBQnBIbmMnQSZgnUXJWz3y6lbGkMEqipdyNHLM6hkJNlipkDRy+OIxMDXb3j+NY8Rg
	atG+4JFmkbnikoY8l/jh1Ujz+CtboEteGyunf/zj2zfdw21EPZUSQd2azgzorn
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-490426bc737mr141865515e9.19.1779554222778;
        Sat, 23 May 2026 09:37:02 -0700 (PDT)
Received: from joaom-cachyos ([2a01:b340:67:ff46:c6ec:ada0:af4a:a7a5])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm121826695e9.11.2026.05.23.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:37:02 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Miguel?= <jmiguel.ghp@gmail.com>
To: Vijendar.Mukunda@amd.com
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Jo=C3=A3o=20Miguel?= <joaomiguel.sapientia@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF
Date: Sat, 23 May 2026 17:36:52 +0100
Message-ID: <20260523163652.18499-1-jmiguel.ghp@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: jmiguel.ghp@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: STJZCFQ6LBZOFWBZ4JI4ME6ZVLBNTGUZ
X-Message-ID-Hash: STJZCFQ6LBZOFWBZ4JI4ME6ZVLBNTGUZ
X-Mailman-Approved-At: Tue, 26 May 2026 15:14:01 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/STJZCFQ6LBZOFWBZ4JI4ME6ZVLBNTGUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: João Miguel <joaomiguel.sapientia@gmail.com>

the board's internal DMIC is on the ACP6x and isn't detected without a DMI quirk entry; this adds it.
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 7a637d6b5..a93a7fd48 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -794,6 +794,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7601RM"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-17LN"),
+		}
+	},
 	{}
 };
 
-- 
2.54.0

