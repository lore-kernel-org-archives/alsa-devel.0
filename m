Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FAC2BBCA
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:48:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6E6E2343;
	Fri, 28 Jun 2024 09:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6E6E2343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719560895;
	bh=OBZJ6up/5UrmGgqTrk/JjQcPbrTRKR/bsWTSe04PzAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BhVq38eyRNAf8wdAgmJn61dfeRwHhudkBGa+dhmXpngLXdlC9cXuzCJmM0UY+Z40U
	 IbLmY/j4CCz8VGClSPm5l60pv2s/ng5LvqBFiw97VhiYmQTeXH8DhxjLm3u5daw30k
	 2KH+jg3xesbJxAGkolVjvQEq1N2Xbfk/yYg4GasU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 457A9F805D6; Fri, 28 Jun 2024 09:47:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 359A5F805E4;
	Fri, 28 Jun 2024 09:47:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31C92F80423; Fri, 28 Jun 2024 09:46:10 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF18CF800E4
	for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2024 09:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF18CF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Pakv0i/Z
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso344025e87.0
        for <alsa-devel@alsa-project.org>;
 Fri, 28 Jun 2024 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719560631; x=1720165431;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhe0rB7DF1acvlU18g3LpAyirHMKvmNtptxT67xMN9g=;
        b=Pakv0i/ZWs1w+3+FJ1QMf5wMxOYJVuNQrdFO722NV6/MkjxOMXRW0reoQfRzdDSccj
         pPUU41qcFWkrjBbwBW6JN0S5jlvdyYwdl+/JuRAycEWoTURP+NfNUokDVZ85zyINESra
         +XK8wAE3Tmx3scl+EGE+kMxm0EOwaCCIpvtjcB90ibLvUmWeUFzQ45PyiPjP0IO7oCYs
         u/2B7BV/+uFsschA5kwXkQ3oI3waqU6SC08s884EKWZMSvtwF5sAXoxWNP4eZGuleUGU
         rzNg0cjaMArgrGFH+u9PdILdKu3PbyP8+JErGop91/6qsXmZ73qtyFhWx/3/sC18vzsS
         kMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719560631; x=1720165431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhe0rB7DF1acvlU18g3LpAyirHMKvmNtptxT67xMN9g=;
        b=MF03nIN3G3wiTgRAdb51ObWz/o5LGtf0AMz7Rqv3YScPPX3Os/z87W1i4X+PVXZseB
         nIMsNRDNUsKJkroj/uRyc0DnPAjkKIGfvRIwoS+9troesU2ECh4zuDiZujHkXjlMRO2R
         /mrZO/eXkRMe6u/B/FpTdRyEeCNPzF5pcniVnsQlA0NFCaT2FhJBCmZBOlHeUZMbUhEe
         hKlkeTYQmZ2BuSAnQaVKF/7JtisX3Ng4LtXHEPq7JqhnlF1JL6RUUh5LDa76r5OKspoi
         vZwWdrXHQ7uqTXR8AvMwNy2MP4QE6w7jXtGqZ4vXawf3YXQSkDz3dFoBtZf9ySV+K7BG
         cn1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDMJb7yqRvMsoOonlCGEXBfZ51HFaHwtS41N3Cv2f8/ZUA3BH7kTRmfhoNKwQe3FxnDWbcyoh1ilkYQolo2S/t6HOB6go50hwykSc=
X-Gm-Message-State: AOJu0Yzanz6pP0653AzS7Bp9pAvbm2g+lC+aNn6dlBf+zXy8c47qAnvk
	f67oCbqAGgHtalvkAeHECg3TUe8ymeKX5ktELvUpHKCIlNzGBYIPXU1XZF7Fwzo=
X-Google-Smtp-Source: 
 AGHT+IGwqQ+G0h94gLaKfw7sf2Mdz7eYA/MoYsZAgQXx1KUjBDLepYtp64shbi0qnmb/a6DdWqkCkQ==
X-Received: by 2002:ac2:4105:0:b0:52c:dfa2:5ac1 with SMTP id
 2adb3069b0e04-52ce06442a2mr10134496e87.24.1719560631358;
        Fri, 28 Jun 2024 00:43:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab2ea60sm194159e87.218.2024.06.28.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:43:50 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:43:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, perex@perex.cz, tiwai@suse.com,
 linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, elder@linaro.org,
	krzysztof.kozlowski@linaro.org, caleb.connolly@linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm6115: add LPASS LPI pin
 controller
Message-ID: <yozlwsmrvolhaxobal4reootcfmgjyre7sv74pztbtqr6lcfhr@vuixh6qyalaz>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
 <20240628010715.438471-6-alexey.klimov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628010715.438471-6-alexey.klimov@linaro.org>
Message-ID-Hash: Z6DURRGFCRMMXP4VRKCLOLQETLCMZX3O
X-Message-ID-Hash: Z6DURRGFCRMMXP4VRKCLOLQETLCMZX3O
X-MailFrom: dmitry.baryshkov@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z6DURRGFCRMMXP4VRKCLOLQETLCMZX3O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jun 28, 2024 at 02:07:13AM GMT, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI)
> pin controller device node required for audio subsystem on
> Qualcomm QRB4210 RB2.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index c49aca3d0772..3a9fb1780c90 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,apr.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -809,6 +810,21 @@ data-pins {
>  			};
>  		};
>  
> +		lpass_tlmm: pinctrl@a7c0000 {
> +			compatible = "qcom,sm4250-lpass-lpi-pinctrl";

Is it so? Or should it be qcom,sm6115-lpass-lpi-pinctrl instead?

> +			reg = <0x0 0xa7c0000 0x0 0x20000>,
> +			      <0x0 0xa950000 0x0 0x10000>;
> +
> +			clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "audio";
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 26>;
> +
> +			status = "disabled";
> +		};
> +
>  		gcc: clock-controller@1400000 {
>  			compatible = "qcom,gcc-sm6115";
>  			reg = <0x0 0x01400000 0x0 0x1f0000>;

-- 
With best wishes
Dmitry
