Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE993C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:53:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A89120809
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hytSpi+b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWJFJd+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A89120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C280D1669;
	Thu, 30 Jul 2020 20:53:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C280D1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596135230;
	bh=p9oPba0mvh+97oJckDtVD2Q3rUl/khvzbYhc/m/Wsrk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hytSpi+bZeb+Kok6567H6E1WWALTTFgnPL4PFKeUZoCeMDe3WOQrJYvtGEMjCQqZO
	 Ml2Db/bLF1bd7R4mbr/DiM07FupnkfHkfBYoXkAS4SS+wAk8SPo/SQ8PGTupXbsKzZ
	 lWu7eaIFs4EihSWPLLiZF0bParyVwsB+qduDo/5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F6B7F8021C;
	Thu, 30 Jul 2020 20:53:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9EECF8021E; Thu, 30 Jul 2020 20:52:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4FDEF8012F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 20:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4FDEF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iWJFJd+r"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0543B20809;
 Thu, 30 Jul 2020 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596135169;
 bh=p9oPba0mvh+97oJckDtVD2Q3rUl/khvzbYhc/m/Wsrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iWJFJd+rtMgYBOsBvF27NSJHWipQKLgElYBHEU6AO+7oj00vU85cw458+CwQ6nU2E
 7v8IfL/PsQpLmnkvm9Ke+QNRay67GMHHbxadMWcf2pLfAWcrWb3KP3vZUHRA0MDJpu
 fxKyeiy8R/Aj0WUCwc8NOfu9xVuAJ4BleP0rV7l8=
Date: Thu, 30 Jul 2020 19:52:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
Message-ID: <20200730185229.GH5055@sirena.org.uk>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
 <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
 <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
 <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, zhangn1985@outlook.com,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2020 at 11:06:23AM -0500, Pierre-Louis Bossart wrote:
> On 7/30/20 4:04 AM, Jerome Brunet wrote:
> > On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> > > On 7/29/20 10:46 AM, Jerome Brunet wrote:

> > > > The flag previously allowed card drivers to disable a stream direction on
> > > > a link (whether or not such feature is deemed useful).

Right, and I can see a use case for this if someone has a board that
for some reason didn't physically connect one of the directions for some
reason - perhaps they were running out of pins or something.  It's not
clear if anyone's actually doing that though.

> > > > Forcing the flags to be aligned with DAI caps just make the information
> > > > the flag carry redundant with DAI caps, breaking a few cards along the way.

> > > > This change drops the added error conditions and restore the initial flag
> > > > semantics.

I'm not 100% clear, have we actually found cases where the flags are
used or is this something found through inspection and review?

> >   * It worked for every user of DPCM so a far.

> Not completely true, when Morimoto-san added snd_soc_dai_stream_valid() it
> exposed tons of cases where the information on direction was not provided in
> a reliable at the DAI level. I will assert that we are still finding out
> cases with broken DAI configurations, and as a result we will also find
> broken dailink configurations. Your picture of DPCM as a perfectly
> functional system that I broke is a distortion of reality.

> The reality is that we have to work in steps, first make sure all DAIs are
> properly described, then work on the dailinks and optimize at a later point.
> we will need warnings to find out what the problem cases are, and move
> slowly.

This was all triggered by Morimoto-san's changes like you say.  DPCM has
quite a lot of problems in general, here IIRC the issues were that we
had multiple different ways of doing similar things which it wasn't
quite clear if people were even using.  The intention with the warnings
was to remove them one way or another, they're mainly intended to flush
out actual active usage of the flags as opposed to redundant usage of
them which could be confused/broken.

This could definitely have been clearer in the changelogs though.

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8jFuwACgkQJNaLcl1U
h9AhwQf/eNX0synxDEgjT7FmPWLDHvEYP9WwcQyfMCzHdEvV8d3Iiq/P+C6GW13d
ehcDWOK1wzrqJjMyjh8jp+04kuRwwsL+YHnRD2FqYm1ajOp3ADdT3+ekGQXG5rZ4
KG99yZALADgpmbl6VOluas2lkeiWIjO3nZEFJypz0VJKtEyxCiXzzPbA81wgsyr4
pu0Q1XmfbUpAsLCeGlrjdENOLdW0Kfb0fjXcEy8ks0NHUfbAOj2JEr5uYTjPLZTt
8OH9bbhLUIhwGirTdF5piPsHbYq8ybFWDvKQ37qjqK0L7Nec0UdaTIqlroiOs1Xo
fFI19TW9/zN4P9cxHXwEC07WllXelA==
=Icbr
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
