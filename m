From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: bt-sco: Add devicetree support for bt-sco codec
Date: Fri, 8 May 2015 19:06:44 +0100
Message-ID: <20150508180644.GI2761@sirena.org.uk>
References: <1430856941-3938-1-git-send-email-marek@goldelico.com>
 <20150506121311.GP22845@sirena.org.uk>
 <CAAfyv37jOJ=grVAM22-oLx2s6-8rXr2fVbgpNqkaJjwuEsHZ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qLni7iB6Dl8qUSwk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv37jOJ=grVAM22-oLx2s6-8rXr2fVbgpNqkaJjwuEsHZ9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--qLni7iB6Dl8qUSwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 09:38:55PM +0200, Belisko Marek wrote:

> > Is there any burning reason for adding the linux,bt-sco compatible?

> No no real reason just want to keep that if somebody would like use it from DT
> referenced by bt-sco entry (similar as platform data). I'm adding DT
> support for it because I want to use
> this for W2CBW003 chip and I can use simply "linux,bt-sco" property in
> DT or I instead of that add new vendor
> prefix + add new compatible entry which is IMO much harder that
> reference it by generic name.

OK, can you change the patch to just have the part specific name please?
If we were to have a generic binding it should really be richer than
this, for example I think I've seen BT devices that take in 16kHz
streams rather than 8kHz and there are often requirements for oversized
data frames as well.

--qLni7iB6Dl8qUSwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTPszAAoJECTWi3JdVIfQYCsH/10m/7wdBtY60QPlrD0RFlXZ
INGbmNuDmF0pW4Z0Ys7g3Zi4irpnMQn/kZOhaHocBK3d+nrT1DWEFez7g58etEiH
AT532QXLqKSPoOok7yhrZ/xLgVHasdkPlpLOQp7EQZ4+ASuIJTGeYSI1fUcgBeHq
gjDdKt3auj0C0vszlJYCd/+Jo3ehvEEhvKemQ4h/X9ADbS1FIplJRG4eJz6WhV94
NZikgN95PQ+/JW+EHAWr78CN6b+on1cYZ22ijqC6csjlQk2xy0t836jrvoU0Rj0M
dWvBKJ+AFvxYw70aY6GM3qVgzR4RrjuBgk70GwglgT8j47OUeu7DXKYisbPGmEo=
=JQb2
-----END PGP SIGNATURE-----

--qLni7iB6Dl8qUSwk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
