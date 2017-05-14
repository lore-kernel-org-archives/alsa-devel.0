From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: utils: Add DT support
Date: Sun, 14 May 2017 18:56:51 +0900
Message-ID: <20170514095651.jbk2fkea6th24yay@sirena.org.uk>
References: <1493712508-27919-1-git-send-email-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0328442730729827141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE3F266DBE
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:56:26 +0200 (CEST)
In-Reply-To: <1493712508-27919-1-git-send-email-vishalthanki@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0328442730729827141==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ss3s3ptm7fwe55s6"
Content-Disposition: inline


--ss3s3ptm7fwe55s6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 02, 2017 at 10:08:28AM +0200, Vishal Thanki wrote:
> Add device tree support for the dummy codec
> driver.

Why would this be useful?  If the device is a dummy device for internal
use obviously it doesn't actually exist which tends to suggest that it
shouldn't be represented in the DT either as the DT should describe the
hardware.

--ss3s3ptm7fwe55s6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYKeMACgkQJNaLcl1U
h9COQwf/ZPZTcv34rqZzoY47/k7mURJMo5vUIg5I7EIdnIzn/cKMQX+Ak/MnzfRq
dTbEvKxfx6T7ES8PxO0SkH75SVBYPPkpH+GgegzQNPjYIo1/fhV/VygN6xN2Fn7P
ynXAc8ww4BbRmyKp58WcvjTIG784pnw1S+Ug6wI7S2H5BSNeTn7FPJYjVVfOq4/Z
tIcRdNkNdsfnR7cc7FRro+B3WjEoseg95fBOvD0gREf62+E+2H7c905XJ2QZDEwK
y/Q8i2bXJvq/rCRzd3hdabkAJ+6LlngW0AlkcnE4qfjoWde1Xe91a5Jp8swmdQxM
Q8ojY9Buo7KwYSqKyJ/5GnlLpJY2Hw==
=+li8
-----END PGP SIGNATURE-----

--ss3s3ptm7fwe55s6--

--===============0328442730729827141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0328442730729827141==--
