Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CBC34022
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34A02070B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vM1zOlCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34A02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 295303E;
	Mon, 17 Feb 2020 16:30:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 295303E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581953483;
	bh=BAJtar/5sRR5rj/UpDdz+BoQbze/LWEs2wS7Ij55BUs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM1zOlCOg8yRm8KQ15NtiGh1jlOK71LRkjFB9gVMC12jQvJkPSML35hS4gPpaIv00
	 FfOqpiL6KXhRSAnyrsiYuuOTGD93aOD8lHtB1/ObNCxSK2Wsp49b+UG7mht4uXMAU9
	 wqUGggbbsaN3xD+AzJz12wTFEU5x4JAeL8t9svYQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9A06F8015E;
	Mon, 17 Feb 2020 16:30:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9968CF80172; Mon, 17 Feb 2020 16:30:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 94B73F80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 16:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94B73F80096
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCDE30E;
 Mon, 17 Feb 2020 07:30:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E50E3F703;
 Mon, 17 Feb 2020 07:30:25 -0800 (PST)
Date: Mon, 17 Feb 2020 15:30:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Message-ID: <20200217153023.GL9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-11-samuel@sholland.org>
MIME-Version: 1.0
In-Reply-To: <20200217064250.15516-11-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>,
 stable@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [RFC PATCH 10/34] ASoC: sun8i-codec: Advertise
 only hardware-supported rates
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
Content-Type: multipart/mixed; boundary="===============6067526400003327137=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6067526400003327137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 12:42:26AM -0600, Samuel Holland wrote:
> The hardware does not support 64kHz, 88.2kHz, or 176.4kHz sample rates,
> so the driver should not advertise them. The hardware can handle two
> additional non-standard sample rates: 12kHz and 24kHz, so declare
> support for them via SNDRV_PCM_RATE_KNOT.
>=20
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

The new sample rates are new functionality, they are definitely not
stable material.   For the sample rates you are removing do we
understand why they were added - do they work for people, are they
perhaps supported for some users and not others for example?

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KsY8ACgkQJNaLcl1U
h9DgKwf/RkeIHeM2sJ2RgbLTXWX8YZmWkvlMjMbuWBeFxHTz/Hdo+gM34z7glK5D
vTsYnMg6wYSVtkRJzw6JOjJE/YqT+KFTmpqMHlhJkHhh+0Ce33hnN5vhPWAOyDLX
ajN4NNYMR/RvlHVhAD8YVCjWKy65hpslCTajh+74Pn5GNtXao1z2mH6vDaVOntZj
KsuP3g6wxqKicdi4lrAYDS80cpUVlOD4OkMk49MT5h1U78w3hblZkKULqFjOt3BL
jgdv2os2/zg+/7OxQCcAlJfrfd4m4kBHbI9HF+0IMV9CIt+pR7Kmy7H+zcliwi9L
1zUYINK1EWJvcb+4lIeZcMRp0sH7aQ==
=ZBtq
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--

--===============6067526400003327137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6067526400003327137==--
