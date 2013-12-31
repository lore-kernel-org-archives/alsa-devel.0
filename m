From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add snd_soc_of_parse_master_clkdir() for dt
Date: Tue, 31 Dec 2013 12:04:15 +0000
Message-ID: <20131231120415.GL31886@sirena.org.uk>
References: <1388477444-18745-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vYlOGI1a8wP+YbIl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388477444-18745-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vYlOGI1a8wP+YbIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 04:10:44PM +0800, Xiubo Li wrote:

> I'm not very sure whether this patch is need for dt.

It's not clear to me - it's not adding much on top of just passing the
full property string to _read_bool() directly really.

> For the CPU and CODEC devices' sysclk directions maybe different of
> the same DAI link.

Yes, this is common if one of them is generating the clock.

--vYlOGI1a8wP+YbIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrK8AAoJELSic+t+oim98E0P/iLyWtg5u72Fym5qBIhGAHeN
JmZvxO0lvd06Vv/l5Er/A/1Zgz1fRuj0Ytv/MYKFLYt8bODCa7ZKtniRCbwC6WvS
8KRYCnk5WeccpRMRm2T3egrff/1eKnG9xn65RySYBh/yXml7j7dSAXaCaIxweysq
b9ch7dVTRhlkQuuG8wdylgaZKCiu1qhXFL6LTLTMCaVl98xeDtUhG4OFfag7Hzhu
Pf5JqeHUf6G2a8UvZCziYAx7d4yArVYQUUUp7ihiQiRwO9f4rab4aYLzKv2tHxMQ
O/i3XS2EV9Qx2EXI+4mSucwv9bYbZypQpPsOG3OITahi37J4rkobHnm2pR65saMx
gmBMhLJG6qJqpu8arm12HzUMFFYMi7NAmfbHQK5wqIh9wD1neE7S43Y54zXLFmME
8CUHd1rcP3J6NJ19sxESdFPGr5bUiGw1Et2imDYQfFfWn3Ui25H25w7eMBH+4GL2
SWRo7ce2ybRt8RapC3NkualLdvtubepYrc3zhZcrYKrUL47FfgRvHBFNC7P9b7Eq
xc4XPi34brOHDyvuK7pcJ18eS/nIzc4DvvdpCY7QWZl2RhZ8iySIyUu3kKit3N7f
Bk0mw0+O5uynuURglwcq8Wa7RATs+A3+iM+8V2ZEYMMNTm4SSv8SaPE2T5K5bDKW
X1/hdnyWSJME/0wErVDw
=N/hP
-----END PGP SIGNATURE-----

--vYlOGI1a8wP+YbIl--
