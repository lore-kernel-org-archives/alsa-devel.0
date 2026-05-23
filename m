Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC571CD5BB1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:13:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F38E560251;
	Tue, 26 May 2026 17:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F38E560251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808431;
	bh=VilKTMUODu88Eqm2Pw4VrVCsM/0NxA5+oGoozbxftRg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CRe8jM9Jtj10DYefd11vea2g7LN4ltKbebUitHSSxfx6w2epFXrHy2B+OBnklMIQP
	 KDU8Z6OqFkrDy3f4+qI1jv5pK04qDwt9JYACjQGKjzLHuJ0IAY3ueM+QckHvbmVFjO
	 FM16VjIywnz2BPbB7UnEpPYzKUjMmOhQyDLv1+7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09AEEF80185; Tue, 26 May 2026 17:12:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D531AF80619;
	Tue, 26 May 2026 17:12:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9AEFF80557; Mon, 25 May 2026 11:29:39 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09C16F800C1
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 11:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09C16F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BVBCjaVR
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so5239605f8f.2
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779701377; x=1780306177;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/dF/BREYgluq2yc7QavjflbN1wLiPqAZu2uhlcXNI8=;
        b=BVBCjaVRJXMnyPyZ9c9m9Ny7xqaAZ7Idxnh+J7CrGUOAdm2NxoUiFZmLNjmST5i+Pv
         yvKww7OMnLp5hYkE1bA+ByVbr4bQM5prt0k490BZp/23myZkAcragPhTDBN1yhqozdKp
         FBpied5Pd/CLVsizMRIdXtd+bU258KRkXkeymTIK5g9a8B+6IdEaUwVIRyYYe3IKtqsY
         Ma8pEn+oa1YGOnLlq1lsAvFSClDHmUeOu2ieu4oFAbDM19PhZfE7mn3z4wtJ5Y8udxxc
         JBnu+NwFSx9mzht9ggva/tAIi8/pjaT2wnzFTnddr5a502QZF+AhkFAeE9bSoRBwlB3o
         Sshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701377; x=1780306177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/dF/BREYgluq2yc7QavjflbN1wLiPqAZu2uhlcXNI8=;
        b=gMROCj/aCgvF2ojvKZrrnaNflcB/8p43zMB+b+bNEmdyrcNLbTQodJ5MtPfCY7uq4P
         kd4TdpgaQzkNQDMr9FtKQ+z2SKKWCuEhQSB1z5YHVXWNAH0af3vxJ3NU9K/K2fcaxAg2
         kx/Yoxj0eGoUCosnu9UG1V6nHOvDdstt8bjNlFMrXqSjqv7WFApDL5+3RiNTkF8NVxyW
         AL990C9fmxv9+grjkaXQKqzIiccBK/Navszy1LP6CAIilCaL+NudF3zYCrzDD+JsJvPC
         NYsewEjU0sOydn/qC6Go3p0fdfzNfwuf4J+5w1biQoAnklRJ583hcBcO+JwUAxS0ikCV
         qjDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Nd8TL7zWhMQ6rMrDKhGKDASvcPZt2mSs8MDxOxV7N0aRkh60L52Jn4Ng6lCmuiymxcZxZcDhycU73@alsa-project.org
X-Gm-Message-State: AOJu0Yw5xOYKVmGOc/rsR35PwPZSu2QDe/Q0HcoPutuB1HSWV6+TLquA
	jBj87y6OuPNvUQi4iISKWllsBU9s9V8T63KM5wSZVB4JwP0xdamzLp1u+7/t/BKx
X-Gm-Gg: Acq92OHVfTK+BiUKcfyxm1csbyHY7Nx/VFZ/7qay7wzp3KmhcxKf61ZqfX11qiPPO17
	Gcnyoa2GlsnTU/TLqw0XfOFk+gzB2FVQh1iDmCGZKVS5YwCrQHL86wWOeGKAxBxDZXXim5IhVLX
	fpCsFhXMMOPx/U7wek4TpIQAEKKZwadCVNAPJimB6KQ53mJK6PZVLKvSaFejBAScOnSP32FtI1u
	8UWfCqsp994bT/RbY5MWX9kH7uXlEYN+6O/Vzpq+70kJV7xKsBbBqAl3nXxAhVCrpJfHZgbLtZR
	GwlTxifRMdhUMjkIwCObEUTa4it0jmJ3GG+NRbCyjtW5xzUX+LO4JeLS+N3MPUNtEuNa7ZfgeAZ
	SMdhy5o9Zq7+moTL/EgnUrJIw/jOzqaXAcaDKJyfkymBSoDH9ldJTk2QCBcCF38NliQHAi6IiBP
	ycaK7EugrXXR1gUdQ898R7o2lIK0nLmK3GQvgj9FjKOSh7DjCwoVV6TVBASuHE
X-Received: by 2002:a05:600c:4fc9:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-490424828aemr136469025e9.2.1779572186445;
        Sat, 23 May 2026 14:36:26 -0700 (PDT)
Received: from joaom-cachyos ([2a01:b340:65:3800:7f4c:52d5:740e:706e])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b1ab3sm156419135e9.14.2026.05.23.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 14:36:26 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Miguel?= <jmiguel.ghp@gmail.com>
To: Vijendar.Mukunda@amd.com
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Jo=C3=A3o=20Miguel?= <jmiguel.ghp@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF
Date: Sat, 23 May 2026 22:35:48 +0100
Message-ID: <20260523213548.5219-1-jmiguel.ghp@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: jmiguel.ghp@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IYGLMK7UO7HL2SJVQUA5Z5PWRXNRLUYZ
X-Message-ID-Hash: IYGLMK7UO7HL2SJVQUA5Z5PWRXNRLUYZ
X-Mailman-Approved-At: Tue, 26 May 2026 15:12:50 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYGLMK7UO7HL2SJVQUA5Z5PWRXNRLUYZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The MSI Bravo 17 C7VF routes its internal digital microphone through
the ACP6x. The machine driver only enables the DMIC for boards present
in the DMI quirk table, so on this model the internal mic is never
detected and no capture device is created.

Add a quirk entry matching the board's DMI identifiers so the DMIC is
enabled and the internal microphone works.

Signed-off-by: João Miguel <jmiguel.ghp@gmail.com>
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

