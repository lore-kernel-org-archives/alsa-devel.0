Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1CC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:13:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A256C2070A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AtQZzJlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A256C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0DB41658;
	Mon, 23 Mar 2020 23:12:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0DB41658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585001610;
	bh=0SFNX+KNG0mT1qcnYA/8qXz0HxLAOipFcFinQJJVi2U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtQZzJljj8nvw3GKLzviBIAsHee2j3edtdNezFwYcFpAHZ+ACJxFuZLA9IlwFqpi5
	 bmklH/RbtohJjlbnoKJ8pOg2cYDQlF6zqSXsX+potcZFPcaF6YOxAhDcVIKXP0mpQg
	 33+uYIpRG/rK+rHmsolp2ikX5QyOj7L1/YZgYANY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39073F80158;
	Mon, 23 Mar 2020 23:11:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C174F80158; Mon, 23 Mar 2020 23:11:54 +0100 (CET)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC398F80158
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 23:11:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC398F80158
Received: by mail-io1-f67.google.com with SMTP id a20so8817718ioo.13
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 15:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=U1+vG2jcfIWPGJPzyBp74dMfazPVWUvbyc5a9UEJny4=;
 b=ZFL12DYgYIcBM3VP3pGk/t8A7V2b293m9rdyO22veIPADOUQyLCemms42JccT6epZe
 1IyZy8q4qARHkzYGx4L1dbCAyaiWt0pZ6oCvVrhIcgm6MHI8VU/bslv8+ZVCpw8goXpO
 nBrj4gD3SnFt+8huVxXFmL8HJ4LcP4YMi/GBc3fqKkPYK+emI5Qq9+QJ57sjiRqycj9g
 Q+OlbtIIECGrPpTkx5orwi62fohvyAuoZ+mBqovR+QmeH3vU+ywd4Wo75x1N+DnuJYqV
 J6ckmUjk6czsCZkaunQYYu0wJTZUnUQ+t6mvWf+VPQU4LqFRPFvn/bMNN+LCwW+jHcoT
 mqkw==
X-Gm-Message-State: ANhLgQ3vOezxeHmQ8tJi8vfCILJBHtHgsS7LeaWlOlYn381RLYdIg/eI
 fZFDRMR+LaDEjD+HmLM/EQ==
X-Google-Smtp-Source: ADFU+vvetfKAazjwYEUQHArdmRpyTlu8v3T8bGybvvKdNYFA44bdB5Y0qTiQGUn5qPEk9T9rFv8mPw==
X-Received: by 2002:a05:6602:2251:: with SMTP id
 o17mr10228130ioo.101.1585001510153; 
 Mon, 23 Mar 2020 15:11:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id l6sm5745706ilh.27.2020.03.23.15.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 15:11:49 -0700 (PDT)
Received: (nullmailer pid 29035 invoked by uid 1000);
 Mon, 23 Mar 2020 22:11:48 -0000
Date: Mon, 23 Mar 2020 16:11:48 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: sound: rockchip-i2s: add
 #sound-dai-cells property
Message-ID: <20200323221148.GA29003@bogus>
References: <20200311174322.23813-1-jbx6244@gmail.com>
 <20200311174322.23813-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311174322.23813-2-jbx6244@gmail.com>
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

On Wed, 11 Mar 2020 18:43:22 +0100, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property,
> so add them to 'rockchip-i2s.yaml'
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
