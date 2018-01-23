From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
Date: Tue, 23 Jan 2018 17:37:32 +0000
Message-ID: <20180123173732.GI7600@sirena.org.uk>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2018 at 07:08:15PM +0200, Andy Shevchenko wrote:

> If it's not critical, I would suggest to wait till v4.16-rc1, where I
> would like to push [1], and switch to DEFINE_SHOW_ATTRIBUTE() macro.

Too late, I already applied this - a further conversion for the new
macro would be good.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpnctsACgkQJNaLcl1U
h9CVHggAgE4n+giVg9u4xhMlinZeynLrEVZwxu812CRq0v2MICd6KytFjeK37dHi
HwSBouj1GTugqzu1v+auLELKH26BYYO0jUzpKslhjYOHYxQmWDZMv37LqG6z2Ryb
Mnhsua2lEv61va28lg0qvQcboWaYFlngVbqsRkhq/msiB/5W3ukShvPJf+JX8Ghu
5HM5hvKd6XNcU+LRcQq90hm8e0NmvpFhZ3RNzcEKQZQTHq7YkJ9M77w91DRWyCEQ
4GsK7YEXNTTpsoPHgt4MCfLTVh2MKNvr/r/EJ3k/661wJYD42Oi/yuzL6zWVVcEz
QSbGxArJS6IPqOmIcPHwElF7Mb3wvA==
=yeqY
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
