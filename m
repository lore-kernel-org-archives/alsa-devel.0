Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20782C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 17:55:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1936B650DE
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 17:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1936B650DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9174318E3;
	Tue, 16 Mar 2021 18:54:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9174318E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615917322;
	bh=NPprGX8BJ4tQnxGo72qZi23hyb1ValoJ4BM1yd9cnM0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ti1H3QswiSPzpzkfwHk6eIJzGeSIqywFS0cnJExCetAk8Ng/uFmIqfVBZ+qK3b6sJ
	 J4HvKKfrTAsj80MS+pXloqZyUoo8X+cifV4DlzX/JRswj0LEPmb8EOREqs5GHIZVdL
	 agvFYWUaiWWqbEVzkgwJKqw5VtkRAcBk6KYa/aYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15A44F80156;
	Tue, 16 Mar 2021 18:54:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ABAFF80163; Tue, 16 Mar 2021 18:54:30 +0100 (CET)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BB4EF80148
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 18:54:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BB4EF80148
Received: by mail-il1-f169.google.com with SMTP id p10so13530087ils.9
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 10:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=+kI9PWgxxjp5TX4kZseCNqfbTJcpurWf3Z5A5Al1nrg=;
 b=aMMzTuLS8Z8FDQT4CfNjbyA4SFLyflw7FVR9oPmw7iLPSuQD2S909pC4iyW3AZKssL
 tAo8NHYaBpukh2Dt6XrJ4v3l/3Tvz1j/QUTcCKYUN4IRMyzHJibOeecAvbHLZB/wWApG
 UcjG6ndvY1c8YhjqeZWjGCkDW37SUfCkAFaCzbf1TO55nM3CRU2t/EF3NygVEjSFfUuP
 Z8R650nHwdv4fNTYluK1VdH/K0bf9WsQwgExcVuRxL8Cc+R05jCW+nFqEINbUxgyG7Dz
 KEYs8GgigrppJtgItSYdmibsglEzf6mhgc1wQTQuFQLvE52jzrY1mph5+l9PhXPNWt7K
 iqyQ==
X-Gm-Message-State: AOAM531HKvYFcwF+2A70awxkUVEFAmxVji+UCh+HLJYGlYiGbdFrgNC9
 mhP6mOOvGgnb9gcZHyKbqg==
X-Google-Smtp-Source: ABdhPJzj4jwke+G26mZFGHSOiXxtNewCW2IJj+QfJpWnFbUQSSzi2iviqzwbAWxsbu9ZU1nAgGlJbQ==
X-Received: by 2002:a05:6e02:b25:: with SMTP id
 e5mr4852271ilu.119.1615917261431; 
 Tue, 16 Mar 2021 10:54:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id h128sm8978507ioa.32.2021.03.16.10.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 10:54:21 -0700 (PDT)
Received: (nullmailer pid 3326127 invoked by uid 1000);
 Tue, 16 Mar 2021 17:54:09 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20210316105828.16436-2-srinivas.kandagatla@linaro.org>
References: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
 <20210316105828.16436-2-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
Date: Tue, 16 Mar 2021 11:54:09 -0600
Message-Id: <1615917249.257390.3326126.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

On Tue, 16 Mar 2021 10:58:22 +0000, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: properties:qcom,mbhc-vthreshold-microvolt: 'anyOf' conditional failed, one must be fixed:
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
	Additional properties are not allowed ('$ref' was unexpected)
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 was expected
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: ignoring, error in schema: properties: qcom,mbhc-vthreshold-microvolt
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml

See https://patchwork.ozlabs.org/patch/1453827

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

