From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: simple-card: add Device Tree
 support
Date: Mon, 18 Nov 2013 12:41:52 +0000
Message-ID: <20131118124152.GB14306@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <87li0m7d7c.wl%kuninori.morimoto.gx@renesas.com>
 <20131118113617.GC30853@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131118113617.GC30853-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2013 at 11:36:18AM +0000, Mark Rutland wrote:

> What I meant was that I am surprised there isn't a helper doing all of:
> * of_parse_phandle
> * snd_soc_of_get_dai_name
> * snd_soc_of_parse_daifmt

> It looks like a common pattern that could be factored out.

This is the factoring out of the common pattern, other drivers will only
need the compatible string to work out the format.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSigsMAAoJELSic+t+oim996MP/1WR3iqkzlnN5Tor+vfeYeHi
Fc4/M3xLQK9MyCxuloZRCupcdkcOppcCtyLY3Bn0/nda3+sfuBPrGhWBQx/3xQ9C
J0uYZ1BFZfBqAVgPscekeeghWdDe56jf0FrHVl5p1dYa0aytdD7op5tr3jQYfprV
LU2D3y8uwm08KGr54UTguAPvUUvsp2g+8Y/qt194SGYrc3Gy5O8K6efSKIAx4zw4
uJZ9952ZI5do8RySNZhNY5r1hcUOxkCvhH1r+l69LAjpNSDtuIFPzgg1mvKZUNp9
mqowovSXr3UoOn3wn6EjDMlKBphvFsFstDZ7GbGYfAnOyWjPu8EArCsZMHj3rlPI
tWptw3ESuF+41PmM5sv/TNB8/Wzt3uPxEh9Y3bl9/lVjdRSN93N+6hJWasixG/IR
EVPPudxZYScVc4M65Y8WkWNIMgruo42rfE/gIxADYnQ8swATUBpa24QSnGHq02TB
ch6JnEyKx9ym/RWU18uY8/QaioFgPGF8TxfC1qVMFyjK8hl9Y9DRvZIf+myKpya+
+L7p+lZOXVjshB6CEvtvFMz3UQglVu/JLQ3ncsTVNip/CXS0RcVYsBnFnJJIdmQY
nW4QrrYC0uMXtQ7QcVGj5MJHpOR9Iut8O/xtudABiJG63iNZ1rc6ljeTetmvS7zb
ITtIp0VBLwRdHTtHlMPq
=VqQZ
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
