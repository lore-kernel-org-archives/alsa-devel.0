Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D169C3B1A6
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E728D20656
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i9ohwpNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D55B1686;
	Fri, 14 Feb 2020 18:10:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D55B1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581700260;
	bh=cKIUgCdWxkkb2PIYZffI1L8Hs7ORKEv30EshOVg2CAI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9ohwpNoDnN7NGxIfo7tGIEWzoqq1tQx5+hoLM/dqSjrWy8OD0A1U9SnZOZxQc2Yy
	 fpn6AmLXG9+WYCGSyZnlnK/l0uCCm14qEM+x0v1Zcxzj8+fHUexqGb8dNdN65Vghqx
	 d2FAafqzCNEvf+9pXnOyhIH843xgNG6xROx7oP80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3921F80138;
	Fri, 14 Feb 2020 18:10:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6AC3BF8013E; Fri, 14 Feb 2020 18:10:08 +0100 (CET)
Received: from muru.com (muru.com [72.249.23.125])
 by alsa1.perex.cz (Postfix) with ESMTP id 5CEE7F80086
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 18:09:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CEE7F80086
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 0E82B80E7;
 Fri, 14 Feb 2020 17:10:33 +0000 (UTC)
Date: Fri, 14 Feb 2020 09:09:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Message-ID: <20200214170946.GB64767@atomide.com>
References: <20200211171645.41990-1-tony@atomide.com>
 <cd46c6ec-80e3-332f-4922-e58a3acbfc61@ti.com>
 <20200212143543.GI64767@atomide.com>
 <20200214003452.xuadnylj2udqyljs@earth.universe>
 <20200214013454.GX64767@atomide.com>
 <20200214130428.gkhmr55ptmi2bh2x@earth.universe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200214130428.gkhmr55ptmi2bh2x@earth.universe>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
 Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 "Arthur D ." <spinal.by@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: ti: Allocate dais dynamically for
 TDM and audio graph card
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

* Sebastian Reichel <sre@kernel.org> [200214 13:05]:
> On Thu, Feb 13, 2020 at 05:34:54PM -0800, Tony Lindgren wrote:
> > And bluetooth would be similar to cpcap_audio and mot_mdm6600_audio
> > above.
> 
> My understanding is, that CPU is not involved for calls (except for
> setting up cpcap registers correctly). Basically McBSP3 should
> remain idle for a call and data goes directly from modem to cpcap.
> The same should work for modem <-> BT, except that CPCAP seems to
> always provide the clock. That would imply a direct link between
> modem and codec / BT?

Yes the direct link is i2s. I'm ot sure if mcbsp can be idle during
voice call though, I guess it should be doable since mcbsp is not
the clock master :)

> > My guess is that only cpcap registers and clock rate needs to be
> > changed for bluetooth audio BTW, so if somebody havs a bluetooth
> > headset just do the following in Android:
> > 
> > # cpcaprw --all > /tmp/before
> > configure bluetooth headset for audio in android and start
> > playing some music or make a phone call
> > ...
> > # cpcaprw --all > /tmp/after
> > stop playing music or phone call
> > ...
> > diff -u /tmp/before /tmp/after
> > 
> > The registers will be different for a bluetooth phone call and
> > playing music.
> 
> I can provider register values once I find some time.

OK great.

Regards,

Tony

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
