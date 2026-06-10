Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D175CCD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:31:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 178A560202;
	Thu, 11 Jun 2026 21:31:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 178A560202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206304;
	bh=oZRsTOopmsHuuLRo/SvOPe2iEO5p9MRq3KT651K81Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GStVn/2r2Rwh4fUHzP5CD2eJSVwag/gCOY0b5M61mNLrD+mQd55RwnELiKZF1Om0I
	 PQQHPUXE8YXTDQPLF0vmb5yrxUIt12FP0Xte9WAHOUANApriOWRCu2QX/9kHOYmUNO
	 qQd3MHcHT/KUGIqDBnjpiaI7bGj4pjN2WFYkPFhY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EA43F8060E; Thu, 11 Jun 2026 21:31:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1323F80616;
	Thu, 11 Jun 2026 21:31:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAF70F8058C; Wed, 10 Jun 2026 11:58:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=61.135.153.176
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781085511;
	b=VI7gqBbLuNMXlxYGdqcQZvCGEugQCjB+qoL1F6iAl0stUgv5Lu7uodnVInIJWfnLrxK0
	 02x7++AKKJbY0nJiNA34FA3GXaG6oXpayQgwpXGwXlBF+VYdcNhp2Iu7+ZS2I9gkV0oiB
	 eKnIQu1BDFoTdxo4H2V5CPkLBo5XrnQgrQtZtTeDZD3io9h1EYOzIT11R6lqYlYnARsiZ
	 VZlSzcUUKe3nE+LeOzC1hKa0V2DEwZgZHIeu6UqXfLVNuBLe/eipdrTI2kuNupYbMoEeL
	 bnz/eOizrEf0YXdf3Nhr4sO/bAvqA+clnKG3NENowd4i1xCiPd2v5THLLzNdpwRzIpA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781085511;
	h=From:To:Subject:Date:Message-Id;
	bh=oZRsTOopmsHuuLRo/SvOPe2iEO5p9MRq3KT651K81Ns=;
	b=dm1dZq2hiAPEtRLD0MUbFkSeD6bMC8jZTjX/4YDK82jZs336R6WIJp1vZyNaditoZ4v4
	 4/DqVevjEnMx0qaRNzk6JcBrQfAykO2GqEO4eSukO//uXR3iW9FAIjL6vUdo8DTMwudM6
	 ZUF7mtrebKoaxW7yP/MJJDILqXgjxmBzoJuw9z/B8rpCICSyLmcy5jfLnj+xI25PeWaFk
	 oSdyY5w/IeWFNl6lIMjGesjxWNxibhzTJp7xL/v5T9mriBYG0EAy+9BhzmR3NN42315xY
	 VRVPwFMH3AcIL9ACHqfX6L5rgY5qg7mpaGu/MIych+hxHUFPmbPP7kJdZ7op19LpFWQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=61.135.153.176
Received: from smtp153-176.sina.com.cn (smtp153-176.sina.com.cn
 [61.135.153.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07BC2F8057E
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 11:58:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07BC2F8057E
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A29353E00000515; Wed, 10 Jun 2026 17:58:23 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 6D30F50FCC8345E9ABD23D34604E4AC3
X-SMAIL-UIID: 6D30F50FCC8345E9ABD23D34604E4AC3-20260610-175823
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	zhangyi@everest-semi.com
Subject: RE: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Date: Wed, 10 Jun 2026 17:58:20 +0800
Message-Id: <20260610095820.25386-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260609-vociferous-thick-lyrebird-d53eda@quoll>
References: <20260609-vociferous-thick-lyrebird-d53eda@quoll>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: OPLA42UT6XIWUTMZZLP5VP3KPAQZ6BXI
X-Message-ID-Hash: OPLA42UT6XIWUTMZZLP5VP3KPAQZ6BXI
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:04 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OPLA42UT6XIWUTMZZLP5VP3KPAQZ6BXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> Please organize the patch documenting the ABI (DT bindings)
> before the patch using that ABI.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Thanks for the reminder

> > +  everest,mclk-from-sclk:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that SCLK is used as the internal clock.
> 
> And what happens with mclk in such case? Is it still wired?

Yes, setting mclk-from-sclk does not affect the MCLK connection.

> > +
> > +  everest,hpfl:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      the HPF value of ADCL.
> 
> Is HPF value in dB? If so, use proper unit suffix and proper units.

No, the values here correspond to the values in the registers.
The value is not in dB

> >          vddd-supply = <&vdd3v3>;
> >          vdda-supply = <&vdd3v3>;
> > +        everest,hpfl = [0a];
> 
> <0xa>? What did you want to say here?

I just wanted to give an example to show how to set the values of everest,hpfl to 0x0a.
