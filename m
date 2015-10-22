From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add the HWEQ for the
 customized speaker output
Date: Thu, 22 Oct 2015 14:08:41 +0100
Message-ID: <20151022130841.GN8232@sirena.org.uk>
References: <1445410711-28828-1-git-send-email-oder_chiou@realtek.com>
 <20151021103519.GL32054@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F9ED0C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7413494153311398439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CFAB266AEC
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:36:57 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F9ED0C@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7413494153311398439==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2015 at 12:47:34PM +0000, Oder Chiou wrote:
> > > +struct rt5645_eq_param_s {
> > > +	unsigned short reg;
> > > +	unsigned short val;
> > > +};

> > As I said in reply to your earlier version just now this seems like a
> > really strange way of configuring things - we'd need to understand why
> > this is a good format for doing the configuration.

> There are 56 registers(0x1a4 to 0x1cd and 0x1e5 to 0x1f8) for setting the
> EQ parameters, and there is a register(0xb1) to control how many bands are
> enabled. The EQ parameters are affected by which bands are enabled, and we
> can set the EQ parameters which are required. The goal is to implement the

56 registers isn't so many in total but...

> function as simple as possible. In case of the Google Celes, we can only set
> 5 registers. We have added the check function in the "rt5645_hweq_put", if
> the settings are invalid, they are not copied to private data. In the enable
> function, we also validate the registers, and only the 57 registers can be
> set. Could you give us some hint?

It's a lot simpler from a kernel code point of view to just export the
full register coefficient block - but it's nice to see your tuning
software is smart enough to be able to output the smaller set of
register writes!  I think this is fine if you can put the above
explanation into the changelog and also change things to remove the need
to specify platform data and just always provide these controls, with
validation of the registers being written I think that is a good idea,
especially given the separate register for specifying how many bands are
enabled.

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKN/ZAAoJECTWi3JdVIfQAYgH/1tyyZe75E7WyIVOPRXe6mki
7v21xCdoMmXhQwQS7wnzABS+0UhyFtDNcqR4RRz1Ua+AYMTlvFKD/wOF3tglbj6J
OXSgAN51ofjvuGJ3jL3px4JY7yQ1Bvx0y9o8wmhMgJn8Z07tMvWFiWb3dPbYd4MU
l5qHhLP4Pu2mB6uq3BCzmExYSXVYSg+2WnAQAMyIAqrY1kaA3wGfZZN6FZH/ooJa
W5e0Isid06CZq6I8VBSwXjWueUxyH47tgEFfCdz2dFftLMOYVvwQgtD4H/FfOJnV
pPE6D+HT3t872+2tL96CBEZvHKg9QWZ4HCMRBegd5KWXz3C5DhQmCfJH2R2XU/4=
=HYlZ
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--

--===============7413494153311398439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7413494153311398439==--
