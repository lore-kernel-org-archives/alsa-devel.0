Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE07C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 20:03:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB48720658
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hjC3PPL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB48720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DF391673;
	Tue, 31 Mar 2020 22:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DF391673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585684992;
	bh=c3ae9kn65pDkOCfHTKewNDcf0QCCjBeMT8l+odqiohw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjC3PPL0NFYz0g0QdlQ2/DKG3joPKRHebuESnGVW7p5hzVQjrhRic0Q+t4JH9dyRU
	 xDahj3yLCmwaM5GHGSIS/UxSqIxPYF+KYn8IKeb7Q5rjhkE6SYRfBmsG6wbyXRaD8s
	 aNLFxIhDilp+L8bwy+EdqebTSDLR2Puwv31I9w64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A443F80254;
	Tue, 31 Mar 2020 22:02:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98D5BF80255; Tue, 31 Mar 2020 22:02:04 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B40F9F80157
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 22:02:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B40F9F80157
Received: by mail-il1-f194.google.com with SMTP id r5so20727260ilq.6
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 13:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=inn69R6pXVv7tn5IiOj3WCmHSXEzB0bu6RYjdj4+w9I=;
 b=Jaw56tn3KgVwrJjrCBkwC1ScQnD7CJQL+ZYy/uL9O9cJyvlaUoif96tpHlW9Z6rsb2
 xLW8Fj0GnOqdWTlBSqLY+1L8aP/J9z/B8jqe8J9eib6epr2WrcGL9Pu1hDvytS+dhXyW
 Qbc/6hov6vnm1esXp37SjCqFLQHjRQ3OIc+Q8m+rCDBAFm/9dtuOHztSViTuGeUOlJLx
 OU3onKa63CvFvUJDbdtc2H8lU2LXU7IFsMVwHn/2VgMosJXxEH1AczvQ79O5A2UYG7k4
 1gIFTnqBwRfflHded2llJDtJ0raHj0DTTTAKgy4lVAGp6zUwQCw85J4p/9H97K2ZrdF7
 q+Gw==
X-Gm-Message-State: ANhLgQ1GG5ug4C9PaC+lGdlEuY/aTrZ4s56sCWnkGLBV4mBbZjazQxLU
 i0ecWeWCXATw9z/6YlDWJg==
X-Google-Smtp-Source: ADFU+vsICc4DhBvaBEO5MjNBpVjmJPABPfazkSQ87pqZhrYedeNGTExxSKz2gZT+RvOxqRGZ9E7szA==
X-Received: by 2002:a92:9c54:: with SMTP id h81mr18455056ili.109.1585684919454; 
 Tue, 31 Mar 2020 13:01:59 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id r29sm6263789ilk.76.2020.03.31.13.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 13:01:58 -0700 (PDT)
Received: (nullmailer pid 7245 invoked by uid 1000);
 Tue, 31 Mar 2020 20:01:56 -0000
Date: Tue, 31 Mar 2020 14:01:56 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: sound: rockchip-spdif: add
 power-domains property
Message-ID: <20200331200156.GA7186@bogus>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324123155.11858-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324123155.11858-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 24 Mar 2020 13:31:55 +0100, Johan Jonker wrote:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'power-domains' for rk3399,
> so add it to 'rockchip-spdif.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
