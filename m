Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7806DC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 15:17:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BE961248
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 15:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27BE961248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10CF4166D;
	Mon,  4 Oct 2021 17:16:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10CF4166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633360632;
	bh=4YOCudVqmkAQg0RmDhKJVbpmxR7GM7fnpoRvxKTmHck=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d59LLFNFxz1tF68YtD81ogGCH5YoZpLtsO47oWnuVNhOmj4DftGwwJKRnuSZqxPB5
	 3oQ9tbuxQuPTwF2PxhhqFA3qWwCLdi5P23Isez8fnAuSmb5zcBP79Y2BCB2huBAPzM
	 XOhSeRd4sTbhkDV51e3SsJgej7qZ+NuSWQj888uY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 746D7F80229;
	Mon,  4 Oct 2021 17:16:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3238EF80171; Mon,  4 Oct 2021 17:16:19 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90EFAF80171
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 17:16:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90EFAF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="jd4T8VeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1633360573;
 x=1664896573; h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=2KTYP+6+Oa+eVOZ4J5T/8XxYyfJctb51pSOnZcy78io=;
 b=jd4T8VeWu0k9vCE8wYwqlX7Fo6AwVZdd8SCCjBd7f2WIInENS4tqtdUR
 ys9AqIymk8pIrNE+53GqCmcM5OKkaxFlJzLPdgAN20EjSPYAT1DHPzkDR
 Z0nIBGjk/b3QWz54+zOp1UOmhUD5TkGynw9TYtrJiRWkwyzpdwZ4nZ//q
 LLRReGYZ4GrNLutBZKN77DBrR6qnwEVJ88wnz2bFJ0AAYK7GOi0NdBFRv
 4kZ0gJJn8aaIRHopl3UBG8xhqSgUma+RfRlLW5xdMZf6yQk3NiY/04Sw0
 plp5+BzSchDTVtKGiR6GINqj6ylBUwt7x96xQf0iYnCL4ONQte9KYIFH9 w==;
Date: Mon, 4 Oct 2021 17:16:04 +0200
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: tlv320adc3xxx: New codec
 driver
In-Reply-To: <YVr8tqRoyyiWR4xl@sirena.org.uk>
Message-ID: <alpine.DEB.2.21.2110041656220.14472@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.21.2110041115070.14472@lnxricardw1.se.axis.com>
 <YVr8tqRoyyiWR4xl@sirena.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail07w.axis.com
 (10.20.40.13)
Cc: devicetree@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
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


On Mon, 4 Oct 2021, Mark Brown wrote:

> On Mon, Oct 04, 2021 at 11:17:47AM +0200, Ricard Wanderlof wrote:
> 
> > +  gpios:
> > +    maxItems: 1
> > +    description: GPIO pin used for codec reset (RESET pin)
> 
> Usually this would be called reset-gpios and/or have a name to improve
> readability and allow for extensibility, from the binding we can see
> that the device has other signals that can be used as GPIOs.

In this case, 'GPIO pin' refers to the GPIO pin on the host side that is 
connected to the reset pin on the codec, not which pin on the codec that 
is used for the reset function. So I probably didn't express this 
correctly in the binding document.

My strategy was to just call the property 'gpios' and if more host control 
signals were needed, one can add a 'gpio-names' property in the future, 
but I see no other codec bindings have a 'gpio-names' so I think I'll 
simply change this to 'reset-gpios', as there are not any other pins that 
it's likely a host would have any need to control; if that happens we can 
add another 'foo-gpios' property when the time comes.

> > +  ti,pll-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0 # ADC3XXX_PLL_DONT_SET - leave mode unchanged
> > +      - 1 # ADC3XXX_PLL_ENABLE - use the on-chip PLL
> > +      - 2 # ADC3XXX_PLL_BYPASS - do not use the on-chip PLL
> > +      - 3 # ADC3XXX_PLL_AUTO - use on-chip PLL if possible
> > +    default: 0
> > +    description: |
> > +      Set on-chip PLL mode.
> > +      ADC3XXX_PLL_DONT_SET is intended for use when setting the clock mod
> > +      via the clock id in a machine driver and it is not to be changed
> > +      from the previous setting.
> > +      ADC3XXX_PLL_AUTO will enable  on-chip PLL if possible, depending on the
> > +      master clock and sample rate combination.
> 
> Why is this configured through the DT binding and not via the machine
> driver as done for other drivers?

The reason is that I want to be able to use this driver with the 
simple-card machine driver which doesn't have any PLL control options 
AFAIK, as the .set_sysclk callback clk_id parameter is always set to 0 
by simple-card.

> > +      Note that there is currently no support for reading the GPIO pins as
> > +      inputs.
> 
> This doesn't belong in the binding document, it's describing the binding
> not any particular implementation.

Good point, I'll remove it.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
