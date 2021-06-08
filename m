Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA95C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 20:52:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ACB61182
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 20:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ACB61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DC0116BE;
	Tue,  8 Jun 2021 22:51:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DC0116BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623185519;
	bh=3/5wXXYgxqv+FdHTQXmPH6XWsajohdBz2lPH9wRiPfY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BtkRzlnPvIp7CVXgqO8BoIdw9tMvfMFSx98aEDj6269iWdTDedqGhttRM7z63rwF6
	 YSu9/ip9pJpZrYeAiLSDPvqiW5G1hK5D1t5jz1OTk8zBm8FWb9Nj7MehDaYdBip9B9
	 8au9cCU+Ni/DIV5ktQ43xyR+iliH/vuz2hhs0b6A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0334AF80218;
	Tue,  8 Jun 2021 22:51:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C099EF80227; Tue,  8 Jun 2021 22:51:07 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8A5FF80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 22:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8A5FF80116
Received: by mail-oi1-f175.google.com with SMTP id h9so22929916oih.4
 for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2021 13:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=wwiC9g3wdjtEd/NglS+/cMH7OphwcIAcmbuqcv3Ok7k=;
 b=M01d4Bdgv/OI6F0+OlQZLAkM1uWJZ+LomkVeUUUh1+VvUrZpSrLr5H7Tr05HH17ltn
 NG/uD5JHaV76cfBrI4HWHHE3S7qD3QxlEManJeRQGi3cdvZ0ow7lKw5YCCCUkaPx9K+m
 TjxgAH7qWrGMi7lyoI+1vWw69UZRJdRIAtzvF5CM9IPo4BfTC9BK/NuN1H+benF6LDLY
 9ZoxHiOB8ZOWXjE0/LMRA7LULTHU4GdA4qgmhFqAqki/H+qzn1p5VpdDhsIa6n5uaEs0
 xZrPD+tZIJlwz80BYjVtPf3KFXee1TZREs/PmR3rFOo1YMplmGSpVyeOFNfhoYccxZDh
 ZcZQ==
X-Gm-Message-State: AOAM531Grr9uYskaAFlIb7u0hnBzCAjjbmelAX8EmIRoRMDUJRZ2OAl5
 NR+6+8jUuJ0ABnc2HLvQRA==
X-Google-Smtp-Source: ABdhPJxBg367eNdR+0mi3NKIw48pRIV9UMfAqjUgOOTnSa4EARGainMEL2UgOd9HbWQFQI5IwpJbiw==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr4164214oie.9.1623185458371;
 Tue, 08 Jun 2021 13:50:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b26sm2974012otf.69.2021.06.08.13.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 13:50:57 -0700 (PDT)
Received: (nullmailer pid 1556861 invoked by uid 1000);
 Tue, 08 Jun 2021 20:50:56 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
 <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 01/13] soc: dt-bindings: qcom: add gpr bindings
Date: Tue, 08 Jun 2021 15:50:56 -0500
Message-Id: <1623185456.792100.1556860.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 plai@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
 bjorn.andersson@linaro.org
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

On Mon, 07 Jun 2021 16:28:24 +0100, Srinivas Kandagatla wrote:
> Qualcomm Generic Packet router aka GPR is the IPC mechanism found
> in AudioReach next generation signal processing framework to perform
> command and response messages between various processors.
> 
> GPR has concepts of static and dynamic port, all static services like
> APM (Audio Processing Manager), PRM (Proxy resource manager) have
> fixed port numbers where as dynamic services like graphs have dynamic
> port numbers which are allocated at runtime. All GPR packet messages
> will have source and destination domain and port along with opcode
> and payload.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,gpr.yaml           | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom,gpr.example.dts:19:18: fatal error: dt-bindings/soc/qcom,gpr.h: No such file or directory
   19 |         #include <dt-bindings/soc/qcom,gpr.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/soc/qcom/qcom,gpr.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1488752

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

