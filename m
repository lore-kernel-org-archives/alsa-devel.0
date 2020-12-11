Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8CC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 20:28:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABCF24052
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 20:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABCF24052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70E9B1750;
	Fri, 11 Dec 2020 21:27:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70E9B1750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607718500;
	bh=aOw0RfZFMvx+4fMpScAcwGXgVLkPZUxWahDI1GJz4k0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onXO7Wza3MkPIkxtkLqdjbze492esnvl5x5TsxvlDp4foXx4sanjYao4qGFVJb35N
	 VvuvgdI+xAD/BN4J5BKe4xwciEZF+ZvvQlIMV96ZEy5LP0bVSrOcJUZ1aaWYsmnGyG
	 2fqpdOIqyhN5EIGsI4RqWe5xcj0VUbcqsqAkHE0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F46EF801D8;
	Fri, 11 Dec 2020 21:27:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CACF5F8020D; Fri, 11 Dec 2020 21:27:27 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A10CF8011F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 21:27:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A10CF8011F
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2A68660002;
 Fri, 11 Dec 2020 20:27:19 +0000 (UTC)
Date: Fri, 11 Dec 2020 21:27:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Message-ID: <20201211202718.GI1781038@piout.net>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
 <20201210020545.GA1480364@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210020545.GA1480364@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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

On 09/12/2020 20:05:45-0600, Rob Herring wrote:
> What's wrong with the generic mux binding and driver(s)?
> 

The main issue is that the driver doesn't expose audio routes and so
DAPM can't do its job properly. Also, it is more convenient to have the
control part of the ALSA sound card which is not possible with gpio-mux.

You could argue that we can have simple-audio-mux use the mux subsystem
but we still need a new binding and driver anyway, just as we have
io-channel-mux or i2c-mux. I'm not sure this would be useful but I can
be convinced otherwise.

> > +
> > +properties:
> > +  compatible:
> > +    const: simple-audio-mux
> > +
> > +  mux-gpios:
> > +    description: |
> > +      GPIOs used to select the input line.
> > +
> > +  sound-name-prefix:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Used as prefix for sink/source names of the component. Must be a
> > +      unique string among multiple instances of the same component.
> > +
> > +required:
> > +  - compatible
> > +  - mux-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mux {
> > +        compatible = "simple-audio-mux";
> > +        mux-gpios = <&gpio 3 0>;
> > +    };
> > -- 
> > 2.28.0
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
