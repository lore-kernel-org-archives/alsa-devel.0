Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F080EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 08:03:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68648846;
	Thu,  6 Jul 2023 10:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68648846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688630610;
	bh=ayLJp31nJ6Yl5NFkfUvKiaWb+y0gBRcbvcjmkiGFVeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GVrFxavZiaqT0HGj+qJwKWMOawQDniobmfkdC5wl6VJLhjCIwtlNbae1Bzv9yW7ee
	 ET6oLS/xi2Wmm3U3Xifj6sWh9dP4+nqG9T276kdk8uxkryM6IvLfbbU+mG/3dBwe0T
	 2jZWiNjA9h+gYbgqY31aGMvEdVksVBksrVCnzCrY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50770F8058C; Thu,  6 Jul 2023 10:01:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA298F80587;
	Thu,  6 Jul 2023 10:01:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D0BCF80125; Wed,  5 Jul 2023 21:56:25 +0200 (CEST)
Received: from mail.andi.de1.cc (mail.andi.de1.cc
 [IPv6:2a02:c205:3004:2154::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05B7FF80100
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 21:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05B7FF80100
Received: from p5dcc37f0.dip0.t-ipconnect.de ([93.204.55.240] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1qH8bl-0017gV-0E; Wed, 05 Jul 2023 21:56:13 +0200
Date: Wed, 5 Jul 2023 21:56:11 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
 dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/3] ASoC: tlv320aic3x: use BCLK instead of MCLK if not
 in master mode
Message-ID: <20230705215611.5f96584e@aktux>
In-Reply-To: <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
	<20230705190324.355282-3-andreas@kemnade.info>
	<15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailFrom: andreas@kemnade.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ROY3XPJGPKL5B27EYQPBDLYJO6S4ZTN2
X-Message-ID-Hash: ROY3XPJGPKL5B27EYQPBDLYJO6S4ZTN2
X-Mailman-Approved-At: Thu, 06 Jul 2023 08:00:55 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ROY3XPJGPKL5B27EYQPBDLYJO6S4ZTN2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 5 Jul 2023 20:21:58 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 05, 2023 at 09:03:23PM +0200, Andreas Kemnade wrote:
> 
> > +	/* probably no mclk if not master, so rely on bitclk */
> > +	if (!aic3x->master)
> > +		clk_id = 2;
> > +  
> 
> This is fairly clearly a massive hack, we're just silently ignoring the
> clock we were asked to configure and choosing another one which is
> likely at a different rate to that we were expecting and sadly the
> driver didn't provide an automatic mode due to how old it is.  We also
> appear to try to use the configured clock rate during PLL setup which
> still happens in hw_params() even with this change which is a bit of a
> concern here.  Are you sure hw_params ends up doing the right thing, and
> that there are no other systems that get broken by this (perhaps ones
> sending a lower BCLK for example)?

Yes, I am not that happy myself with that one. Possible victim is
keystone-k2g-evm.dts. 
I looked for if (master) things and found the pll enable/disable connected to it.
But that is not the whole story...
> 
> It would be nicer to set the clock via the DT bindings, ideally with the
> clock bindings...

I found no path from these simple-audio-card things to provide a clk_id 
to set_dai_sysclk. I would of course prefer such a thing. Do I have overlooked
something?

Regards,
Andreas
