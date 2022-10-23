Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936AEC433FE
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Oct 2022 13:09:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 752CC8B2F;
	Sun, 23 Oct 2022 15:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 752CC8B2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666530571;
	bh=yQzJrIJ3bSzyW1A1EB/FKJcVHpsy0ds+45stAWWcROo=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIYgVW0lMe6hjdx/oVjDS7THPhjIPsZiLQl7d31/hLp6cJzPwLNqihMuypOaXote0
	 vLcg7ZZQMY4a3N26iXOlVM28jzIZSdT8hVaFEo4vPoMsdiQZElFmsoelXvSljyOgU6
	 j+EQDl9BOXw3oOTTfKtYsLDp5YRjXkQG6UafaePY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14E87F80254;
	Sun, 23 Oct 2022 15:08:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFC6FF8026D; Sun, 23 Oct 2022 15:08:38 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53899F8011C
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 15:08:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53899F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tk+9lB/p"
Received: by mail-qt1-x82f.google.com with SMTP id g11so4362992qts.1
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2022 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M2gFbSafpLVxGrnK3Tg0qfxx8Aw3Ko79Pc/9rxHqkHE=;
 b=tk+9lB/p62KsoOWZwKVgbrB9kefnRaiILS3i9PUqiUK7nbDX7D5bE9WabBDSYYUH2V
 n0vMtsySnXCyuCStJyxfLd9kPF3pO6B8oqyVknFpBUG46r/w+n+QC6xgxoZXgAJdWc9y
 mZlBTLQQhZnMQNdH4VA4qh97EOFF/QxPFxP1fu3cm9UC1DI3TAIBrshJf+bS/XqyDKHq
 hdH4myOSAMFvp0ClzUdyfebmgOyqp4JiaHqB/YLIMFwKczDyjvMtL3XuvpDUcVHACQ1f
 HQe3KPdA1hD8oGrB9YUhHBfGj51/nLXH8u9QHf27YxmbO6USXTFn26lJSvhpMB9CvBYZ
 NTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M2gFbSafpLVxGrnK3Tg0qfxx8Aw3Ko79Pc/9rxHqkHE=;
 b=fynypW2P7uwRJbsrwBmZQ4p9QVbCMbamtA0kh2cgLF0ECyPhZN6EH3xdrXSL3CRBIi
 bao7L8IyOLay+Rlst+nvbM6+pxlB5M6KbL2s1L9/+Z8oA8BPxil7eutNlVtFJejIg38W
 RhmppPzV+6K+fwhR4T/195YQ00adBj5tAbenaWFH+24rhmTSEFeXLgR75i2+86/zJMhf
 IIgVzHul8hhIR6Uyz2K6ZJ9pivbzSdEvoKY05DhulppJpD/oVJIzZCViXe1cGROUTbOt
 PL53Zyjzyu7HL+aB1msQfkmbsQSuAlylvLomKTuCZOVi32mK6VWngyG2LKqJHhMPRiKQ
 jNFQ==
X-Gm-Message-State: ACrzQf1x9Tmmx7qJGQy/fHjINt481+zI0cNrDcPCWxLy77W/92wiKIFH
 zRe/4HdBZrhR9URVF8CONP3Jrf3g5AcU4g==
X-Google-Smtp-Source: AMsMyM4yB1O6iJktvFaOE7c4rZ/hz48mOlHEfNbFjhzth0nVbpSnr07dQ43Guds7Ay2eEvGS2vvzBg==
X-Received: by 2002:a05:620a:2905:b0:6ee:cf79:bf9c with SMTP id
 m5-20020a05620a290500b006eecf79bf9cmr20178717qkp.28.1666530503551; 
 Sun, 23 Oct 2022 06:08:23 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93]) by smtp.gmail.com with ESMTPSA id
 j12-20020a05620a288c00b006b640efe6dasm13061603qkp.132.2022.10.23.06.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Oct 2022 06:08:22 -0700 (PDT)
Message-ID: <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
Date: Sun, 23 Oct 2022 09:08:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 kuninori.morimoto.gx@renesas.com
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org
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

On 22/10/2022 12:27, Aidan MacDonald wrote:
> This is a new per-DAI property used to specify the clock ID argument
> to snd_soc_dai_set_sysclk().

You did no show the use of this property and here you refer to some
specific Linux driver implementation, so in total this does no look like
 a hardware property.

You also did not explain why do you need it (the most important piece of
commit msg).

> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ed19899bc94b..cb7774e235d0 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -57,6 +57,12 @@ definitions:
>        single fixed sampling rate.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  system-clock-id:
> +    description: |
> +      Specify the clock ID used for setting the DAI system clock.


With lack of explanation above, I would say - use common clock framework
to choose a clock...


Best regards,
Krzysztof

