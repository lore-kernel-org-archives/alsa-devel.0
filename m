From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: da7213: Improve 32KHz mode PLL
 locking
Date: Fri, 5 Aug 2016 11:30:01 +0100
Message-ID: <20160805103001.GP10383@sirena.org.uk>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
 <497bb3724104ba16dc3588287f6071f0b7cce09e.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
 <alpine.DEB.2.02.1608051102420.11835@pmeerw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hXth9cGL35Nvpk4x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1608051102420.11835@pmeerw.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org, c.huber@bct-electronic.com
List-Id: alsa-devel@alsa-project.org


--hXth9cGL35Nvpk4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2016 at 11:04:51AM +0200, Peter Meerwald-Stadler wrote:

> these registers cannot not found in the datasheet;
> maybe add descriptive #defines in da7213.h

> > +			snd_soc_write(codec, 0xF0, 0x8B);
> > +			snd_soc_write(codec, 0xF2, 0x03);
> > +			snd_soc_write(codec, 0xF0, 0x00);

It is very common for chips to have undocumented write sequences that
make tweaks based on test registers that are deliberately not
documented.  This looks like such a case, I'd imagine that register 0xf0
is a test key and 0xf2 contains a value being tweaked.

--hXth9cGL35Nvpk4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpGpwAAoJECTWi3JdVIfQOPoH+wYC6l1454e9Mt3841Zrsuk4
3/ph29vEEJby8M/3eCuTM6B3RrC1GRzze98azuEoCe4inqby6gpWlxQf8XGIYXok
e9MIeg6JglXX/J0UyjACHegiEsinGrXueCdR3YegdgzM9PX1u3mRdM2bRNuowicC
nYx137wgmT5J93g+CEPqAP6hklUO/Kyd3qRUbS9G5j13avOz/WQAwZi0HvQvmugh
ReVQAeVjHk+FT5Yqrmi2bp0ljZXDqR4SfM6qMNAMAidvfcA5YkcQbhBWzrrjU+dB
4VS3yumBcWJ9e20GJBqGfFeXQ2IwqrX5/I4ccu52z0u316h/l5hhcx/FIMvAjWs=
=l5Ip
-----END PGP SIGNATURE-----

--hXth9cGL35Nvpk4x--
