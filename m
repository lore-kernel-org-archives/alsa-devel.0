Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8171CA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:02:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E82F21D7B
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B9SJ9HzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E82F21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4A9618AC;
	Fri, 25 Oct 2019 23:01:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4A9618AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572037346;
	bh=tqsy1cAeYpsxTeKHC09FUqX6Uoj4ZhWyPBZCu4mLPzE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9SJ9HzVnWSunFluozZ1pL7WMRy9iI99nWmRVbVP10KE7pV6UE8E23rYubmK3ZDvy
	 y6u0qSFL8vJjg2/atdQTnRdLKFlE/NVI2pC0mCPdRbZ6WVjQUEC8H8fWFqSXR1PxHG
	 vCWGnGAmJ6sm9PrrWgCPArfwYRFgI6epo+cwF2Gw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E105F8036F;
	Fri, 25 Oct 2019 23:01:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1559AF80393; Fri, 25 Oct 2019 23:01:35 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EE46F80368
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 23:01:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EE46F80368
Received: by mail-oi1-f196.google.com with SMTP id i185so2496917oif.9
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 14:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3GZj/07wyh3a92hj1bd5hj3RDEpvatv0XrhY5uaQn7g=;
 b=LBDV2eXaDFSmAJeF8FSq3DZhkYY3rESdJNQNcwV/cF6MDB+L+snLJ9ksBnIdQd9bM3
 VOUF8MTZ2KxmzTOXCgK0XZpBgkC2P+EoKB4ZcwL2p5mrkmZz4zMWECV1bNyxb0xQ/we/
 sA3tnsyAcYB5X691dIexv8jS28OunjqnuEue5GcwqMoexhEharf8oMqugrorVPbNYz0J
 QKSBK39bGonYBdrRjGOGk/1/cIw57jN3MRM1tqoQZDbcs8UHeeQaui+zqvdXa3rGIckj
 212FV1Jt/oemGHlFrO+W8/LKnRUQyemOpRNwbYSiGexOiY6NN/H9/Ov3E8txLfGmLaT3
 Iwew==
X-Gm-Message-State: APjAAAWcpnYT+dHdL29rGko5Ll0TIwdyKCXoeyFNkKHxRIibUhpJhVLW
 DB4D0nJLxw0wyOPiysUkVg==
X-Google-Smtp-Source: APXvYqyweattnE1/2tTLytH55gaAaW+EA9Y+8YXDzO7mVMdzeeqlnIriXwq3vJ1VvxxICllZfVpAUQ==
X-Received: by 2002:aca:e0d5:: with SMTP id x204mr4880654oig.112.1572037290729; 
 Fri, 25 Oct 2019 14:01:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q9sm1077094otc.53.2019.10.25.14.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 14:01:29 -0700 (PDT)
Date: Fri, 25 Oct 2019 16:01:28 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191025210128.GA7212@bogus>
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-11-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018001849.27205-11-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vinod.koul@linaro.org, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lee.jones@linaro.org,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 10/11] ASoC: dt-bindings: Add compatible
 for DB845c and Lenovo Yoga
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

On Fri, 18 Oct 2019 01:18:48 +0100, Srinivas Kandagatla wrote:
> This patch adds compatible strings for DB845c and Lenovo Yoga C630
> soundcard. Based on this compatible strings common machine driver
> will be in better position to setup board specific configuration.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sdm845.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
