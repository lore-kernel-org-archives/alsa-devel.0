From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Mon, 17 Jul 2017 15:51:09 +0100
Message-ID: <20170717145109.bwujyk66he2ehijc@sirena.org.uk>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
 <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
 <CAMJBoFNxPsg8pjbWSc-vQQGKMPQOUQZ93=6NxY1YtzY1q16DfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5583565698891767113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7178D2669F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 16:51:18 +0200 (CEST)
In-Reply-To: <CAMJBoFNxPsg8pjbWSc-vQQGKMPQOUQZ93=6NxY1YtzY1q16DfA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, trini@konsulko.com, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Jyri Sarah <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5583565698891767113==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wsrzc6t5gpjy2t2w"
Content-Disposition: inline


--wsrzc6t5gpjy2t2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2017 at 07:26:43PM +0200, Vitaly Wool wrote:
> 2017-07-13 10:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:

> > While there are some users of davinci-evm.c, I think a majority are
> > using simple-audio-card instead. Curious on why you chose not to use
> > that. It sounds like codec is not the bitclock and frame-sync master in
> > your case. Did that end up creating issues ?

> Well, one of the problems with simple-audio-card is that you can't
> snd_soc_dai_set_clkdiv() from it, neither you can set SND_SOC_CLK_OUT
> for a codec, so for some codecs this just doesn't fit.

That's no excuse, the CODEC drivers *really* shouldn't use _set_clkdiv()
- fix the drivers to work normally.

--wsrzc6t5gpjy2t2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllsztwACgkQJNaLcl1U
h9CRtQf/WWF7rUfy95OIDBxmuqEDB+iCS0thucr+x3KDFbwQuv8H3CSfOxcIZoRl
UX2J7mHSELFYs+nqaPlp0VGJS+8yakrLlR+DdK7C+ENeglSY5Dp1sK3Tkq5zdgCT
nIJR34NGwwulF7AvXYd7G4j+3Bg2y4CgnKb+iEiOdZos2ATL84kXCrSWox7wCSgM
Q3bj8tujd6z12eks0iIDe+0v/5fZJj3ffeTX0KE+9qgABO2h6eZl+58tmSTuiFjo
FwZGirjbGk2f9ITmgB1ij1a91iU9naBpU0GEeuMq1OAQ+OaStnusHThTN3h/QOTq
6i0kpRAQ8EFwOpd8efv6C7RBGhQ7ow==
=XLjF
-----END PGP SIGNATURE-----

--wsrzc6t5gpjy2t2w--

--===============5583565698891767113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5583565698891767113==--
