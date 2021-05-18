Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A77C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:28:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D440761369
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D440761369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3480A166B;
	Tue, 18 May 2021 03:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3480A166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621301318;
	bh=tDMZGB+NLdjby04HkypcSoICl9YSom94uFQO0o5CX7s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BRFwO9owKLuWYJ0Dx88aOliI/UXTUDWBmD878JB1lSPNl1Qw+Brwy9TggmvWwgXmD
	 72hGSyLIg05ZAvj9hyLeIEnFMM12NfoBU67TJ4KoTBiJLwLzZoa6PG+xXR/JXNEY0U
	 7hD+OWOthTbomYY6AQclHVoV151PdDkUB9yDzmNM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFCBFF8016E;
	Tue, 18 May 2021 03:27:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBF83F8020B; Tue, 18 May 2021 03:27:46 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73AE2F80082
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 03:27:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73AE2F80082
Received: by mail-ot1-f53.google.com with SMTP id
 q7-20020a9d57870000b02902a5c2bd8c17so7259116oth.5
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 18:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x5MuHDr1VuOYtFi32SjfZtdQohcWcKpREmn5Jo1hbuE=;
 b=jc7UOSRka30ZdMSSNuBPmP0ur8GJORSd+CLniiGylMBUIWVjSxx0daxPFXlTimhEsD
 60LGXHjlB6bFdSe5o87OVhKhngRv98jwznVruouIV3Vhx6csdULSv8cGRJ04+ELfnXkU
 0Pj+q6BeNGIwyi3R5X0X14PFgnl0CxGIj+LcunfVy5mpzOjkmqcFe2xbO0NmejCsP6UE
 dLGe5Z5VIs6WK3F+n3hdtd8jLiKufuwGUvojza1ODsINl6S/GcaSGEqyy2rQ9S2KD6EA
 FXUCSqElh4MTvezo1m3yANfdRFfpXoiCDvB4hogn9Dtd+Z+daq6HpfMfeUGBYNNRyCND
 nrDw==
X-Gm-Message-State: AOAM530epaa7q3Zgfe4/edIivVZiP1/yBVs+f/Jtgqylpg0f2IlTNKpi
 jlGpEnH5DK/AAPg+uQz8EA==
X-Google-Smtp-Source: ABdhPJzW/WET1XynmeNegfDrhTPJIkFYbUP1pwCRoml9gTosHpax4KZkPIP2FBySmP+4CDjgKyLGDA==
X-Received: by 2002:a9d:ea2:: with SMTP id 31mr2193056otj.200.1621301257191;
 Mon, 17 May 2021 18:27:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 77sm2500602otc.54.2021.05.17.18.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 18:27:36 -0700 (PDT)
Received: (nullmailer pid 3600153 invoked by uid 1000);
 Tue, 18 May 2021 01:27:35 -0000
Date: Mon, 17 May 2021 20:27:35 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for
 wcd938x-sdw
Message-ID: <20210518012735.GA3600100@robh.at.kernel.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
 <20210514103405.29927-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514103405.29927-5-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, 14 May 2021 11:34:00 +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices RX and
> TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x-sdw.yaml      | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
