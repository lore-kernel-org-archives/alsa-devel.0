From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] question regarding codec DAI ops
Date: Sat, 21 Jun 2014 11:26:44 +0100
Message-ID: <20140621102644.GQ5099@sirena.org.uk>
References: <53A44007.1000008@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7777608127282906105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C033265141
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:27:00 +0200 (CEST)
In-Reply-To: <53A44007.1000008@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7777608127282906105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPbGsu/ObDp3DThy"
Content-Disposition: inline


--MPbGsu/ObDp3DThy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 04:07:03PM +0200, Arnaud Pouliquen wrote:

> I have a platform with several audio IOs (DAC , HDMI...) and I2S In/out
> connectors.
> I'm using my codec driver but for this I2S output i used dummy codec driver
> with the snd-soc-dummy-dai dai.

Why are you using the dummy driver?  This is intended to stub things out
in some DPCM situations rather than as something that should be used in
normal code.

> From your point of view, what should be best solution?

I think we need to take a step back and work out what the goal is here.

--MPbGsu/ObDp3DThy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpV3hAAoJELSic+t+oim9EtoP/2pOJ/t+hGSL1ZTNzzwhaBpf
k+BEKBlVh8Qn7WxRFw1OKznDprvmcmgjCvxfvPir7740P3kOWUYSB8jw+dZPXvtR
oCDWNEPN4U7J+vqT0AIUkXO6rzkC+hF53xkZx7R6PRmBoYIiIimLXPomMDoyvhNc
/3lnwIvIMP2QacBiim+ErANELNP9shJpfbiwQhIZButVd7cIK/3H0/nyqcP3qFSC
n4ICECgXJQ34UX47z3ChcTZgvoulAVVdB/70uhd3RLOB/YQDqbrip7ChDwUedb2p
KJ8V9tMxmLdeAUjsXFMczOxqlmb05+5ehz69ERWHn0JH8rJfYxa7OM1GcP/gX71w
FmB3dHOVoo2zglY+2jYiJOFlZR8VIA+8Xo+lgYUiEDr4qigt7zEnh0Pn1aK2EbXk
tE/r8EhbXFQ5yzBlR4mlverLmxQc8y1Qc9WKEoKqWUsjRPOKFaA8sa6MCrggFoZU
u4ukJIjivJY0SrLY/SDLUBFf04n1FIAh2jw2MXqMWPPRvKYmBPoK4tSsSeW6UC+M
pNDBxnZYqGp/FR0N90URucbaKAzwdu8zZeImk3gR7VWWYjVx8k/mnnLVjj7BRAEX
ALAgeR0n6IA9KPlQNDuVTNe28C2BSR7Sl0o87B3Tq+WXCAFILQU8nD4XKO3C1+rp
GodxaASDFYu/1IiRlJsK
=q6Ux
-----END PGP SIGNATURE-----

--MPbGsu/ObDp3DThy--

--===============7777608127282906105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7777608127282906105==--
