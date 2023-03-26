Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684BAC6FD1C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Mar 2023 14:48:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FF16DF4;
	Sun, 26 Mar 2023 16:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FF16DF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679842104;
	bh=ANIvqRMvmDq+vwDLPzbMBwGjGc5UpNDVF3MmWyIBlwU=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Xu3l6T4DnfqVB8MhJa/W9xc2P9diODR+kKzeLCOZYfFDl45qMJ/nRG2weOaKTODdg
	 hvK+tQ+RzOm3qcJ4WdD8oLzLB4EBOlMqkj+0xx9KE0jdn8wjCDxCeirvVdIFKttYm2
	 otgys5hzS9qb6ZKGcNPajtj9mYepSHUu2pd9JjGI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B47FAF80272;
	Sun, 26 Mar 2023 16:47:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15607F80272; Sun, 26 Mar 2023 16:47:08 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07D79F8021D
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2023 16:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07D79F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ntvb7K1n
Received: by mail-ed1-x52d.google.com with SMTP id ew6so25769904edb.7
        for <alsa-devel@alsa-project.org>;
 Sun, 26 Mar 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679842018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFfrjCvrpWX6CnF+HF1tJ28DSs/1vxlz9uEimUmt+gQ=;
        b=Ntvb7K1nveWCIADlOJbiB8IYh3RmF/JSbKaJlmFXBxW54uMgTPUKheiECZTWdE+nLv
         c4jWoOMHP4dNki94qSmlfEPmCdXfQNYBLGMArFXA/BtrPnwy6x1NOdQ5Yyh5JWfjzjct
         y7L42zXKiid6qLsMe1VgAR4oJ7hNRq+lwHZ9j2FWwSoHbcxoy+rk+jnffT2QhhPG1OsL
         3o1T9gwji6ZdIIxItLYzFZ1sD388Rxr/mTpifTHVyv/Hz7CORTc5x1jZP1Dx+Qs47BRd
         dowz2z9T2mb/x7eRNggOvGRvBVLdVf+l+qlTqXmetbotX19ftL4r1gc0fho3Sn7lQ85l
         kdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679842018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFfrjCvrpWX6CnF+HF1tJ28DSs/1vxlz9uEimUmt+gQ=;
        b=s4udGhHyyIzZZEwU+hkufjmU16mSYO2yWTUiDSx8tKHNt4Z5jvuuX0ws5L31zz1vzK
         wjCbCwEolmzf9zoNBRQf7xvVW3GP02YF8Zzm2kU86/DXatgIYgTcBabOKGCpN19cO+yK
         zdFUXKxRB3f6KXGcby+z7ViECZHDefVMVet+aPpi7tWCpgKjZtpDeLxJot6o9SToAs8I
         n9MqDRaXZdwdUwNFwZm88czBWP7oe9Q2mQUm+gJL/jE+YbKBdKNWAwpnoXys8KNOgmkx
         373wILm6IoBrbycIgr6zcijiHiJJ4C+OQ8Lo1fVGCOD1aI7yUbPjSrMxMIl1T+euKi20
         btSg==
X-Gm-Message-State: AAQBX9fADWLYAdKhCp4DIin+YkNVimzpnlxqNN39k07pTVshavJfvFoR
	ccYloeqlquY1rF5d4M7bzKME/w==
X-Google-Smtp-Source: 
 AKy350ZQ1GaV8yhLr5q+kh5hsJpJhRqSpymNZuY/9YV2yeQJgeVnFVWC6RmHZCX03m93Hnyu6YMN4g==
X-Received: by 2002:a17:906:6702:b0:878:72f7:bd99 with SMTP id
 a2-20020a170906670200b0087872f7bd99mr9000974ejp.6.1679842018063;
        Sun, 26 Mar 2023 07:46:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669?
 ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id
 n3-20020a170906088300b009327ed171f2sm12237730eje.129.2023.03.26.07.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:46:57 -0700 (PDT)
Message-ID: <324e710d-de76-23dc-de4b-d34e32e63aca@linaro.org>
Date: Sun, 26 Mar 2023 16:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: alc5632: Convert to dtschema
To: Saalim Quadri <danascape@gmail.com>
References: <20230323130511.16367-1-danascape@gmail.com>
 <20230326131039.19190-1-danascape@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326131039.19190-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 7F4QJNZASLMCHYKCZWJ3F447NWKMA7MR
X-Message-ID-Hash: 7F4QJNZASLMCHYKCZWJ3F447NWKMA7MR
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, broonie@kernel.org, daniel.baluta@nxp.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7F4QJNZASLMCHYKCZWJ3F447NWKMA7MR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 26/03/2023 15:10, Saalim Quadri wrote:
> Convert the ALC5632 audio codec bindings to DT schema.

You got comment about threading. Do not ignore it.

> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Where is the changelog? What happened here?

>  .../devicetree/bindings/sound/alc5632.txt     | 43 -------------


> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        alc5632: codec@1a {

No improvements here.

> +            compatible = "realtek,alc5632";
> +            reg = <0x1a>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +    };

Best regards,
Krzysztof

