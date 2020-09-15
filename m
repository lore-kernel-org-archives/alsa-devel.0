Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5867DC43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:52:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB658208E4
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t6zkI7p0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Oi9kNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB658208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5116E1612;
	Tue, 15 Sep 2020 13:51:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5116E1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600170744;
	bh=4AdVvb9OpJlCLAFzmltxBUT5yXR5yQZ90HPJkguTE/g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t6zkI7p0HMiF5eTZk8/jqNA4yrdtmkdR2nxGWCnlgPETqPi+RwOlvupIbCVmlbczm
	 w9u6wcd3p4wSCvH+ZxSoX6urtq3zDEQo92mE+XK4hcAn0fu2Lu0/m/WgjUlQxlwWxo
	 gt7M5N7u6Xz5j5USCE8oJLYcKxeM0QvJs1Vsp3LY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9B74F80159;
	Tue, 15 Sep 2020 13:51:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69046F80212; Tue, 15 Sep 2020 13:51:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED91EF800F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 13:51:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED91EF800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S6Oi9kNO"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F9A620732;
 Tue, 15 Sep 2020 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600170682;
 bh=4AdVvb9OpJlCLAFzmltxBUT5yXR5yQZ90HPJkguTE/g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S6Oi9kNO6jEJRVa0oQ7wJE9zm2k9LSZ8fHzXrkc2iG9HPQCC/RL9evS85vQ0UuNqa
 j0mC1xGz7Qh2AnPRsfQMYXHpoEL0Ai0tYEKoFtleucmMt7+LFODhK4cqpKchawBdTE
 EkHzNEW5D1KsyGkYeHyF3nW60lzX0wZVECcvkhSw=
Date: Tue, 15 Sep 2020 12:50:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915115034.GA5576@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20200915082602.GH4230@piout.net>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:
> On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:

> > +	/*
> > +	 * Enable the fast charging feature and ensure the needed 40ms ellaps=
ed
> > +	 * before using the analog circuits.
> > +	 */
> > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > +				AIC32X4_REFPOWERUP_40MS);
> > +	msleep(40);
> > +

> Maybe the actual REFPOWERUP value could be exposed as a control so
> userspace has a way to set the policy?=20

We very rarely do this, there's not usially anything=20

> I'm not sure it make sense to have the delay in probe because it is not
> enable the analog part of the codec. The delay should probable be after
> the clocks have been set up because the datasheet says that it is mdac
> and madc that is starting the analog circuitry.

Deferring the delay to a workqueue is the usual thing where there's
concerns about slowing down boot.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9gqokACgkQJNaLcl1U
h9BxmAf/UcMuAW76u6rLlk8ONETf/rGaWtTY69AB4XXcR3C5KFDbnlRR+se+WUaZ
jaaNRa0HzZQIRqTCHz6SaGc2hXvR1Ua6uFT6KEroJkRtfyxVdNS70PEyykyNPe09
u12QaUYrzpQ3PVGZ3ngEXk3jFnb+8NziK5riqM8S8GqD8bwl9H47rDBReMNDY2Lq
UKP52Nv0qFYzK0cj7dBtPLYozZSXDNi+Vyve6jxnmE1iRHIc+VZvGZFBNBMb+vfY
RS9ojAe/BNibV+4sT/2SBQAyIc/AKjYn8crR9m43onChyuuryn0sS9Dn2Qkh1/25
+RYK+VVmlF/4DjcJSUjfcS9l/H4Q9g==
=5ecU
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
