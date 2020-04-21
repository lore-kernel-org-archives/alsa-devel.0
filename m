Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F868C38A30
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:54:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5102078C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nbPCOojC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfRpFDiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5102078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DE88167E;
	Tue, 21 Apr 2020 03:53:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DE88167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587434067;
	bh=kpiJIwVEjJZfKoxib5iDejIQ21F3wsf82HLIiScftZc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nbPCOojC822yWsnBc5v+DcTJLqK/6v7oipypm3MglAjJnGx+ykxoBSZSqU29jRrU0
	 Iv7Wrp3piI8bhHK7YjY8dBxOWeEjVXkBiWkYbDRcfIzENsDkCg9hKDE9mYN5aZVEro
	 lMJX6LHL+jVCEnobW9WY5FF4/C9cPLwisZXXbnco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3B34F80143;
	Tue, 21 Apr 2020 03:53:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82D19F801EC; Tue, 21 Apr 2020 03:53:35 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77C3AF8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 03:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77C3AF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="xfRpFDiM"
Received: by mail-pf1-x441.google.com with SMTP id x77so3275547pfc.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HjaU46gshLP9GG/96K+kwboQDvDrw0plitPA+YNIbGk=;
 b=xfRpFDiMGDmWjPTE0YYkUbpZVS47obtstRXpn7KoJtKrL2QbpLZfww1X3ZSIh8l0Nv
 n+sW9vfTuCEWuxgnENefnuyqJYDmvX0Xl9dbhxiDUU27U/ZaeXsqr7inv+SvEh78uAbg
 hZf8+Hox1ek/VyaKJyo68zPK/KFaqwxdO/NGoD8pLBlemT0P10eClmNQgU/SiT0rYoAm
 nvAiyJ857Lcxcgb4dBbMQGn+gfn3MGQej9GLjYxXrPpZ4MHMD5Gx42i7SqCQ51uExIAg
 XAzv9LqBijXqE+nnbh6rGyQs+EIjq58AiGqemnn/IX9SW/1bnrw70pFKeBSsc5tEX0oQ
 8rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HjaU46gshLP9GG/96K+kwboQDvDrw0plitPA+YNIbGk=;
 b=FbcSH05ta6H8FIk850KvHsz726zke2FWJyCw7dA8Wb55tOWBARAsabp94OoSqKWLFy
 mXPPWmNQJxyuoV2WQKY2ZHwSaDn68n8Mse04NrQKKzk7b5hW3J0N5BouKyVGvZmJKkN6
 Ymi2RuWSAOlqCBxYgdCyOq7WXYHK5mpk843IaK7kLk43uR1JVPmAuyPtEHWutuMAABEq
 9cLdL9+ASXOrTpcxYETBBFLDETCu4dadxhi9CNMtvClvyK/fUS5rERA5k31kXV0j0Gmx
 RW1g0gMA7KU9Nkb+n90EleQ0Xonc+nz2JnuyJ9xKHgy4J0gcs9KZYuU3Fosxxc/UVqEQ
 QZ2A==
X-Gm-Message-State: AGi0PuZUF5x1fF8pjsVhbdosuQJe0nOdDiFyf1Jxw7iQXDFON27k/LMT
 VXMGCo70+gb69N26p57fHZ0eeg==
X-Google-Smtp-Source: APiQypI4Nxn9X9fDUlEU6GiIiPgk4BM6mX4SRxaaBvw8cFMIqbkz4RbBzf6gfeDAsH3XeeLgbtcPOw==
X-Received: by 2002:a63:310d:: with SMTP id x13mr7596695pgx.266.1587434004255; 
 Mon, 20 Apr 2020 18:53:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id s10sm657737pgq.69.2020.04.20.18.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:53:23 -0700 (PDT)
Date: Mon, 20 Apr 2020 18:53:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/2] dt-bindings: soc: qcom: apr: Use generic node names
 for APR services
Message-ID: <20200421015347.GT576963@builder.lan>
References: <20200415081159.1098-1-stephan@gerhold.net>
 <20200415081159.1098-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415081159.1098-2-stephan@gerhold.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On Wed 15 Apr 01:11 PDT 2020, Stephan Gerhold wrote:

> Device nodes should be named according to the class of devices
> they belong to. Change the suggested names of the subnodes to
> apr-service@<id>, which is already in use in
> arch/arm64/boot/dts/qcom/sdm845.dtsi.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Applied, thank you.

> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> index f8fa71f5d84b..2e2f6dc351c0 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> @@ -65,30 +65,30 @@ which uses apr as communication between Apps and QDSP.
>  		compatible = "qcom,apr-v2";
>  		qcom,apr-domain = <APR_DOMAIN_ADSP>;
>  
> -		q6core@3 {
> +		apr-service@3 {
>  			compatible = "qcom,q6core";
>  			reg = <APR_SVC_ADSP_CORE>;
>  		};
>  
> -		q6afe@4 {
> +		apr-service@4 {
>  			compatible = "qcom,q6afe";
>  			reg = <APR_SVC_AFE>;
>  
>  			dais {
>  				#sound-dai-cells = <1>;
> -				hdmi@1 {
> -					reg = <1>;
> +				dai@1 {
> +					reg = <HDMI_RX>;
>  				};
>  			};
>  		};
>  
> -		q6asm@7 {
> +		apr-service@7 {
>  			compatible = "qcom,q6asm";
>  			reg = <APR_SVC_ASM>;
>  			...
>  		};
>  
> -		q6adm@8 {
> +		apr-service@8 {
>  			compatible = "qcom,q6adm";
>  			reg = <APR_SVC_ADM>;
>  			...
> @@ -106,26 +106,26 @@ have no such dependency.
>  		qcom,glink-channels = "apr_audio_svc";
>  		qcom,apr-domain = <APR_DOMAIN_ADSP>;
>  
> -		q6core {
> +		apr-service@3 {
>  			compatible = "qcom,q6core";
>  			reg = <APR_SVC_ADSP_CORE>;
>  		};
>  
> -		q6afe: q6afe {
> +		q6afe: apr-service@4 {
>  			compatible = "qcom,q6afe";
>  			reg = <APR_SVC_AFE>;
>  			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>  			...
>  		};
>  
> -		q6asm: q6asm {
> +		q6asm: apr-service@7 {
>  			compatible = "qcom,q6asm";
>  			reg = <APR_SVC_ASM>;
>  			qcom,protection-domain = "tms/servreg", "msm/slpi/sensor_pd";
>  			...
>  		};
>  
> -		q6adm: q6adm {
> +		q6adm: apr-service@8 {
>  			compatible = "qcom,q6adm";
>  			reg = <APR_SVC_ADM>;
>  			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> -- 
> 2.26.1
> 
