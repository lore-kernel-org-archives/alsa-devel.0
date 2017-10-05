From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: img-i2s-in: Add suspend / resume
	handling
Date: Thu, 5 Oct 2017 17:19:39 +0100
Message-ID: <20171005161939.gy5fn7elivpr4ypj@sirena.co.uk>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
 <1506938333-550-2-git-send-email-ed.blake@sondrel.com>
 <20171004103722.4bzjimc74cupnuto@sirena.co.uk>
 <aadc088c-c3df-6b97-de62-69cba0bc9de8@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3063463905072048734=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA282266A73
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 18:19:40 +0200 (CEST)
In-Reply-To: <aadc088c-c3df-6b97-de62-69cba0bc9de8@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3063463905072048734==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="san5dmuzqxj3q3au"
Content-Disposition: inline


--san5dmuzqxj3q3au
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 02:27:49PM +0100, Ed Blake wrote:
> On 04/10/17 11:37, Mark Brown wrote:

> > Why use the ASoC specific power management callbacks and not the system
> > ones?  It does also look a bit like there's a case for converting the
> > driver to regmap and using the regmap cache code.

> Looking at other drivers, most seemed to use the ASoC specific
> callbacks.=A0 Are the system ones preferred?=A0 If so I'll change it for =
v2.

Yes, look at newer drivers more here.  Unless you've a need to do some
ASoC specific stuff but that's not the case for this.

> > It does also look a bit like there's a case for converting the
> > driver to regmap and using the regmap cache code.

> Is it ok to do this in a future patch?

Well, the comment was there because you were open coding the regmap
cache sync code but it's not the end of the world to do it later.

--san5dmuzqxj3q3au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnWW5oACgkQJNaLcl1U
h9DSpgf/bdnpeTPBH3Zr7heVemub6XB74K+cnqkdki7o+10TcWPwbN7YAJP9cIrL
Wtsb1GzPUy7peL+SHcSzi/Kan9IJrsiMg0TBSDFl1Zjv453fWiO9SEZdJh3JiqnG
OGDYm+ipStLq1ZQIhNvfm6grA6dCsAwRO61vmOV2WeB8v7FPlq34roaW0kfwMymj
3r1A0Vdq6Oxe+fgTkFEbHtyvuO20S4SH7nymPX22pN1R1dSOEgeGaauESDtHtUgU
8pdJUF4DZBseODJLQK0cSa8PAApvKqGp/RNTa0bye0l4pbM/9rSurPXGF3ONiptQ
EJpSR4HQyPoQpJKjDfY4csoZfi2Ijg==
=mOEv
-----END PGP SIGNATURE-----

--san5dmuzqxj3q3au--

--===============3063463905072048734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3063463905072048734==--
