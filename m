From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: hdac_hdmi: remove always false condition
Date: Wed, 25 Nov 2015 12:36:36 +0000
Message-ID: <20151125123636.GR1929@sirena.org.uk>
References: <1448363546-31193-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448363546-31193-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 04:42:26PM +0530, Sudip Mukherjee wrote:
> hdac->num_nodes is unsigned int and can never be less than 0.

> Or, maybe, another way can be to declare num_nodes as int. Then this
> test makes sense and also snd_hdac_get_sub_nodes() is returning an int.

Yes, that's a better fix:

>  	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
> -	if (!nid || hdac->num_nodes < 0) {
> +	if (!nid) {

it's clear that we're looking for an error code on failure here.

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVatTAAoJECTWi3JdVIfQ1kAH/ietoyJ4K2TDlDJiJ96t89xl
ePabvOBQEi8v2o5v0ff4JEWMOm9jUobsBtuiFv8KTOhUEmzjUvmxajuUBKLs/rAn
LJJpLicl4vccfw1bpL/f0GGZu/mWO+/IAHRe8pmno42a5c5mY4G81RrwcPYco+N7
0J4FXcpj2ri0gkhlltY++GwVDH7f+YRbodPBkIypdrvgZ3ZURyI/jod96aVSb8f3
cb3awuII93l0gvPy3lYAo4Q9MuQ620Vtfc8uKb1jWIrMTNooY7+ioY5pb2lKZ2oz
vdrK/zoyrc0EyAPZzoOgZYJi/FNeNLxqIxHKn41WeNn+qbwxVuZ4AtFugMLwXtE=
=ocqZ
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--
