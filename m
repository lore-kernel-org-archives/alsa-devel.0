Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BDBC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:38:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFE361104
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CFE361104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32A3C1704;
	Wed,  8 Sep 2021 00:37:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32A3C1704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631054281;
	bh=BxTVXjNP6IkJROpd78+T84AragVoHkdv92bsQo5GqHE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQdqLzvrv6BS1znVRTlQkxj4x71OvxfKUWG0RB24LYuRSdtv2iGGLEVKjuMjnid9g
	 W4b7exxuI8dhWeiDZQoyDUKBoo5nVvGWkcl2FxuaD1A1SV5r2k1LS0qJAPu3GokFlx
	 FHhSHPbzmCdKGf1LzJZ8ta0VfKNW1eG1R/wpLLSM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD38F80217;
	Wed,  8 Sep 2021 00:37:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC3A2F80224; Wed,  8 Sep 2021 00:37:08 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D3D4F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 00:36:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D3D4F800C7
Received: by mail-oi1-f175.google.com with SMTP id y128so494333oie.4
 for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2021 15:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7GXuMDvTOLDEpKcOYfCCxlmtd6+MEipLqNFBOa/xCCY=;
 b=mgc/1NqrCPg6UBJ4G9/+ISvADDtp7wxdeQndUcJt4Eh79xCqPlG8LLLjTd2G3wqGSm
 oR3Q+UEpUjHH1i6ZiqJAxIszyfTeziEzaGV+UGEx6YPhoJf+fjbDczXSW1rGoNBtS/yr
 Kbq62T8iYByexEIIFrmw9/GlB1wKzQdPKb8fyFhFSoLwVlAbZDzbtR4qR9vPQqS/8x74
 PC4BguheUIkPb/3u48dxdtlsGUe6lnXVjUNaY6iKlmvY2EQjybQEIR2YrM8hR/d1/qAC
 /VJoy/TfQqjEaJlx1vLlM/GwAIhH84t2JHJgJ9LjbmqKqX0ZUferDHZbi3ZRhd3NTPWV
 RC0A==
X-Gm-Message-State: AOAM530DBL9ZHII1fIe3u531t1SIitrbpyeQ20UZRzG84SAG3TEljxHQ
 PgI7rhLO1vnTkpOwDzg/hA==
X-Google-Smtp-Source: ABdhPJymQspdRuiPkUjcw6rhHbziEhJkiTazcFEcZ396bUYDBY6AS2AKXiS/2jpXyQkojgTAXlT4WA==
X-Received: by 2002:a05:6808:618:: with SMTP id
 y24mr265737oih.179.1631054216401; 
 Tue, 07 Sep 2021 15:36:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id y11sm59992otg.58.2021.09.07.15.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 15:36:55 -0700 (PDT)
Received: (nullmailer pid 488839 invoked by uid 1000);
 Tue, 07 Sep 2021 22:36:54 -0000
Date: Tue, 7 Sep 2021 17:36:54 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 01/21] soc: dt-bindings: qcom: apr: convert to yaml
Message-ID: <YTfphkPM0nBuLf3P@robh.at.kernel.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903112032.25834-2-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, bjorn.andersson@linaro.org, broonie@kernel.org
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

On Fri, 03 Sep 2021 12:20:12 +0100, Srinivas Kandagatla wrote:
> Convert APR bindings to yaml format so that we could add new bindings support.
> 
> All the dsp services bindings are now part of apr bindings instead
> of adding them to audio bindings.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt | 134 ------------------
>  .../bindings/soc/qcom/qcom,apr.yaml           | 128 +++++++++++++++++
>  2 files changed, 128 insertions(+), 134 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
