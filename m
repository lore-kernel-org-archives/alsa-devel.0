Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A59AC001B0
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 22:02:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21DCE1F3;
	Thu, 20 Jul 2023 00:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21DCE1F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689804140;
	bh=ZGb/L/F75EEAk4xb9XJDB34DOMqNWMaoiBCf5BKg7kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eMsQEaJdB1s7g9PVUZ7uY7/7XJqYVHSOZ6HyzQtSSEqlGRjm5bpEc2RSgjuRdTpU+
	 Zuf2ty8/PfGkbdrKU44RIvbZxEXxg3RdhcPXY92sAr+dlDkoD0F4Ybbm+Qk2xF5u3k
	 4xWoIJ3i+XajaHPzeZgkk6s8CNvzZLAKGeZLAa/Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1822EF8053B; Thu, 20 Jul 2023 00:01:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 260A8F80535;
	Thu, 20 Jul 2023 00:01:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F60BF80527; Thu, 20 Jul 2023 00:01:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5E24F800D2
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 00:01:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5E24F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NecdG9Ph
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A73E461821;
	Wed, 19 Jul 2023 22:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB3C433C8;
	Wed, 19 Jul 2023 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689804068;
	bh=ZGb/L/F75EEAk4xb9XJDB34DOMqNWMaoiBCf5BKg7kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NecdG9Ph3Krgbg+CsKdXh5LepQDlhrl8ytKtLD6KedMjev4exultyLmv75OkBIM/Q
	 dqruvO3Pb0r9uGnIy2To1eqkb++G2/jKuMYItQ6WkgtFQN9qU2WwrIJCTvR+HBPCnJ
	 J/MGEJI7QQXCUBBzdiJPDeaytkgXk1X4+PKDcqOSWc+cNvgcdIsPaEyctrp3PE6t2U
	 yKGbqIPa6j3UGBIQzEAZCzuQFzxdGqy46W35ptGm6tb6A5T2udL7wxDt9DHOU6DdM4
	 3JcETakyxKSC8QdME+eH/UG49QkwsB5vEd0QHXwkJbTvXmTrQrRsdG6qICYa9AusyD
	 fA8jYh6L2vWtg==
Received: (nullmailer pid 855035 invoked by uid 1000);
	Wed, 19 Jul 2023 22:01:05 -0000
Date: Wed, 19 Jul 2023 16:01:05 -0600
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Mark Brown <broonie@kernel.org>,
 Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] ASoC: dt-bindings: pm8916-analog-codec: Drop invalid
 mclk
Message-ID: <168980406491.854976.10503527558613116747.robh@kernel.org>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
 <20230718-pm8916-mclk-v1-3-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-pm8916-mclk-v1-3-4b4a58b4240a@gerhold.net>
Message-ID-Hash: 5VWZYDGWDIPPUNM3R6HSBAORUFLYLMPV
X-Message-ID-Hash: 5VWZYDGWDIPPUNM3R6HSBAORUFLYLMPV
X-MailFrom: SRS0=QU89=DF=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5VWZYDGWDIPPUNM3R6HSBAORUFLYLMPV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 18 Jul 2023 13:40:15 +0200, Stephan Gerhold wrote:
> The audio codec typically used for the MSM8916 SoC is split into two
> parts: the digital codec is part of the SoC, while the analog codec is
> part of the PM8916 PMIC.
> 
> The analog codec in the PMIC has no direct connection to the mclk of
> the SoC (GCC_CODEC_DIGCODEC_CLK). As the name of the clock suggests
> this is supplied to the digital part of the codec. During playback it
> will use this clock to transmit the audio data via the "CDC PDM" pins
> to the PMIC. In this case the analog codec indirectly receives the
> clock signal through the digital codec.
> 
> GCC_CODEC_DIGCODEC_CLK is already managed by the driver of the digital
> part of the codec in the SoC. Having this clock on the analog PMIC part
> additionally is redundant and incorrect because the analog codec cannot
> receive the clock signal without going through the digital codec.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/sound/qcom,pm8916-wcd-analog-codec.yaml           | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

