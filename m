From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix widget double free with auto-disable
 DAPM kcontrol
Date: Fri, 18 Apr 2014 18:08:23 +0100
Message-ID: <20140418170823.GN12304@sirena.org.uk>
References: <1397570289-29215-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uodi8V2iBqNNK5jm"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397570289-29215-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--uodi8V2iBqNNK5jm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 04:58:09PM +0300, Jarkko Nikula wrote:
> Commit 9e1fda4ae158 ("ASoC: dapm: Implement mixer input auto-disable") is trying to
> free the widget it allocated by snd_soc_dapm_new_control() call in
> dapm_kcontrol_data_alloc() by adding kfree(data->widget) to dapm_kcontrol_free().

Applied, thanks.  Please keep your commit messages word wrapped within
80 columns.

--uodi8V2iBqNNK5jm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUVwDAAoJELSic+t+oim9ZfUP/AmrgPu204BR8QZS2PTI1Gp1
J0jiwYxDVxI0BmWd2IrQvIt+MD1qhxpCsCT4Y2dMRbepqUvvLP3M6IAtmUEu/Z0X
lFmXv1SsZamwWiuRraXevNHgrjIC8y2AFRyUaAHBNxoIDnF/j2tyxs1IxUvx5CWo
pJwJXIP8j+19wqDiI0/Tab6c1btWVpf6Gi3zKOn5q/yDVKr6GnIn732RqvLOwnUO
abkAoJ7yeLtqqditEBAXNkgXyUL7jthJhspAFPjGWtSJYvnQGs+vVnkHDy7ON4zm
1KAeuvZnppVEuaTEykuW2ML8I/+/5uGG+QPgw3AYfxdKGjScl/mP7WtNUowoatIs
c4nx9qRxE1I3dPwg6RpnrSKl39od9720CmdUSTjPOS9fxecrfilFgOcuO2/KYBUc
AkDMAnei4Kji31h9dEzFezoQbCC/gGlp1QprBTV/uA+PUMAfD7x7VfkQSn1Uh8a+
L7Mninl82SnKbP/eWX42ZDl1kp0DNETJneGgHyHp4xioONH3TDZ0IHWXZVUtcX28
LPpWao6n8bG7MdoCieqp9aMmvQwnZeGGrfREacVLone1vQ25fBCXqw5fHV7PH7cZ
uPjcX9ziTBmLZZ3kuUNc7lL9rHinLmwakfhDXiyN07BAZSxMP9XGGsnfeWubOlLk
KbYhqkmL6EX5nwZLrkAr
=v2CX
-----END PGP SIGNATURE-----

--uodi8V2iBqNNK5jm--
