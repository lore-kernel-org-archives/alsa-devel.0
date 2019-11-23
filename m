Return-Path: <SRS0=uL/f=ZP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D3C432C0
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Nov 2019 00:05:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BCF2071F
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Nov 2019 00:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EXAt6jxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BCF2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 634471847;
	Sat, 23 Nov 2019 01:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 634471847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574467516;
	bh=EnNnMn0PxSHsdg1x4bVNVMtgdyK5gt2tEEkGBUEO0fM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXAt6jxk4hsk0YmUHZcfL3uOgtHta5BafESZrRAu/FypYylD+ch7uReqVTWrqrxAk
	 YoTnIV2BzCUwtCEHF87ACVMOb3kJyu604X1LTWL+CThyGdbIQhf1GNCTDSoCfNglPC
	 GVDbf/RutnNoFgSF1V6eiHRnB6qIZJEC9l0NZaAA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA2C2F800EF;
	Sat, 23 Nov 2019 01:04:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E41FF80140; Sat, 23 Nov 2019 01:04:24 +0100 (CET)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1F93F800EF
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2019 01:04:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1F93F800EF
Received: by mail-ot1-f68.google.com with SMTP id 66so1597784otd.9
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 16:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mh7ibfrhNKP+OX0OZlKsFx13aIqVgLPbq5iGSYIdzxA=;
 b=XPhGw15xlHOTMATlljxQ5yN32JvPSxPUf9KJnN9zFnpo2tvooh5CbKEYnWt9MzjbCE
 M7pMb7ifr6eB8NY/8QsdAqHZDnNflc6+uHGXmmILWYSKShxg7QAWm1Dx3GdF+BdwRPtZ
 BG14UcL1xcVTxn4fkkA+3YwXPaFPYIirdFkPKwzbjyg+wktqukMlmnRnoHDvrtDaCzGe
 VI7SVApx9IRrfphQty7wMOWVeYqya8wioWzTmT8acUUQj1hEoGX9rf5xIH3nvny7eMS6
 KL9VeGHmXFY9XGaxWiQo1IA/f/KrOu7OiMiF0gh9TwEEzCHG0B2YtOEVw4u9v9WAG5Mn
 2pTQ==
X-Gm-Message-State: APjAAAV0QcS6PljsnZg0RQeHKFCBZmynMwxuixEGIQqhTMHiJtkJgRg4
 N5n7bBBq7AVYIYS/4lFEXQ==
X-Google-Smtp-Source: APXvYqwdcuZg6Ci0LUijlWn0ZMT85d8WWT5QI9fVNF6xt5nP6k61iZb1lUjrwcAuJgzF2ivfZniaaQ==
X-Received: by 2002:a05:6830:50:: with SMTP id
 d16mr12263248otp.132.1574467459915; 
 Fri, 22 Nov 2019 16:04:19 -0800 (PST)
Received: from localhost ([2607:fb90:bd7:3743:c9ec:246b:67b7:9768])
 by smtp.gmail.com with ESMTPSA id x11sm2563645oie.25.2019.11.22.16.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 16:04:19 -0800 (PST)
Date: Fri, 22 Nov 2019 18:04:17 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191123000417.GA30207@bogus>
References: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
 <20191121170509.10579-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191121170509.10579-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vinod.koul@linaro.org, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lee.jones@linaro.org,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 01/12] dt-bindings: SLIMBus: add slim
 devices optional properties
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 21 Nov 2019 17:04:58 +0000, Srinivas Kandagatla wrote:
> This patch adds an optional SLIMBus Interface device phandle property
> that could be used by some of the SLIMBus devices.
> 
> Interface device is mostly used with devices that are dealing
> with streaming.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/slimbus/bus.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
