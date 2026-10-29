Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50989606F3FD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DJlVp2Me;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ7bnElp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 130A360205;
	Mon,  2 Nov 2026 15:41:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 130A360205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793630521;
	bh=b/8PUtS+Kp4ROI869eUE9VnUh8GeLydBctR0kQiPelA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DJlVp2MeXuh80itHJHkbCzBhg3LYetE+3LX/Gdf9jMgNLdbnVgoMaqc8y1U1JOVlQ
	 jvfjEO87z+AOTRArTzOsonqWET883U+Y6X41MgAXYmMYzp8tUJqJpM0ZvwFiJhiuJ3
	 wvBlw9/kTxB4oNTHTitGxcPmhLdBNmYzNwCcnro8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D4E4F80603; Mon,  2 Nov 2026 15:41:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C7156F805F9;
	Mon,  2 Nov 2026 15:41:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 794B0F8016E; Mon,  2 Nov 2026 15:41:22 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793630481;
	b=DrSRD7XXYqfeFlVsyurLXKLOHRBoPy/gbFrzW1EhgGhTkYtcvdlutOiedAhn8cqiLFL0
	 EHRreLrVPMk6YgNs3xSI6p3A4duV8eb9a0u/SMuLCGyOcLa550orwM8mQLnBnSYenBfhi
	 uEZpAS3EvN3MHsEWdPnlWX4JzHGADKiwDti+Fz9yOlXYxDzROVnq8ei1Hcn62/gVr/wZ/
	 eHUkP9qMcpfRzXv4333WKcXGMOKd1/YxGRloiOjBbp9vnhmmbj80tFfRK4aINOJjZfPUp
	 exkPRlw2ODnAFepd1tVo9vcHeJ2Le/8wd8DahCug8UcSVnJgQQiRJ5BmQ3i3JGetMDw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793630481;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=b/8PUtS+Kp4ROI869eUE9VnUh8GeLydBctR0kQiPelA=;
	b=A1GzEQqrNrzhzpFAkg/LySauSlfpxB/3GUmlgiXkoRRJ0tc6DP6bek0VGwa/y9Zkv9fX
	 Z4jqNc9iBIkZzLHPfzPCskSVJTUV/biWpdhcHOi5lE88hcRWJVhymXzTPoxWfx81PV8H2
	 mgbbPNLycqfOPoNBoFp7g6Te8Jn/CA9g27Rgxkop3NeK0JeO5rIUcM8WWzmIoTbBEh09H
	 BZXexa/ILk0uJYunO/b17AEcl00qN6VaZTwTkr7MTh+RS69jZrp4/sahdO7XkL1AYwjf1
	 axmBoI8Ej/UBRq1HOaJChfD8cpzIjl6SOsbmpxZUbe9wHc72ldNkuABKkHj8Ob6/zbA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TQ7bnElp;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C56B5F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 15:41:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C56B5F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TQ7bnElp
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82F68601E4;
	Thu, 29 Oct 2026 12:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A3E1F01825;
	Thu, 29 Oct 2026 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793277115;
	bh=xa5URGaN5W0pQyv70BuKHVgE4RyRaU8Hn6PDhKD2das=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TQ7bnElpShtQwBInMgoKdKuztfq3+C21P/n0KrnYxhA/r+UomozUVJxXysXXfV4LA
	 Up13LWwcQB9l3OINiwALxZ8/hIUXZPlOpUmvz9Ss7apvIdYxTNlHYHrDEgdqrNGHCI
	 MmMmzLRfII3O9+Mh+VdxdBeck9msLcrT/aofUt6rPBU4mar3vJhEYAocj4wo9BIFDK
	 9X8Kgwr7GPmA2U6tXsU9Y63FlUi69z+7FIPTpUZCLKMox+6WvS9NvuKst64G+ZBE0K
	 ii1gscobkrOumTFgq715EPUqdBkuTONlvHZCI+K/+WuNSe1kN6phUt5jbSxzTzD5jm
	 wYYnI3ieAmxpw==
Date: Thu, 29 Oct 2026 12:31:50 +0000
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v1 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
Message-ID: <e9e87eba-d3cc-494c-bd63-9efc7aa5e059@sirena.org.uk>
References: <20261022084037.259983-1-YLCHANG2@nuvoton.com>
 <20261022084037.259983-3-YLCHANG2@nuvoton.com>
 <179304693306.199157.5210648249546181520.b4-review@b4>
 <0752dec9-2de8-43fa-931b-27e1cae6e1df@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33E0WjiqKniC6qf5"
Content-Disposition: inline
In-Reply-To: <0752dec9-2de8-43fa-931b-27e1cae6e1df@gmail.com>
X-Cookie: I have a TINY BOWL in my HEAD
Message-ID-Hash: EBW5KDGB5Z4Y5B2LCJNNIT4FMEJVXB6L
X-Message-ID-Hash: EBW5KDGB5Z4Y5B2LCJNNIT4FMEJVXB6L
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EBW5KDGB5Z4Y5B2LCJNNIT4FMEJVXB6L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


--33E0WjiqKniC6qf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:24:39AM +0800, YLCHANG2 wrote:
> On 10/27/26 04:35, Mark Brown wrote:

> > > +static int nau8310_switch_internal_osc(struct snd_soc_component *cp)
> > > +{
> > > +	struct nau8310 *nau8310 =3D snd_soc_component_get_drvdata(cp);
> > > +	int ret;
> > > +
> > > +	/* For internal Ring OSC, the default fs apply to 48kHz */
> > > +	nau8310->fs =3D NAU8310_DEFAULT_SAMPLE_RATE;

> > This will overwrite anything set_sysclk() set, since we call this from
> > _shutdown() and _resume() we're relying on the machine driver
> > reconfiguring the clocks when starting streams.

> Regarding `switch_internal_osc()` overwriting `set_sysclk()` states during
> suspend/resume, I'm considering two fixes:
>=20
> 1. Add NAU8310_CLK_INTERNAL to set_sysclk(): Standardizes and unifies clo=
ck
> setting through set_sysclk().
> It sets the 48kHz internal clock here, but would still temporarily overwr=
ite
> the nau8310->fs and mclk states during _shutdown() and _resume().
> 2. Pass arguments to clock_config(..., mclk, fs): Configures the 48kHz
> hardware directly via arguments, leaving the nau8310->fs and mclk states
> completely untouched.
> Which approach would be preferred for upstream?

The second option sounds like it might be a bit safer since it won't
disrupt other users, though it may also be useful to expose the internal
clock via set_sysclk() if it's useful for running audio.

--33E0WjiqKniC6qf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjPLUACgkQJNaLcl1U
h9AvHAf+KXI5E3bvHag9+mXdWiYHYhPnOjtylEUTawoCYOxJLYL7jEV1aBmcZxkR
IFBuP95gLG5TtwHmzdWc5LBNS66yLNbdGT795Z8i139PV4K6m3ssKg/daAKAGul2
atZvnGvz+AUFGF2Z2XWHhRSIIwWW6RyPPcpvA/h70KTJlGY0EOcII5l2j4jm0J1Q
rz2sHXl+7ePkReDF1rMUkAQPhdiNFSv1a6/lJe/HVoMhiiPSrA9r1jYVuBGJd5vW
W2eLQK+YXEBk/1vNRk253tbQyBPe6gXF0sODqi+FULjWsU2tFBaa7ECckvZ19FTZ
lknCgspqG6ZMxK8ZUCr7ekRxvYfy8g==
=h8z+
-----END PGP SIGNATURE-----

--33E0WjiqKniC6qf5--
