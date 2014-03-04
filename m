From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] change kmalloc into vmalloc for large memory
 allocations
Date: Tue, 4 Mar 2014 11:46:41 +0800
Message-ID: <20140304034641.GY2411@sirena.org.uk>
References: <s5hmwh7ab5w.wl%tiwai@suse.de>
 <35FD53F367049845BC99AC72306C23D102844605F392@CNBJMBX05.corpusers.net>
 <531468CA.6040302@metafoo.de>
 <35FD53F367049845BC99AC72306C23D102844605F393@CNBJMBX05.corpusers.net>
 <53146B6F.4000601@metafoo.de>
 <35FD53F367049845BC99AC72306C23D102844605F394@CNBJMBX05.corpusers.net>
 <53149037.20305@metafoo.de>
 <35FD53F367049845BC99AC72306C23D102844605F395@CNBJMBX05.corpusers.net>
 <s5hvbvv8hr1.wl%tiwai@suse.de>
 <35FD53F367049845BC99AC72306C23D102844605F396@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwhGNBny+TwOF9uv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D102844605F396@CNBJMBX05.corpusers.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, 'Lars-Peter Clausen' <lars@metafoo.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--wwhGNBny+TwOF9uv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2014 at 11:33:24PM +0800, Wang, Yalin wrote:
> Hi Takashi,
>=20
> I see,
>=20
> I just want to save low memory for kmalloc use,
> So I want to filter out large memory allocations
> To use vmalloc instead ,
>=20
> It will be preferable, if there is a better solution :)
>=20
> Thank you for your clarification.

Don't top post. =20

Without having seen the earlier mails in the thread I'm not 100% sure on
the specifics here but wouldn't a more generic solution be to deal with
this in the memory management code? =20

As far as I can tell the concern is that the runtime structures are
taking up too much memory when allocated using kzallloc?  We're also
doing lots of small allocations for things like DAPM which will
presumably also be burning this memory and will I expect for most
systems end up being more than that consumed by the runtime structures.

--wwhGNBny+TwOF9uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFUyeAAoJELSic+t+oim9whgQAJVgCtESFaCtY2Vj9QQARkPl
GdGdwDrfTNkLiIIyJIYK9740MLQujcy1ryemsSIBBcggvHsBaLJ9eQAKVANPHUbt
sA8G803iX98Lu6offx+Nwj2kzOaYAS329WFr5NAqyU0eWedvWJHq9+msZiUXhnJL
HnZInJ6zCAjtQxM0AYE3WmzK2OhNoG1yG5ZCdmlHXD4a3TR3QziWnIA/NLPMBUy6
WRQaDDrD/Ezhq79NQaFdnBqslzDKwGQ6CQsSK24piKGgMG8ObJtARLwiJWe4pTvg
poNelWTfGP1r9lvylV2iFvf9tKyzkg5GJrhxdv6n0iHXr6whaKxdY2M/MN8kehxh
bivr9CbnWQMARxmvmBf6W28sZwaRC0XaY2i5t1jSViNBO5HLjlt9HYDzSVazBbn1
KTJ9cWsSHHCKB3P11pqVm/wQi+wNRoNpqJRYhvpJlLKCiePNTQsNwWb2TwQtNQyY
Gd/StwZUUze+tL6RzBXb3G2A0t3so38iHpvYMaWjeVDKF/NUspxuiB2N188qkE2I
OnY8Dsebo5Q4cWVNWTbZ1YypPjgX1jtO8m3WlC9plghtxFBPDN9bEWxBTDJpPkh7
HSO6BkVkPFAdarfgPwpMsHfrz3g3aaPpEEwDFP2+XbgvvTV1CUMVpQ5sUmd1uLQz
dwEgM7Po8un/oIYuESmd
=ghaq
-----END PGP SIGNATURE-----

--wwhGNBny+TwOF9uv--
