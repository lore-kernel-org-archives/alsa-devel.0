From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3 v3] ASoC: TSCS42xx: Add CCF support to
 get sysclk
Date: Wed, 28 Mar 2018 10:44:27 +0800
Message-ID: <20180328024427.GN29239@sirena.org.uk>
References: <20180327175040.GA26604@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0091656622200251540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0BC267194
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 04:44:31 +0200 (CEST)
In-Reply-To: <20180327175040.GA26604@t7-ThinkPad-E560>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0091656622200251540==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 27, 2018 at 12:50:49PM -0500, Steven Eckhoff wrote:
> The TSCS42xx relies on set_sysclk to get a unique clock id and rate,
> which
> prevents it from being used with the simple-card.

I'm missing patches 1 and 2 of this resend.

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq7AYoACgkQJNaLcl1U
h9BqWwf/XFltXPVpE+9oCtx/BdFm0tGKdCQ/Cfy5SJhwpuB0EYm7RTOk2ht3819b
ogV0oJguUQZANVtlU1zbT0GzjGzOQx3RuAOK1TKfW53K3Gdw5CrxV8GcaEmM3lRK
BxGjtMuM5sIBVsZWK+8B3PSQ31PCmoxTxTuB0+FBKfpodMeK2al8cic0HuThLZ/0
vom8sAtR/HlF/d+XMgoT09I9LqEYrRZtLY7r7VbUqXrXQhNkWAT+2ir+awWpknOI
EdfWSDCS/1fBes4o43YcY+qrEmnGZZQFu/x6J5PLSiDt6nY3FUIs5IrC3/IczjcM
Coj0UDuL4FHS15GOqk1eMGP9wjFs2w==
=Lsi8
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--

--===============0091656622200251540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0091656622200251540==--
