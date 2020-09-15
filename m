Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36051C433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D5820829
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eYp2dmyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 471C786E;
	Tue, 15 Sep 2020 15:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 471C786E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600174992;
	bh=ni4tF67YYxO9w+piTQS0jDsqRQN4bNQpwpct6Car3Zs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eYp2dmyz1bxGsnYcLrHMMCw5W+kECwhPjriL2k4vaPIn5MqVmfVw4ok/GtHlW2ALx
	 LlJJwGhjjWrDkgaIN8fohF7qJ/YBi3GPMWoz8LGGI7FESUWNeSExwIR1KdB+rx0kCw
	 K8+IoXnTXaMNpAdehyiNyL51CNwXf3tauVpjb1zw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D28D0F800E5;
	Tue, 15 Sep 2020 15:02:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD31CF80212; Tue, 15 Sep 2020 15:02:19 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A551F800E5
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 15:02:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A551F800E5
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr
 [90.65.88.165]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7B97324000D;
 Tue, 15 Sep 2020 13:02:07 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:02:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915130207.GA9675@piout.net>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915115034.GA5576@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

On 15/09/2020 12:50:34+0100, Mark Brown wrote:
> On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:
> > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:
> 
> > > +	/*
> > > +	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
> > > +	 * before using the analog circuits.
> > > +	 */
> > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > +				AIC32X4_REFPOWERUP_40MS);
> > > +	msleep(40);
> > > +
> 
> > Maybe the actual REFPOWERUP value could be exposed as a control so
> > userspace has a way to set the policy? 
> 
> We very rarely do this, there's not usially anything 
> 

Could you suggest something then? This mainly changes the power
codec power consumption. I guess people will want to trade latency
for less consumption.

> > I'm not sure it make sense to have the delay in probe because it is not
> > enable the analog part of the codec. The delay should probable be after
> > the clocks have been set up because the datasheet says that it is mdac
> > and madc that is starting the analog circuitry.
> 
> Deferring the delay to a workqueue is the usual thing where there's
> concerns about slowing down boot.

Well, that was not my concern. I didn't realize Miquel actually used the
Force power-up values and though the actual power up happened after
configuring the clocks (as is the case for the dafule values). In this
case, the delay is at the proper location.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
