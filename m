Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA2C43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:15:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AF021D41
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ttMAkK8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AF021D41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10346844;
	Tue, 15 Sep 2020 16:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10346844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600179305;
	bh=588DyAHu+BeIvXXJptdqIgps6j1B3WwT7jZj3kto3hk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttMAkK8gzPLTzXTnfuBNbGRGn65z3eJv2uZrAmzni27ctt1LEvOS/Lu0PHAFoRUHV
	 C+l8/L1evQa/z7M0mxi5vldh0NpmqO2BFux0ViYPC1YTL3fqwqdkVhs/wGUWzhlfhd
	 AYtCZqUNSbE4NL4kfqI4Ow5PjcpDIVc2GAfb7Vmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B6B8F80159;
	Tue, 15 Sep 2020 16:14:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD32BF80212; Tue, 15 Sep 2020 16:14:12 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87F2BF80159
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 16:14:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87F2BF80159
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B302D20008;
 Tue, 15 Sep 2020 14:14:02 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:14:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915161401.54f6d4f3@xps13>
In-Reply-To: <20200915141025.GB4913@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
 <20200915130207.GA9675@piout.net>
 <20200915141025.GB4913@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

Hi Mark,

Mark Brown <broonie@kernel.org> wrote on Tue, 15 Sep 2020 15:10:25
+0100:

> On Tue, Sep 15, 2020 at 03:02:07PM +0200, Alexandre Belloni wrote:
> > On 15/09/2020 12:50:34+0100, Mark Brown wrote: =20
> > > On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote: =20
> > > > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote: =20
>=20
> > > > > +	/*
> > > > > +	 * Enable the fast charging feature and ensure the needed 40ms =
ellapsed
> > > > > +	 * before using the analog circuits.
> > > > > +	 */
> > > > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > > > +				AIC32X4_REFPOWERUP_40MS);
> > > > > +	msleep(40);
> > > > > + =20
>=20
> > > > Maybe the actual REFPOWERUP value could be exposed as a control so
> > > > userspace has a way to set the policy?  =20
>=20
> > > We very rarely do this, there's not usially anything  =20
>=20
> > Could you suggest something then? This mainly changes the power
> > codec power consumption. I guess people will want to trade latency
> > for less consumption. =20
>=20
> Is it increasing steady state power consumption or is it just drawing
> more power during the ramp (ie, peak current consumption is bigger)?
> Usually this is trading off clean ramps for fast ramps rather than
> affecting steady state.  If it's affecting steady state a control seems
> sensible.

Indeed, it is just affecting the ramp (peak current is bigger).

Thanks,
Miqu=C3=A8l
