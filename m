From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Thu, 31 Jan 2019 12:26:24 +0000
Message-ID: <20190131122624.GA20797@sirena.org.uk>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1289178662270171438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A65D26687D
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 13:26:27 +0100 (CET)
In-Reply-To: <s5hsgx9ckrf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Leo Yan <leo.yan@linaro.org>, Phil Burk <philburk@google.com>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1289178662270171438==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2019 at 09:08:04AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > anything O_APPEND based.  My understanding is that this is fundamentally
> > a risk mitigation thing - by not having any of the sound kernel
> > interfaces available to the applications affected there's no possibility
> > that any problems in the sound code can cause security issues.

> The patch 2 implements exactly that kind of access restriction, so
> that the passed fd won't do anything else than wished.

Yeah.

> If we want to be super-conservative, the implementation could be even
> simpler -- instead of filtering, we may pass a minimum fd ops that
> contains only mmap and release for the anon-dup fd...

I think that'd definitely help address the concerns.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxS6W0ACgkQJNaLcl1U
h9ABXwgAhHKVPw0G16tbMolrztcXh86AqrlCtbfWfDLG3Jd3EzBMbBN+V5+hhF9+
tgHFzkKW/fu3ccSYPZhsvQYECfEd+hNriSMpe8JSEeKVIPcPtl7kRBpNni0Ehe5Y
AgN9y8xyW/yFgCSO8zCrBI136zqGtIkb3AAWP2wYeW+2nP0dp00HKbwu8AYkDAO1
keGJFaP8Ji2P7hfbRAPq6FjlJF4iQMnYyquZEWYS7ibi/LdyJ8mr4eYDaudgYwx2
vfQDM/B766MfA+HV6YMrvt3P+ZdjOYINQ0EJmx24oPpX70fNzPrPWBWQccvjfuik
JA8KJkz55xQ96d3IgQRY9GpNFwC+Yw==
=lOFg
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============1289178662270171438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1289178662270171438==--
