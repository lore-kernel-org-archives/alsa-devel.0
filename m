From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 23:45:20 +0100
Message-ID: <20140331224520.GF2269@sirena.org.uk>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <20140331192349.GA3431@mithrandir> <5339C638.5030303@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1453525573079474444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 580842651CF
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 00:45:38 +0200 (CEST)
In-Reply-To: <5339C638.5030303@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1453525573079474444==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf72EjeiW3qFOybB"
Content-Disposition: inline


--Hf72EjeiW3qFOybB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 01:47:04PM -0600, Stephen Warren wrote:

> There seems to be a mix of ifdef'ing the table and using of_match_ptr()
> vs. the other way around in ASoC. Mark, do you have a preference which
> way to go?

of_match_ptr() is supposed to avoid the warnings that the ifdefs fixed
more prettily - I suspect you'll find that the ones that don't use it
either predate of_match_ptr() or copied something that did.

--Hf72EjeiW3qFOybB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOe/9AAoJELSic+t+oim9HooP/1VEYhfP2dQ5qSNtBTnDrktY
k0X693lzJ9jyhQ7TLeS1eLjFXzTTh1OiJ/OJuUYv7BGmhddAY7USDjKacnKtwSV5
uPkkwjVEqApVXgo0BjDtLbyiEgs21Fq7XOeIw19A6Lbgn5S5T+hREdLzqr0QpTOg
L9J1gVGhIfcvccZtbhZrpnEv+tG7xo/jn10yej/xKG5CGjY0ATgaMVQnNqFnZkLA
3Ko0W6QeOz7LvMm1iwkKKG08AS7eC7HVfVxByzQ/Pe1UTEC2oEiftrtEzl7XH/I+
+30jVzeALytlmF14xrlnKpKVXnX44SFLMSNq5HxVeHSlBH5vfs60iebLFE9yBCA0
cexDs7JGwr9PIK2Tt9Al888JnHzLnqL9/9yVlfyoiGVUjExv3uwg8OwE1QpL5aby
R4GBWUT4mip3dLMD5Rutol+pFsrj38CClU4Zm0Hnm6NxvYvXGRhGNpMnNcv/5WHp
gtMKZtdm3zz5vRue5AzKdYIMEbKS6SwCifUkIDfy9E30+Y4HxFIfH43eLX6KHDn+
7HZBcRxGaagLE4oWX1DVipml5n0aOoCLKGmnn59Q9PaZXQwLtTtoFY7BYpXfbX1p
9IonpDf5st7gMmlXdQz7OMbWYAA9qNivs62yfD8cBxbUhLlG1IBvkyKERbDMsFPS
KeVoRgEuDOc3sBM5ZGf0
=v2n/
-----END PGP SIGNATURE-----

--Hf72EjeiW3qFOybB--

--===============1453525573079474444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1453525573079474444==--
