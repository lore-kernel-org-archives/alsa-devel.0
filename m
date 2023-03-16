Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BAFC6FD1F
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Mar 2023 23:06:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D6E01047;
	Fri, 17 Mar 2023 00:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D6E01047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679008003;
	bh=HTWUlx9Dw35bYeNjGahQAHa2bkt+N96TZ7G+0A5cZj0=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SzMm3W1aB4pISnVfHxHFK3I4dvdxGzpXjxDRW1Dp7NNkXqGeEeVNbOT7UEQ9wNf7L
	 t9X3hViKJSSW9CZfHDmL9dKraCV04laCCCKbipKrooNIibE9C+2g0Yc+yPsRijadyf
	 tW0zQPJ7Qm19qZO7COi0lt2S9IF9TDoiZL2OzCD8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8B80F80423;
	Fri, 17 Mar 2023 00:05:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F82AF80423; Fri, 17 Mar 2023 00:05:24 +0100 (CET)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com
 [209.85.166.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26013F80272
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 00:05:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26013F80272
Received: by mail-il1-f176.google.com with SMTP id s7so1858230ilv.12
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Mar 2023 16:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thMkU6ted+c8alWkbLjie9Y71TBDBsMu8SDhF9nCN7s=;
        b=Y65KFs0z7jLb/LqVYfJBmebC16uuiZPSgKQFosvdWJkEqmbyLo5ASY2YAzW5A700Tv
         QZOd45o4eUScc4hd56gk4d/qKPukQcDEl/qwXpJO5jr6MlBQst3TaxKHNbjK4Ik3N1+F
         67Hx8ipeAbd+BXNIHm7mlJMgSHN0h+36/lKpRC/cHpFUZVpgp+fdqGhJ8YAHj0ENV7Nm
         37HamMwnJNOMsXpKuyAuvWOWNbuWoUQlHxHtYtVvAmWvqgOdn9yP/0iCIGoc77+sAxv9
         b1gcykJorJWIWL7cCnpVIf2vs+9iBAbzx3YZ9yu4Dmr51dh1LR6VJzNeiIi/rF0P40Wb
         j66g==
X-Gm-Message-State: AO0yUKW4SfG35dlv5ZZg+dWL+ujdfK+ClJP1P3ldqBqhGYWH+9cU+xGC
	xeh5p/jBh/GFl6hT6qYijg==
X-Google-Smtp-Source: 
 AK7set+8oLHhJQmH6Hy7Rz+7+N2cSYpk23KfiyKAuIipRqOturr9duw5L/q51oU+HA1VHJOKO87qdA==
X-Received: by 2002:a05:6e02:1d04:b0:317:9891:8a28 with SMTP id
 i4-20020a056e021d0400b0031798918a28mr10902176ila.26.1679007913243;
        Thu, 16 Mar 2023 16:05:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id
 f46-20020a02242e000000b003c4e02148e5sm177775jaa.53.2023.03.16.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:05:12 -0700 (PDT)
Received: (nullmailer pid 4052527 invoked by uid 1000);
	Thu, 16 Mar 2023 23:05:10 -0000
Date: Thu, 16 Mar 2023 18:05:10 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,lpass-rx-macro: correct minItems
 for clocks
Message-ID: <167900791031.4052474.90763164656557078.robh@kernel.org>
References: <20230310100937.32485-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310100937.32485-1-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: PVDLHNRWJT7WJWHYZM2W5WIS7NZRG2MN
X-Message-ID-Hash: PVDLHNRWJT7WJWHYZM2W5WIS7NZRG2MN
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Andy Gross <agross@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, stable@vger.kernel.org,
 devicetree@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PVDLHNRWJT7WJWHYZM2W5WIS7NZRG2MN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 10 Mar 2023 11:09:37 +0100, Krzysztof Kozlowski wrote:
> The RX macro codec comes on some platforms in two variants - ADSP
> and ADSP bypassed - thus the clock-names varies from 3 to 5.  The clocks
> must vary as well:
> 
>   sc7280-idp.dtb: codec@3200000: clocks: [[202, 8], [202, 7], [203]] is too short
> 
> Fixes: 852fda58d99a ("ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital codes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

