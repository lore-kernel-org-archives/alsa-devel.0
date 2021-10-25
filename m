Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FF4C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:23:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EFF60E09
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92EFF60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 010A716DC;
	Mon, 25 Oct 2021 19:22:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 010A716DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635182578;
	bh=yh7/jBE/ugWh6oZWpDa5qP4ZeP0z0wdFRiu0hv2Seik=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QTWWRvSNRgTZ1Z5t1kDR19eG5mJ5BDSsDNeOwPFYks+Z1fq0nSdnHeTMkFFrzbjSd
	 i2rEBvG38ko96rQ1m6eKtZ0HCtxXA0JUZ6Xpw1wLX3Yq+1byZN67vvw2Vr3DKoBl4b
	 RIR9cAVXGFepnyq5SyE1OAxzyO66RJOO+nfd/51s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C33EAF80557;
	Mon, 25 Oct 2021 19:18:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38245F80534; Mon, 25 Oct 2021 19:17:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 508F4F804E5
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 19:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 508F4F804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="XKbQhmKG"
Received: by mail-wm1-x335.google.com with SMTP id
 71-20020a1c014a000000b0032cafd23b1dso659131wmb.4
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4VxZXnKS9YtNHxd0gj3h59SMAN46hPXrE6hl+KuwiZE=;
 b=XKbQhmKGuAyTv81G8PIzLh87XvVIWPRf8HSVv8JUCugCZNl+9mcb6v3xjqqawhYWmT
 wbzrmdi14bRaJdGe4FpC0nPZ+Q+w+KglnCUAo0tdeq3sPt6k/kPzH8ylv5HKwZ3g84re
 B8sEKMW72HD5IGf9c/UbBpWKQkg1wgJXe/4Fnsm8yRFad/nDaEzJvkLBbyeWSyVSj3FD
 YNPvFRo1nvfndjOJMNch97MGDNQFF+4r3lDigCSzTiVHi/VMQYPmR8XWUQXbnns87N9c
 ToS4ztGjScYLbsWJAm0Ra0iUrcSzX+xYDQYaZTNyyeQAIfGbRHz7unE/rekNLU+3E5T/
 kwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4VxZXnKS9YtNHxd0gj3h59SMAN46hPXrE6hl+KuwiZE=;
 b=v/7tn5aChl/zSNnwJFeTHpy91uj9AWU6OyQ3VW4c8DDqoFMtBjCJVzDNhACTFp4aIQ
 T+tKwssQ1uut4P4A2+c3etosm2trM5eMcrvCH5C0EJIg9cYqI1xv9gTw/1b/ba2REE0O
 8HJSVdz6R/mOUreD6JmraZjgaTm4g/CEUrWq/1qhHi0XdoV9HIdhoSq+d8dGrFA5u6yS
 VGl3zaYPPVmltpdFQj1S35vaTc7eWF+cWoFU7fAYO4Nt9VYtt1ZNSxhQI8XG0j/jcK+m
 GjZJ5k6k9WuGB5mDTnO2x+24wzqw/G+xmb06uPCFXOrO4LBbYb5FjUlJFPK2+EuO2de/
 y6Sg==
X-Gm-Message-State: AOAM530iuCMyJ6PbNcZfVlFSNeSOtxmO7gfFdgGcWnaQmIrMVRxoE0ms
 5ECpdd6daOZrJhi4XBo2d6bgQg==
X-Google-Smtp-Source: ABdhPJxlsYqc/GhWru2CeiX9LbQoso0FcSpq0ZGsQtk+JeL/3jLdK0LEXbwzncn22Tdn4/cS6L6vwQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr21367382wmc.75.1635182243771; 
 Mon, 25 Oct 2021 10:17:23 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id r11sm5181012wrt.42.2021.10.25.10.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:17:23 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [PATCH v10 12/17] ASoC: qdsp6: audioreach: add Kconfig and Makefile
Date: Mon, 25 Oct 2021 18:16:44 +0100
Message-Id: <20211025171649.17730-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211025171649.17730-1-srinivas.kandagatla@linaro.org>
References: <20211025171649.17730-1-srinivas.kandagatla@linaro.org>
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

