Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D5C3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:10:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85E3246A8
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="COmBgI7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85E3246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD94216D9;
	Fri, 28 Feb 2020 19:09:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD94216D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582913405;
	bh=wCa8azcOfDNdaDTYsfIsB+qVDPrwwVOJa/n3E0kxIjE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=COmBgI7/ZHp4jk6zjAmAj4FZWebY086HxtzmcEacfkzjLMUc1XMt3Hvo3thBbYt6N
	 0ktROSxUP2Ku1QQ+qBZ/ds4o6H5ZbbQwNkhvYGiSlheDDjw2PX08/5yoaakFyKLhwh
	 asyd7+burecnEqwCarcprb93NfC38ROrRNme4pt8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C4DBF8014E;
	Fri, 28 Feb 2020 19:09:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C08EF8016F; Fri, 28 Feb 2020 19:09:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 46C80F8014D
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 19:09:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46C80F8014D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E21831B;
 Fri, 28 Feb 2020 10:09:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B933F7B4;
 Fri, 28 Feb 2020 10:09:05 -0800 (PST)
Date: Fri, 28 Feb 2020 18:09:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ASoC: samsung: Silence warnings during deferred probe
Message-ID: <20200228180904.GD4956@sirena.org.uk>
References: <CGME20200228101124eucas1p1f6ab761a38f4a953a4eeed89859fcf4a@eucas1p1.samsung.com>
 <20200228101120.28819-1-m.szyprowski@samsung.com>
 <20200228161220.GB4956@sirena.org.uk>
 <CAJKOXPdVRCtJcUS-jkAGoeOB5C8mBWPoZxmFNmg2On0STd6mkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <CAJKOXPdVRCtJcUS-jkAGoeOB5C8mBWPoZxmFNmg2On0STd6mkg@mail.gmail.com>
X-Cookie: There Is No Cabal.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2020 at 06:45:33PM +0100, Krzysztof Kozlowski wrote:
> On Fri, 28 Feb 2020 at 17:12, Mark Brown <broonie@kernel.org> wrote:

> > This is completely removing the diagnostics so if things do get stuck
> > the user will generally not have any hint as to what's going wrong -
> > it's better with this sort of change to lower to dev_dbg() for deferral
> > rather than completely removing the error message so the user has some
> > ability to figure out what was missing.  However in this case it's also
> > the case that snd_soc_register_card() is fairly noisy.

> This dev_dbg could be achieved with ftrace for probe() as well. I
> think it is quite common to skip all messages for deferred probes.

Yes...  and having had the pleasure of debugging problems with things
not instantiating I'm not a fan of this trend.

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ZVz8ACgkQJNaLcl1U
h9C6Nwf+KLjN/KSJFzMCTGSDZ5SJw9Fpqa/Ntspc24Sh8wDwW3HJuAbJRVrTxhmv
OKUJrpYv9DXLhuavDyMVqT4t5aGFI0DegRLDEgJgMnsrRYfQ6L0Qh0RlVc4QxoaK
9k0PAZIQVoDS/JMICY6EV2O2teqj89gRUgvrUCpBFVvvnymAbOLsXn35CT37ccnS
JeeTiKEZJWbV+ypFY4hiAlamYcfyTpwznXd3qBW33mCP4sQ9OHBDfBe7jI1j78R6
Hyui5A8nJGYiNnHMgy3ZjMrF/NolpvdlvJ4laYvT9pY8wBHC0HqyoI6ez1TZBMHO
yoAcXxrmlD2Pu6rtxWzrdeLbI5lGsA==
=mAzg
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
