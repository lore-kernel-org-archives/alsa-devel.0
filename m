From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Date: Wed, 8 May 2019 17:57:58 +0900
Message-ID: <20190508085758.GE14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
 <20190508070058.GQ14916@sirena.org.uk>
 <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xTSxoVlouPBwYsmu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org


--xTSxoVlouPBwYsmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 10:08:44AM +0200, Jerome Brunet wrote:
> On Wed, 2019-05-08 at 16:00 +0900, Mark Brown wrote:

> > The advantage of mutexes is that they are very simple and clear to
> > reason about.  It is therefore unclear that this conversion to use
> > atomic variables is an improvement, they're generally more complex=20
> > to reason about and fragile.

> The point of this patch is not to remove the mutex in favor of atomic
> operations

Sure, but you mixed in a conversion to atomic operations as well.

> I can put back mutex to protect the flag if you prefer.

> Another solution would be to use the mutex as the 'busy' flag.
> Get the ownership of the hdmi using try_lock() in startup() and
> release it in shutdown()

> Would you have a preference Mark ?=20

Probably using a mutex for the flag is clearer.  I'd rather keep things
as simple as absolutely possible to avoid people making mistakes in
future.

--xTSxoVlouPBwYsmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSmhYACgkQJNaLcl1U
h9BLvgf9EVKAriQdgUhiq7Dz6aMAyyxmJDlqE/NScBYilBPz2t8G+HA2cvFlWiFK
zs5sJD8+Ilb+vIkLNTYWOwVllxdbBD/DYbm5YwxrZ2wF/J0Baa/8aW1UfCnnrtZr
pZnLGa9koscaXO7WSfi736t4neICdQZssXTNKBYfocxxD3ZkL0Yy2fUQRt4/WSr1
+aIF3xIlY+Hc36obOIKYk1Ds+1fIwYGjFtzeeSz8ucaJGI0/GZE3ATnVQ/RjtEly
dSq+r0n7kb/ZLWLDJipmPae0Q4gqdaQ/mtt825n0U5JTJVS5hWjEZHMbX1WhwzvJ
+Tc+JzCa2D7cicvc2W2OsR9GrWD0CA==
=dhQr
-----END PGP SIGNATURE-----

--xTSxoVlouPBwYsmu--
