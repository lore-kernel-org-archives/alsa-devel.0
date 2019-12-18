Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5822C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:42:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66125218AC
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fk46Olqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66125218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BC991655;
	Wed, 18 Dec 2019 21:41:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BC991655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576701742;
	bh=Z0O2H+mBOSv7KZ8uY9jIUoleu/WcwCi8uhK5TsXz15Y=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fk46OlqvdC4HLzr+3DIDJnBfXlnKAcARQLjCMsyc2dQmeRAXGrcwbU97hjbHiI535
	 yK3bl3LBRJSLjvmLAPzlxcXlSVjLZo22+FxAScrA8Oi4ENLV9gkHZAqWFlTbdr18iz
	 vMO0AISOUbnzLUuYrJa6tXOMoReWxTc1pY7/63ms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB288F8014C;
	Wed, 18 Dec 2019 21:41:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AAF1F80096; Wed, 18 Dec 2019 21:41:30 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67037F80096
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:41:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67037F80096
Received: by mail-ot1-f65.google.com with SMTP id h9so1476721otj.11
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 12:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vjAWgj8LPRVBBw4YOgmZJNGJyNN6iEbkQXZFrIxWMd0=;
 b=c8WTJyVHkUuHH9mY18kPy9YtncjD7U1u4dfc57u/Y7Jg/qdsjOKc/NAJJnQRh1OLEV
 H/pXobkFkDw4Y9OM1X+yQk+doBGrL39/awlydJ9noOo72pQjiLbys4pD5V3s72ud9Y46
 nD0geqAPznUJOodSgv8napruT4B69QdDN5nexzDFO6bVDNxEHS2LFBd09n9YRZ7v4/Q0
 4XPQpul+fTjuH/eDsL+l9HRtf9HJNNqcsKv8I/8Mq210LZd6muo7XFg8PE30pTbjmIKd
 IzC7wesF/MY6mKX0eFCOk/MFSnCLQyX4sRyqHpMZpKkz1/BEEsBMOOcg7lGn0N1e09hi
 AV8w==
X-Gm-Message-State: APjAAAVUfz75V8W788eYy3LsCjgueEChTk5ut5ZRbqfYJdU6EvwIbSaA
 CCXmtYsL0x2edV0pPYsi7Q==
X-Google-Smtp-Source: APXvYqzQqGo/mhAS3tDmnfbWxDRBX1it8whjpDyON36SIKPZWsEZwe6SklGflwoLOyGplD0lHy7Kkw==
X-Received: by 2002:a9d:7a88:: with SMTP id l8mr4842838otn.187.1576701685257; 
 Wed, 18 Dec 2019 12:41:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s9sm1180127oic.15.2019.12.18.12.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 12:41:24 -0800 (PST)
Date: Wed, 18 Dec 2019 14:41:23 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191218204123.GA18202@bogus>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
 <20191217121642.28534-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191217121642.28534-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vinod.koul@linaro.org, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lee.jones@linaro.org,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v5 01/11] ASoC: dt-bindings: add dt
 bindings for WCD9340/WCD9341 audio codec
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

On Tue, 17 Dec 2019 12:16:32 +0000, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9340/wcd9341 audio codec which can
> support both SLIMbus and I2S/I2C interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
