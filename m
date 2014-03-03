From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm1133-ev1: Convert to table based
	DAPM setup
Date: Mon, 3 Mar 2014 16:06:36 +0800
Message-ID: <20140303080636.GU2411@sirena.org.uk>
References: <1393831028-17738-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7998743749479682731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9699F26512A
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 09:06:53 +0100 (CET)
In-Reply-To: <1393831028-17738-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7998743749479682731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rYaPn2Jr/kqjcqFq"
Content-Disposition: inline


--rYaPn2Jr/kqjcqFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 08:17:08AM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes.  This on one hand
> makes the code a bit shorter and cleaner and on the other hand the board level
> DAPM elements get registered in the card's DAPM context rather than in the
> CODEC's DAPM context.

Applied, thanks.

--rYaPn2Jr/kqjcqFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFDgJAAoJELSic+t+oim9mlcP/0+vFZ8e4NMNOVwBtj3V8z7u
hqYCauF4CSjB+icCcJduq4DwI4XDqjH/16+hf2nDDci+ooRg8eksVhZnUg73SP7C
qrme4Y3tMbk5Mu2tHIYB0EUPWuV85BC4JsuiaO7WnSNcCw7I3hGimhit9nR3xcKa
I1REMdlRZwaWH4ijrWL2Pso3MR2b+pJh4tgn1oXcyKdmbyaCZvhIwk0mb0sdRKJJ
5qicWxmHX4enBd+a5z2i0c1aGW/yIfc2VkltkcaKSmpnyBj+tjxJyj9T+A/1O2x2
cKE9zAgVuIynMMZJzuVJU1wYDX7B7wnRwBl6dkHchf9z5KeahUgQCfYgQS6HPFrc
Rpeul4OCf05VA+nNtGiXKffI/pIZSibhhIVqRjzarPv8eBub3EojMnG+oRZxtQ+K
y1jGbPhz8oR2DA58IsRsBZCnbJReBqmOgcaSLsDS6ZtdoORmH3GotUSCPR5jMeEf
MNBb5Txdjc0f4c1bowurHW82K3WCYxxVd32c9yc85HSFMrwJXfJrTMWCrw9VG5iu
GzfEfRPs07ltRoQ3pbA9gyDr/B9kk7PlvOYfrdJA5MDBSwkD1tdAifhGu21jv/0Z
/8Ond4Hr9ydTEVfRZ5DNKjHiYYCHGulRciwXtFKN1d44Sx3rxJilO/R6IzGar8Nc
lLqTF0jx9UWS4+WWDo4Z
=btPb
-----END PGP SIGNATURE-----

--rYaPn2Jr/kqjcqFq--

--===============7998743749479682731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7998743749479682731==--
