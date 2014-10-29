From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix snd_soc_find_dai() matching
	component by name
Date: Wed, 29 Oct 2014 20:51:49 +0000
Message-ID: <20141029205149.GL18557@sirena.org.uk>
References: <1414615591-22125-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7417136266968089780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF1526057F
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:52:15 +0100 (CET)
In-Reply-To: <1414615591-22125-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7417136266968089780==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fxB3hi9J0bo07GMp"
Content-Disposition: inline


--fxB3hi9J0bo07GMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 09:46:30PM +0100, Lars-Peter Clausen wrote:
> Commit 14621c7e5e72 ("ASoC: Consolidate CPU and CODEC DAI lookup")
> consolidated the lookup of CPU DAIs and CODEC DAIs into a single function.
> When matching a component by name for CODEC DAIs the code previous to the
> patch compared the name in the DAI link table with component->name. For CPU
> DAIs the code compared to dev_name(component->dev). The newly introduced
> function ended up using the later as well.

Applied, thanks.

--fxB3hi9J0bo07GMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUVNkAAoJECTWi3JdVIfQyh0H/irTvV9PINfMyJJmrs/1aS+y
4WUKWVjW/5gD+TGwwvu3ZkYtus7vQ+P3KwsFlJmu7hcBvxbNflTrmfM9GrLky+Jn
Rr7l83KrhFjybq7GwnFb7bq876dnAwfVCJ5fkKE7Ubcya6pGv7/dyTblf8hTzyD4
jzPhM24OszI0aMwqJ/VgmkgAbTD6cFauc0zckz+cbNs0Dkjk0N2OZcbfL4Yh1wFG
iOjvkZeUjaIpni8kmlFDqhgcCq128kwdmjSLVR9pAhSDSjhXAkXZcfQt4iHtEc7G
ahp8xS4vtVZ4fX2DlOo+PECkeD9Jkl7M+ko7xg+amqU/7nv346bqsRgMw8R9F3k=
=NNjI
-----END PGP SIGNATURE-----

--fxB3hi9J0bo07GMp--

--===============7417136266968089780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7417136266968089780==--
