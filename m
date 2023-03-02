Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7088C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 17:42:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 598A31138;
	Mon,  6 Mar 2023 18:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 598A31138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678124534;
	bh=zNFg3g58A6At2E/UN+WhZGHysR3G6djHwYK8Bo1cXM8=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EHrVt8gLHTSks4ESSZhoNvZIFzVRivWw5Jg68Koko+HMNyvrDs24p6pH/Gp5+ykpU
	 mBV+RzRIdZUrSfqc9li0H3l79S7rrbDtpk9rVo/H4YMPOZObhMbelMU/LqLWndUO/e
	 2jyMcp/LsPSj4rBtLeOSAWGS0BefaVrfapQujUJU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7ACCF8057B;
	Mon,  6 Mar 2023 18:39:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9C54F800C9; Thu,  2 Mar 2023 15:56:27 +0100 (CET)
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com
 [IPv6:2001:41d0:203:375::2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 12D0DF800C9
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2023 15:56:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12D0DF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=OIYZVa8x
Date: Thu, 2 Mar 2023 15:56:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1677768983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxgz5UQd3A33vj8wyykxd/501uILI+WSmew/oO4u+js=;
	b=OIYZVa8xVYW7rLRG5+M8Y5DTCcm6aYWIjQV5dj4jeBysQwow6+hKr6Ay5EwiCLNmjrpHfS
	0J63xuoA0HSbKsvn/WVaBu8df/GaCw+Y80clS9UlprcV2K8HjBr8PDLSY9nC/ZCpEzccWT
	h08p39RfB9vrzEIgtVCzeMYY5ZsOj9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: maxim,max9867: add "mclk" property
Message-ID: <ZAC5Fb/6gGUuIFix@g0hl1n.net>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-2-aa9f7f25db5e@skidata.com>
 <53975f44-83cf-7942-ff2f-727a2d9a0bc3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53975f44-83cf-7942-ff2f-727a2d9a0bc3@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-MailFrom: richard.leitner@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: N4YUQMSTKS3XUMC6C7QA6ES7BWDQ6YWH
X-Message-ID-Hash: N4YUQMSTKS3XUMC6C7QA6ES7BWDQ6YWH
X-Mailman-Approved-At: Mon, 06 Mar 2023 17:38:45 +0000
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ladislav Michl <ladis@linux-mips.org>, Takashi Iwai <tiwai@suse.com>,
 Benjamin Bara <benjamin.bara@skidata.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Richard Leitner <richard.leitner@skidata.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N4YUQMSTKS3XUMC6C7QA6ES7BWDQ6YWH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Mar 02, 2023 at 02:31:45PM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2023 12:55, richard.leitner@linux.dev wrote:
> > From: Richard Leitner <richard.leitner@skidata.com>
> > 
> > Add clocks and clock-names properties to require a "mclk" definition for
> > the maxim,max9867 codec.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> > ---
> >  Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > index cefa43c3d34e..152340fe9cc7 100644
> > --- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > @@ -35,9 +35,17 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: "mclk"
> 
> Drop entire property, you do not need it for one clock.

Thanks. Will fix that in v2.

> 
> Best regards,
> Krzysztof
> 

regards;rl
