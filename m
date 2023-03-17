Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97807C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Mar 2023 16:38:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42DB7EFF;
	Fri, 17 Mar 2023 17:37:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42DB7EFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679071087;
	bh=Vp0IlDlaLKaUFUkT21XmwTUoqJFg7dI7PQvrTrW2Eq4=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gkUDISb3HGW6fMfvI1n1R0OzE0nQUejFV1FMZk0nu3sjuU/Et6Lrwu99gvcIikRhM
	 Rlb/7IY0RDDIaNSKH9vVfG+vUG/GAroXA/UeSLQlJBs20lPJv9trEH2brWZTwYBNuN
	 VrdvDGUPvpFvLy+W8JBjtiaUMzQ8cPSIVO6QjZ58=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9240F8032D;
	Fri, 17 Mar 2023 17:36:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B45EDF8032D; Fri, 17 Mar 2023 17:36:51 +0100 (CET)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40437F800C9
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 17:36:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40437F800C9
Received: by mail-il1-f181.google.com with SMTP id r4so3030068ilt.8
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Mar 2023 09:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nufLuwGvdiUyDvvGkb0YtX3z4IoJj7qYWEEj7Lhk4/0=;
        b=JiHHLaAMWxXALh1njXdptgUdIb2/AVl0HgM4QqVzJMacONIczi7j7+/r6YtRh6McmA
         K+ofx8D5Hv845NDjryohGWNTu6gIEXYXR31DIbSQMAP6aIj/0cXoNLwSEDElm85VYlNn
         AVEMipAK0eNpslQvZeM2lB/3MDxMDH4BoTtvR4ota/Tr8k5Bt5+VVgoeIXk1EOtMkKxT
         ReGjjFZsvcTH+ScNrc/eEuf9ead70+GJpAO+jFDiYhllvMM+mxIuWV0TCFOkwba29f4X
         lD6P4yBYMYWjtakMfoXgkW9DVHTme7RLTo3FWcxXujggbAWIJJNWH47+w2TW9Dj66U3l
         UZeg==
X-Gm-Message-State: AO0yUKUkgs897gcl0gLQKAIlR3Lt3PHuGrw+CFp80uOrNDK/SvVPvI/7
	a1M03lc4dUIPlVUSfOH/hg==
X-Google-Smtp-Source: 
 AK7set+C73BEjFyJsEEz8nRV9C+T5b6VcQtTPPbLP66JDGWb8pLc3RlbdJa2L6hMJERbNx0VByvitw==
X-Received: by 2002:a92:cf0c:0:b0:322:fa92:7d60 with SMTP id
 c12-20020a92cf0c000000b00322fa927d60mr96697ilo.0.1679071004280;
        Fri, 17 Mar 2023 09:36:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id
 x10-20020a92300a000000b0030c0dce44b1sm722517ile.15.2023.03.17.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:36:43 -0700 (PDT)
Received: (nullmailer pid 2437985 invoked by uid 1000);
	Fri, 17 Mar 2023 16:36:41 -0000
Date: Fri, 17 Mar 2023 11:36:41 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/9] ASoC: dt-bindings: qcom,lpass-rx-macro: narrow
 clocks per variants
Message-ID: <167907100109.2437918.10749959884384918069.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: OQ3KGE4MW5R2JVT3D66R2QOX74JXRHSU
X-Message-ID-Hash: OQ3KGE4MW5R2JVT3D66R2QOX74JXRHSU
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OQ3KGE4MW5R2JVT3D66R2QOX74JXRHSU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 13 Mar 2023 08:54:37 +0100, Krzysztof Kozlowski wrote:
> Currently the Qualcomm RX macro codec binding allows two different clock
> setups - with (for ADSP) and without macro/dcodec entries (for ADSP
> bypassed).  With more devices coming soon, this will keep growing, thus
> rework the clocks/clock-names to be specific for each binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-rx-macro.yaml   | 58 ++++++++++++++-----
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

