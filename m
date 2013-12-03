From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: drop
 sgtl5000_set_bias_level() call from sgtl5000_remove()
Date: Tue, 3 Dec 2013 16:03:54 +0000
Message-ID: <20131203160354.GD27568@sirena.org.uk>
References: <1386034012-18677-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077393905228435261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DA0B261A1B
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 17:03:57 +0100 (CET)
In-Reply-To: <1386034012-18677-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1077393905228435261==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0z9Qw3cBG4bz6tn"
Content-Disposition: inline


--y0z9Qw3cBG4bz6tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 09:26:51AM +0800, Shawn Guo wrote:

> Looking at function sgtl5000_set_bias_level(), we can find it
> essentially does the following 3 things in case of SND_SOC_BIAS_OFF.

>  1. Set regmap into cache only mode with regcache_cache_only() call
>  2. Disable supplies by calling regulator_bulk_disable()
>  3. Set codec->dapm.bias_level as SND_SOC_BIAS_OFF

> For 1, it's clearly incorrect and that's why we see the failure here.
> For 2, it's unnecessary since sgtl5000_remove() already calls
> regulator_bulk_disable() to disable supplies.  For 3, it does not make
> any sense either, since the bias level will be initialized to
> SND_SOC_BIAS_STANDBY in the next probe anyway.
>=20
> Let's drop the sgtl5000_set_bias_level() call from sgtl5000_remove() to
> fix the kernel Oops below.

It's not clear to me that this is the best fix, all this code looks
confused.  Given that (as is idiomatic) the regulators are being enabled
in set_bias_level() what's happening in _OFF makes sense, what I'd
expect to see happen is that the duplicate disables and frees are
deleted from the remove path and the probe remembers to remove the cache
only setting.  Alternatively all the regulator and cache handling could
be removed from set_bias_level().  The end result should be that either
set_bias_level() or the probe and remove are handling this but not both.

The regulator get and remove probably ought to move out to the I2C
level, as should much of what happens in the probe function.

--y0z9Qw3cBG4bz6tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSngDnAAoJELSic+t+oim9CKgP/A9RcQgsvxaKbWYvmNLup0I2
K5yqXNJGeZ96LSvL+i747naZUVfLmhpAPeDT8xzxg3ex3mh1YC0u5Ak0i913bhew
4P30G8DsVOyYmhDCgOXpQzq/WjwdHaPifsNOogoeZz2wfe/gPVJSK5dY7UNmJi8Y
DmVvw6Oq1lIVuD2lW/ybbUlCbRmAr0PrkQuk/GkuSUrE6VbnODfEcwTiSB6CB3ds
TLjQSmLZCLHrwNsG3FqUCO5yHMIsVMM/mY+o1//3wkHPp+IU1OBHhQ9oDToah8eR
sfGaRY7GWIh4kgo1+Pbx+nqQ9Ae1K3rUcJLa2/7LaFvcLRt42HbyZ4qhLYe42GWY
wlDAYvlsrE7yIpXk+oxlCAgmOTkBuezxEayKCJp0ioxPnvUFTkfymH7NrJuLPG72
PprGpPm9hCYjOOaAn1DEWg63vcYxITxo+jzKtPvHX7LCYpVTYTpLqpzQrkWsVrV0
9hXiWmVNIeXEvJ/m6olGAKbtLuF36iQmPC4MZVuoOxG4372e4FJ0VujSh6Btm7pq
MXyS4lGyPMnnK79NNfTw0CBk4Go4Ed5OTjs6RVyZKZV7PHT+DT7Wujky108fU1mf
41YtaceG+aP7wCVt2QHXiuL6U/r5V6/2jHxH/7bTfMVHz/jlu+irVWzRrJfb5ye1
G34xvlfCTgpGG3d7Z/VR
=Jnmr
-----END PGP SIGNATURE-----

--y0z9Qw3cBG4bz6tn--

--===============1077393905228435261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1077393905228435261==--
