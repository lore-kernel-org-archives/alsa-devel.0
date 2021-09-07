Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0175C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:55:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E244660F14
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E244660F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61E59165D;
	Wed,  8 Sep 2021 00:54:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61E59165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631055326;
	bh=0YJPmNTLN1fYEguPyphxLbaxT9ErDslVzP97UMnG6W4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uU27PjbB7T5drRIJK9eSgdMi9mxwdDjtqWsWeOkz8YIzTnQ/h334qpc14rIIE0zTq
	 D+mVSeGZA+tY9nCmJxvGFzk0GLNyRKwUBCI5NhKz9QryBP2gMGmPfnv4hiWyXbCUUR
	 EHaxrzWFTbV7x317Dn/BBLRhoZS6einm4oaog8Rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C5AF800C7;
	Wed,  8 Sep 2021 00:54:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E783FF80224; Wed,  8 Sep 2021 00:54:33 +0200 (CEST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99184F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 00:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99184F800C7
Received: by mail-oi1-f179.google.com with SMTP id n27so612609oij.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2021 15:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cqpJgyCuWfM8JYrsZYqtKzigon2BfWGgK2eAlix+GG0=;
 b=HcSeJyXdB8F9+Ss/fmzU4Amw5NF9t8yk0ZfKbL5lHrpExYqeeFJIo3hFVgVnwm6e5l
 roqMtdz+bujCueZ2i4d2bXxxptt4LW4m0nS4ytfy06ZpR7QrMXo4bqcd8JPTpZPSlP5r
 0gGY9S9E8cnGdST4ys0oJeS6hGFxRgpDWYBcW7cpenPsEDHI7YlyNPWHBWSBnRte+NgJ
 oqCr7SSs8Di1dsbMPLvelwVQNEOJe0LNzcIt/6cYPPnuLQxSIYFhSgJ4VeSn6gjhqAZI
 B+4kiXcy5HT5RaqJx9aJGD3GsjhvJK3vQqHoVYcKSHjuu8F7AqsxPscwEleT3e98GUUb
 kJnw==
X-Gm-Message-State: AOAM533fBAAl2Vw7eckr/f2rxIeNfzcVruihHganmV+Nr7KkbfuLI0cC
 cCXKgvVN7p6B647S0WQCWQ==
X-Google-Smtp-Source: ABdhPJzrCwxlJDDdlTsGBfBHglqBTgvNXhQKiSBpAYiGFipVHm112Ijap2nuNg9gh9SXGulnMqvXng==
X-Received: by 2002:a05:6808:1294:: with SMTP id
 a20mr389610oiw.4.1631055265056; 
 Tue, 07 Sep 2021 15:54:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id l21sm73434oop.22.2021.09.07.15.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 15:54:24 -0700 (PDT)
Received: (nullmailer pid 511881 invoked by uid 1000);
 Tue, 07 Sep 2021 22:54:23 -0000
Date: Tue, 7 Sep 2021 17:54:23 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 06/21] ASoC: dt-bindings: move LPASS dai related
 bindings out of q6afe
Message-ID: <YTftnx0YJwdUHgGV@robh.at.kernel.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903112032.25834-7-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, broonie@kernel.org, bjorn.andersson@linaro.org
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

On Fri, 03 Sep 2021 12:20:17 +0100, Srinivas Kandagatla wrote:
> q6afe (Audio Front End) is one of the DSP service that handles both
> LPASS (Low Power Audio SubSystem) Audio ports and LPASS clocks.
> As LPASS is a hardwware IP and commonly used by Qualcomm Audio DSP.
> In order to allow  multiple DSP frameworks to use these bindings
> its best to move it out from the dsp specific bindings.
> 
> For compatibility reasons and not breaking which is already working
> we still maintain same compatible string "qcom,q6afe-dais"
> 
> Also as part of this change convert these LPASS dai related bindings
> into yaml format.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt  | 158 ----------------
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 178 ++++++++++++++++++
>  2 files changed, 178 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
