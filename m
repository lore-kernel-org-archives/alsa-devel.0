Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36EC47254
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:03:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FC320735
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tXmKt1co";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsxKNGCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FC320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4648616F7;
	Tue,  5 May 2020 23:02:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4648616F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588712590;
	bh=ljoaQHBwZRHu55eF9o/cNmQXpqSs9ovlhMoT1Q+dd6M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXmKt1copTEPHr81FcffQNfd6XW8aprZNTQhYWEoDemY74GXydmkePlMXIloeJ7aE
	 o1Z4M1gx0If3vP7f1XmxXgxO+COXg+nX0HR5dDURlML52F1lBp1hSssG41XkzqPDX5
	 SwlXMKPdMNgSkBHYgdxu6/eSxie0dvI3fV7VdNJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5743EF80338;
	Tue,  5 May 2020 22:54:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7219F80339; Tue,  5 May 2020 22:54:31 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0097DF80335
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 22:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0097DF80335
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NsxKNGCU"
Received: by mail-qt1-x835.google.com with SMTP id q13so1902194qtp.7
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2020 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O6yBAiNRwLbkpZxa9KOV+ZDmKElx0U2cviHhXRUQNGw=;
 b=NsxKNGCUdggARJz/mfk2N4HT+aqIimMBDjtlcWUrwQYz4HglkqxdOhXsr84RcL/7Y0
 d6TJj9svmDDKEXipDBKhv5zWM3PBhuNEcrEalr3c2N0uZMNdS35tuLhcaQZajCqfjnG4
 uvFKzy5sqcoi20Sf1Gf+cYTUVbBjAHKJzT4FCc3j4Wh7OUvFXHhD9Z2nOL2W+zWo2DkZ
 iRU1yRfLWIb5rM6SXjDKPFZ+3Sl92aOqI3eZIA+Z5S8oo5vl3WaHpA2h/uGT5sHqeUel
 QG/+DwnKJ7IqX6um3JYYLEwheDfIjprny461DjST+9jHTmLEe7oB8XojwSfMua349pQK
 aQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O6yBAiNRwLbkpZxa9KOV+ZDmKElx0U2cviHhXRUQNGw=;
 b=FGqMUbuQpH067l4+M5Tix2e94StBPO9pOlXuZTr8zktb2+r1sQqtgwFUx8y81M5rGO
 /wVrrX8eTW0WXe0J7gxDOl+xx1AGNKMfTLj4PHuDqBT8Lt0oShUFhF2EsNqa67Kww6QP
 jJ8xTi5wwnBfzXUYrVsf+5eP7K7Q4XSRIyg9yNezKx4JXv3fsyxn3r9PUkYvC7RCx32x
 7vlYKyEz+4CfWQSp9O+SRLuFfC+ult/7Sa2Ti7qflY7YngIRAp8OUH/9AmBvPQiVoOY5
 MboP+3FweFo9QCNKA2LxeGbYLSGtlMbweTAcS+gUSVyHG8leJaLGhlxKTYckKphXLI5P
 CxTQ==
X-Gm-Message-State: AGi0PuZx0FgBzAh5EUynW89SnVkm3ONgyB0tcxLljgoIlcWpRC2+e8m0
 j20vdknR4WEzsY9HO7B1x6Gl63sg
X-Google-Smtp-Source: APiQypJREQ4KxzugHVapSE4JKpUKQ+PFdZiiDSCRnAYeJ2Rz8kRkh6jKARajtRHsqvpyBkl0hX0hrQ==
X-Received: by 2002:aed:221c:: with SMTP id n28mr4599469qtc.235.1588712066351; 
 Tue, 05 May 2020 13:54:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k58sm2972513qtf.40.2020.05.05.13.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 13:53:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, vijendar.mukunda@amd.com,
 tiwai@suse.de
Subject: [PATCH 14/14] ASoC: amd: enable build for RN machine driver
Date: Tue,  5 May 2020 16:53:27 -0400
Message-Id: <20200505205327.642282-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200505205327.642282-1-alexander.deucher@amd.com>
References: <20200505205327.642282-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

This patch enables build for RN machine driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/Kconfig         | 7 +++++++
 sound/soc/amd/renoir/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 5f57a47382b4..77ffdb41bee5 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -42,3 +42,10 @@ config SND_SOC_AMD_RENOIR
 	depends on X86 && PCI
 	help
 	 This option enables ACP support for Renoir platform
+
+config SND_SOC_AMD_RENOIR_MACH
+	tristate "AMD Renoir support for DMIC"
+	select SND_SOC_DMIC
+	depends on SND_SOC_AMD_RENOIR
+	help
+	 This option enables machine driver for DMIC
diff --git a/sound/soc/amd/renoir/Makefile b/sound/soc/amd/renoir/Makefile
index 43100515c7db..e4371932a55a 100644
--- a/sound/soc/amd/renoir/Makefile
+++ b/sound/soc/amd/renoir/Makefile
@@ -4,3 +4,4 @@ snd-rn-pci-acp3x-objs	:= rn-pci-acp3x.o
 snd-acp3x-pdm-dma-objs	:= acp3x-pdm-dma.o
 obj-$(CONFIG_SND_SOC_AMD_RENOIR)	 += snd-rn-pci-acp3x.o
 obj-$(CONFIG_SND_SOC_AMD_RENOIR)	 += snd-acp3x-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_RENOIR_MACH)	+= acp3x-rn.o
-- 
2.25.4

