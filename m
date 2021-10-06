Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B51EC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:44:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A1661056
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3A1661056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D841697;
	Wed,  6 Oct 2021 13:43:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D841697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633520681;
	bh=yh7/jBE/ugWh6oZWpDa5qP4ZeP0z0wdFRiu0hv2Seik=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzW19Ffpezdeu3AVf5XW+E9bGG22jQf3PeHA2qVajlqWMszfdpMqfoSF1KAuEtQqd
	 qjrT7FpphwJ4oPWQYUZOtMEbEsxkgFZwek+b7Dz+lWiX0xL4RiGOcGMbHDB3HQ0hbX
	 3QQL3RYB7LidYl16fEBP2Pn/Xsqv9rIvRO2SpCKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59987F8053B;
	Wed,  6 Oct 2021 13:40:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EACDF80542; Wed,  6 Oct 2021 13:40:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3883F804FA
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3883F804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="vIvIxsF2"
Received: by mail-wr1-x42b.google.com with SMTP id e12so7919948wra.4
 for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2021 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4VxZXnKS9YtNHxd0gj3h59SMAN46hPXrE6hl+KuwiZE=;
 b=vIvIxsF2pwQzBNuJKckY6tMHMFGkQ5DulGrCNkNqiMAnqULXFYzRJ+E9tkXfmtKd9Z
 hDCUv9vSXZJXj2TVCeZA0zP9FlX5PEP5QeyZTZS5q92QbVBCmik/Jqrt5gEcyfQ/xRHh
 HuHBVXdcBdVKauXUq1kqOcJ/dyOrWO17FOZeLrMqg3+vs0nVf5Ec0tkBj8N2xh0Xdg3Q
 6dXoVqFHMfMgDrqETQc6obFH0b/kLjBleMZnmKPG/wTN3N76o+kaFwNJjVlLAtMOFhOE
 05iN9K/weAr0OX08gAqgdvusOFjdTI/JqD/P0Q7Ce2aBlhgkV1kea3jFgF+8JZmUESzR
 yfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4VxZXnKS9YtNHxd0gj3h59SMAN46hPXrE6hl+KuwiZE=;
 b=MWyaw7MZRvJDd2wC4J6v+4Tln6YiXI9T10I8YpmDXxrBI0q1mb1lokn4aV5ui99lsv
 igUXglA1jNMlogGZgX5FjekYMl4xyXmOin0Oh4K6sYDtOGRW8YdmjfYGVKS5vaW6gI4W
 iV2BXpxW4uw4NQDGAqCSAGcODhKlxZTXn+4trtvDcqbu1jYLHdm5AaYvm8zyMXhtUWB3
 JjO8HPdufm96nuPpzXjZev3hH5oZ/WUVS5gGx9rMolfAxkxYMPQ+hylv/S45lXk6zdS0
 cs+kUfrZqJDgO74N2AvSPmzIKjBK9bboawMWgxZS3jU2xQ9gqGez1GtoT3Th5qrS0Rxm
 lT3w==
X-Gm-Message-State: AOAM530eHBsg78KYJs7/0c6s7n8wQkewcxnjICXWV/VdIb7SlrJLj5RP
 WLud1Sm/57jQWcZWc1fSPbRZ+g==
X-Google-Smtp-Source: ABdhPJxDNW5At/6GgpVgHP7YFmWCnUdK8gdMMox46RpGnGldU7ZtxevnA/73jqsLFvoAvc35yqD/WA==
X-Received: by 2002:a05:600c:4f51:: with SMTP id
 m17mr9390021wmq.51.1633520420853; 
 Wed, 06 Oct 2021 04:40:20 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id n11sm5540110wmq.19.2021.10.06.04.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 04:40:20 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [PATCH v9 12/17] ASoC: qdsp6: audioreach: add Kconfig and Makefile
Date: Wed,  6 Oct 2021 12:39:45 +0100
Message-Id: <20211006113950.10782-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211006113950.10782-1-srinivas.kandagatla@linaro.org>
References: <20211006113950.10782-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
 plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
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

Now that all the code for audioreach and q6apm are in at this point to be
able to compile, start adding Kconfig and Makefile changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/qcom/Kconfig        | 4 ++++
 sound/soc/qcom/qdsp6/Makefile | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index cc7c1de2f1d9..5a693f83fd6c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -84,6 +84,9 @@ config SND_SOC_QDSP6_ASM_DAI
 	select SND_SOC_COMPRESS
 	tristate
 
+config SND_SOC_QDSP6_APM
+	tristate
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR
@@ -97,6 +100,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_ROUTING
 	select SND_SOC_QDSP6_ASM
 	select SND_SOC_QDSP6_ASM_DAI
+	select SND_SOC_QDSP6_APM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index a4191d395557..1a0803d97eec 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-q6dsp-common-objs := q6dsp-common.o q6dsp-lpass-ports.o q6dsp-lpass-clocks.o
+snd-q6apm-objs := q6apm.o audioreach.o
 
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += snd-q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
@@ -10,3 +11,5 @@ obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM_DAI) += q6asm-dai.o
+
+obj-$(CONFIG_SND_SOC_QDSP6_APM) += snd-q6apm.o
-- 
2.21.0

