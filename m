Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02383C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 14:29:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A94D168F;
	Wed, 16 Nov 2022 15:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A94D168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668608979;
	bh=iNWupuRjdf4WDJwvku/uOIF6BDzusJloIJgME0GpZlU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFWsgy1ohBlK91QxIX9k5F3J7W+om5p+6VxjTiWOq9cdvBWVp5eQCDPI9x/3uQ4wr
	 F/Hl4IGxDhxDoX44eMAVUeRNu0+sWV2BgAEKSub7mK0cEQGqmYjdhkhUzljLpNhG9k
	 ohCuFxV1owN3Chvi31HT1Sqx3OEdCOW+3lwPgAxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4444F80163;
	Wed, 16 Nov 2022 15:28:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEF22F80169; Wed, 16 Nov 2022 15:28:43 +0100 (CET)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 081CBF800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 15:28:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 081CBF800B8
Received: by mail-oi1-f175.google.com with SMTP id e205so14171735oif.11
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 06:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJm4Khl2AqxNBL7jLr8tofG6XONtUSnDoYtCODWM95I=;
 b=2QKRm1cWU9Tx8bp5KubyVxICTsQshmhQ6ZSHN10nrYTNWqtEjgXwbjxELKOtQz0z4Q
 5lD0ZTEKO4SG9QaYmMoMywB3scAMRNHahVZrnZdA1E2OZS5xEzHBVZ6Y1pw7cRmy+FBT
 eaffPjdnWr162H7fpCwApwcUkj+D6fblMz1dmWbR10fJv4WJv13Jy2E5PGI6GKqmzvAm
 rfG2e0yKFgq33rmgEPnCJ0r7Zgv4x6bu6pHnmXKk4AJaFD7D7LchFky3hjZgHAt7O9vo
 TGVTceRJYWaw26DOErGeqelrFy/eCMx9fNajFUUA7FCtmr7GcOs3ajkU+QdcKOvNH2ML
 o6zg==
X-Gm-Message-State: ANoB5pnF4xmoFEJOggxrJfLplrin5PBV/sR+VnyGB4zgbLiBHiC3tBCW
 hlG8KiGVyplcmPY3F85mDg==
X-Google-Smtp-Source: AA0mqf4sINa2t2XydjWBN/1d75ne+X4d+3nvk2RXDH/iplrAJ1owmL/DpO9cHAVg+yGj7EE6duQ8+w==
X-Received: by 2002:a05:6808:2d7:b0:35a:2325:7aff with SMTP id
 a23-20020a05680802d700b0035a23257affmr1668308oid.41.1668608914171; 
 Wed, 16 Nov 2022 06:28:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 l12-20020a4ae38c000000b0049f3bdd791esm5872269oov.26.2022.11.16.06.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 06:28:33 -0800 (PST)
Received: (nullmailer pid 3804306 invoked by uid 1000);
 Wed, 16 Nov 2022 14:28:35 -0000
Date: Wed, 16 Nov 2022 08:28:35 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/11] ASoC: dt-bindings: qcom,apr: Add GLINK channel
 name for SM8450
Message-ID: <166860890990.3804146.6416157036563364508.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-2-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 quic_plai@quicinc.com, quic_srivasam@quicinc.com
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


On Tue, 15 Nov 2022 13:02:25 +0100, Krzysztof Kozlowski wrote:
> On SM8450 and SC8280XP with Qualcomm GPR, the GLINK channel name
> (qcom,glink-channels) for ADSP is "adsp_apps".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
