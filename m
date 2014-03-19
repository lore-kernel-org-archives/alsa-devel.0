From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ASoC: simple-card: Add DT documentation for
 multi-DAI links
Date: Wed, 19 Mar 2014 13:46:25 +0000
Message-ID: <20140319134625.GN11706@sirena.org.uk>
References: <cover.1394883134.git.moinejf@free.fr>
 <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
 <20140317164339.GR11706@sirena.org.uk>
 <20140318091728.1d2240ca@armhf>
 <53296CB7.1000909@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YAMuP2N37TMqsqKK"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53296CB7.1000909-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--YAMuP2N37TMqsqKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 12:08:55PM +0200, Jyri Sarha wrote:

> While we are at it we could update the bitclock-master and frame-master
> syntax to be like this:

> bitclock-master = "cpu"
> frame-master = "codec"

> With the above explicit definition all the daifmt settings could be defined
> in link level. For backwards compatibility we could still define that
> omitting the value equals "codec" and omitting the property equals "cpu".

It seems it'd be a bit more idiomatic to do that with a phandle rather
than with a string in order to allow extensions for things like TDM (the
I2S to mono speaker driver use case for example).

--YAMuP2N37TMqsqKK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZ+uAAoJELSic+t+oim9CuwP/1KTlhb26QwK5jKyfD9gviXE
pVQRXQQ0lY8D4bpW5SQFJvBq02Zcut+dZu/SMwCmKgEv55pFU9NY694pdNBKfmR0
oFB+BMIh/lFBO8+ob18x3nUff0zZx2oLazAt2iD8Lf0aQJNuwjd4WYJTyvlHZ6pd
Af9XXsmHmOn4K6nzZLyt8LZB13Qrapexol9YzPJ/E4kittDU6ntc6p4PlVeD0kW5
s7cL7+AHY0yZ1MmJESNhx87PFjxf5iGrUsC4pgJASvvNMqBecD2nBYHsfsuD0nZj
5tJvmRk88vPxxpMxiupoOomotQUBCbsbffmgDldQETR+OEv+UHXZmBvhJUY1YCFj
RiG/3NsWNsbY5Fcm7dkMtSDFrz6PmvoWEFEpLbbCe5TauUyNty4N49LvuL5Fx8BB
RdQ+5quc4Cw602NB/26E/vbplFEBWuFHr5kwAlMT+2kAhyVIqD28PtfpfvXvtcrv
6CQRSCqcYSviSiZYyXeX19jF9OuJ0zPTx2moz2p2Z/TFmcxpEAqnIO6CGavxz6Z2
fdOqKuCgAcwSEr8H+0uDrPaYwP2Q8KrOdGMoF0qFl88wr4el5pMAflvbxwMSepvU
60lgwna9IlhY4gU5cKKlWjH0Bh4ikSI6u+usAhLwG9fKYhG6iZsNgrv2zWfkKLNC
sYjB9lC6xAlh9Idp1drR
=90SH
-----END PGP SIGNATURE-----

--YAMuP2N37TMqsqKK--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
