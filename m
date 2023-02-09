Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5FDC61DA4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 22:57:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ADEF84A;
	Thu,  9 Feb 2023 23:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ADEF84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675983467;
	bh=ttewvO45whZlagAG368dI44z8psgoKsPAj+R9BqxVE8=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ntC9+xt9x+1/itnHM/ZUzAz5eDspmV2iJ61W9MS9smDoqFLe1bxI/LBVg65L6P89P
	 zqJ77g/NRNgjQ9BdsUyA7eNtz2zv6ybcV/nqEnV5/89Lc7ZjRUImgi/DXDaMYkevvn
	 fwfz30GmrjmI7VX3i2/j0Cpv5R1FyuP4QYeHv3iw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE61EF80027;
	Thu,  9 Feb 2023 23:56:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3B46F800E4; Thu,  9 Feb 2023 23:56:16 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01F4FF80027
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 23:55:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01F4FF80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aRzGLdiN
Received: by mail-lj1-x22e.google.com with SMTP id g14so3903253ljh.10
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Feb 2023 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/3WdsTnQdOHde9msyQKMoio/ECH8a5tpAu+T/cYiEY=;
        b=aRzGLdiNL3eF8phfIt/X7mZWoYj/8IzoLLTcAaXgn7QP0njSJYpssKCVpXQg9rIbDg
         kk/kyO3fWq0ZDRcQmQGXPqMLHMkvxIP+PCrcQz5fxtiWTx3IQjcqBqCTK68551Dgyz88
         Lww+qF8HyOkYhI4VNqfUUfdRZEZFaM0SFtpvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/3WdsTnQdOHde9msyQKMoio/ECH8a5tpAu+T/cYiEY=;
        b=CWp/U9aOfto2g/HC3qeReeJJzXZd+dg79upfjPstX+JmK4/lz2aSGv4dFgJRAC+aVa
         fdUS6e/RDb9c3Ye7aL5UKaNwemO0BJEncc4s5a/Gjd0RVPOK7Td24b9psHgFdpkONgYl
         GRUH87SnBPTxWhukrGttEMC/51an1r2kewnuv2WVL/6p2aDSsmZ4sTNyL1SZjGKpYgGS
         lsWfeEztY8RhG4zdjStD5tnPv7svISmO7LRnFn/6ppDMQdLZ6o9M08LEg+QYsa+MpR2H
         M+72qP/33g1GUOZ+ARmc7f4aH2J2wHAv9/GbWuOkHKc8wDeDE9pI7eOrEdyQJ2AqGuO1
         pwDA==
X-Gm-Message-State: AO0yUKVpzjUOZtc6FpdfboshzDxON+Wh1eM/alMaSHavyADNPClfCKcs
	iLhOEWXaEfDDiG3c87JAuUgjCS/gLG0yNF/DRYFDqQ==
X-Google-Smtp-Source: 
 AK7set+i6F2muyublkl3zPHwaGKHmip/aE9IKN/2NWtEl3MCsCwksdVhnIOPhSnHD2GYLH1+A2DsbkPPT6t5/4vraiE=
X-Received: by 2002:a2e:8206:0:b0:290:5b9d:e97 with SMTP id
 w6-20020a2e8206000000b002905b9d0e97mr2076244ljg.187.1675983357541; Thu, 09
 Feb 2023 14:55:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Feb 2023 17:55:56 -0500
MIME-Version: 1.0
In-Reply-To: <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 9 Feb 2023 17:55:56 -0500
Message-ID: 
 <CAE-0n53uReg41RrHrBDaNt+BgaPem_JO-2Wwq8e_g0NeNCvgXg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org,
	alsa-devel@alsa-project.org, andersson@kernel.org, broonie@kernel.org,
	devicetree@vger.kernel.org, dianders@chromium.org, judyhsiao@chromium.org,
	konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mka@chromium.org,
	quic_mohs@quicinc.com, quic_rjendra@quicinc.com, quic_rohkumar@quicinc.com,
	robh+dt@kernel.org, srinivas.kandagatla@linaro.org, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: VYUPBAKDDVLBPOPIEKF5HFU37GYA4RF6
X-Message-ID-Hash: VYUPBAKDDVLBPOPIEKF5HFU37GYA4RF6
X-MailFrom: swboyd@chromium.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VYUPBAKDDVLBPOPIEKF5HFU37GYA4RF6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Quoting Srinivasa Rao Mandadapu (2023-02-06 08:16:36)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 1810a36..5e99f49 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -107,3 +107,7 @@
>                 };
>         };
>  };
> +
> +&remoteproc_adsp {
> +       status = "okay";
> +};

Sort this file by phandle alphabetically?

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6908bca..27ab992 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3439,6 +3441,97 @@
>                         status = "disabled";
>                 };
>
> +               remoteproc_adsp: remoteproc@3000000 {

This should be sorted on physical address. I think the node above is
spi@88dc000 so this is in the wrong place.

> +                       compatible = "qcom,sc7280-adsp-pil";
> +                       reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +                       reg-names = "qdsp6ss_base", "lpass_efuse";
> +
> +                       interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&adsp_smp2p_in 0 IRQ_TYPE_NONE>,

Can these have proper irq flags? Doubtful they're IRQ_TYPE_NONE.

> +                                             <&adsp_smp2p_in 1 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 2 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 3 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 7 IRQ_TYPE_NONE>;
> +
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack",
> +                                         "shutdown-ack";
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_CFG_NOC_LPASS_CLK>;
> +

Drop newline so clocks properties are together please.

> +                       clock-names = "xo", "gcc_cfg_noc_lpass";
> +
> +                       iommus = <&apps_smmu 0x1800 0x0>;
> +
> +                       power-domains = <&rpmhpd SC7280_CX>;
> +                       power-domain-names = "cx";
> +
> +                       required-opps = <&rpmhpd_opp_nom>;
> +
> +                       resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +                                <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +

Drop newline so reset properties are together please.

> +                       reset-names =  "pdc_sync", "cc_lpass";
> +                       qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +
> +                       memory-region = <&adsp_mem>;
> +
> +                       qcom,smem-states = <&adsp_smp2p_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +                                                      IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                      IRQ_TYPE_EDGE_RISING>;
> +
> +                               mboxes = <&ipcc IPCC_CLIENT_LPASS
> +                                        IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                               label = "lpass";
> +                               qcom,remote-pid = <2>;
> +
> +                               gpr {

This node name should be apr per the qcom,glink-edge.yaml binding?

> +                                       compatible = "qcom,gpr";
> +                                       qcom,glink-channels = "adsp_apps";
> +                                       qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +                                       qcom,intents = <512 20>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       q6apm: service@1 {
> +                                               compatible = "qcom,q6apm";
> +                                               reg = <GPR_APM_MODULE_IID>;
> +                                               #sound-dai-cells = <0>;
> +
> +                                               q6apmdai: dais {
> +                                                       compatible = "qcom,q6apm-dais";
> +                                                       iommus = <&apps_smmu 0x1801 0x0>;
> +                                               };
> +
> +                                               q6apmbedai: bedais {
> +                                                       compatible = "qcom,q6apm-lpass-dais";
> +                                                       #sound-dai-cells = <1>;
> +                                               };
> +                                       };
> +
> +                                       q6prm: service@2 {
> +                                               compatible = "qcom,q6prm";
> +                                               reg = <GPR_PRM_MODULE_IID>;
> +
> +                                               q6prmcc: clock-controller {
> +                                                       compatible = "qcom,q6prm-lpass-clocks";

This is clk binding but not a clk driver? I'll look away now.

> +                                                       #clock-cells = <2>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +               };
> +
