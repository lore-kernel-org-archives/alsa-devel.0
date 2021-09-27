Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C51C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 14:03:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB3860F46
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 14:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEB3860F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D15616AE;
	Mon, 27 Sep 2021 16:02:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D15616AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632751390;
	bh=9K+E+SK+vqoojgaPu5KBpOFt1eYjOH0PyEpX/wx2YH8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vGTq17YI+zqsI3xpzyI3ki9lsC84oN3mc+UDYr0FGnY1+frN8IXCjQpjZ0awbP3vx
	 zhfViDvJqpqV2mp9w+yEr7DhjPBOYidYzjxnaa6Xsv/qwjxZrAfpEAvrdU+D9SqpXN
	 XvjdWhBjKnQWp5JZRpcBo6DeG04mAR1lTfO8U3Go=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F05D3F80571;
	Mon, 27 Sep 2021 15:57:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 004D3F8051F; Mon, 27 Sep 2021 15:57:05 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38720F8051F
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 15:56:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38720F8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MZqn6lsy"
Received: by mail-wm1-x32d.google.com with SMTP id
 r11-20020a1c440b000000b0030cf0f01fbaso31416wma.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZbocYYAT3Bv95I3T0qjmMa3P6s7bL467iC3FMXh3uYY=;
 b=MZqn6lsy09eZA5BRHm7bSocPvdWE4E10KdE8VJtqui5H0zLD/0MwrGLsbV0Kchr6Yw
 QlJqpm7WKoqqwVOE4x7g/Pd6p9Fy9BpGfVtWQ9XDKZV5oFm1dZTemadl7UMCtJozjUBx
 ETboa48Sj542X8I5yheH3MlPIE3cLe2XEi5owp0oLwsgurBBH502SO22eKmEs66rRZ5b
 emn4qr0n49G9cpKfmMroucN4jvzkMpB3WNfmiF9NFgMqmj056LmpjZxAGb/oP5JHEG6s
 Q84TZrMMsLnFgeyH/5+W4TNU1iRUQBPBRoMWu5Q6EIMfD93a2vKk0ZgBubhjOXY5ThPE
 /5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZbocYYAT3Bv95I3T0qjmMa3P6s7bL467iC3FMXh3uYY=;
 b=ApnVIyE0IFAZgb+/bvi+c38zKfTl2QnbpfhEUNh2AeMP0PNuW/nBYniErfUZfwP1IM
 h2juWERcGmGa2+2yEDgt/Pb4A75cwVojPQUH5japGPvRx/F2vDNoaFNZHNwtMTkZUUCp
 fVBVtiu6phsX7dTgYLRek8xgmuizc37yquR91fzAmEMtqWuLfIuQoQenDCkb7wX6iosF
 +jCbgKElxt4A4pGg0rgH/yCbMogyMNq/3/qCwFGYu8AR/VXiq2M/HCBzOLJFknyXGiN9
 Rb7N+u7QWBhACoQaa/w5ll5JQw86T5O8covRpzdPVw+jGMk1Jnt0WokgN8wbCL5pT1cl
 JRGQ==
X-Gm-Message-State: AOAM5307Xkpjc18gFPD6/YyZ5IJbbTi9Sq0Te59OUERtTSmJUffqmLmJ
 mxVNS22TL75a6daHvfKeVfKfUw==
X-Google-Smtp-Source: ABdhPJwb6gRvjZPrPSggx9ayU8MlaLG8MrCOLa2tu+bYjKBe1jmVhVRLC+DTCBBJAoYt/9Fgb3Zplg==
X-Received: by 2002:a05:600c:4f0a:: with SMTP id
 l10mr33174wmq.143.1632751007169; 
 Mon, 27 Sep 2021 06:56:47 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b7sm20485606wrm.9.2021.09.27.06.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 06:56:46 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v8 17/22] ASoC: qdsp6: audioreach: add Kconfig and Makefile
Date: Mon, 27 Sep 2021 14:55:54 +0100
Message-Id: <20210927135559.738-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
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

