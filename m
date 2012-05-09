From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Use DAPM routes to hook
 AIF widgets to DAI's
Date: Wed, 9 May 2012 18:29:03 +0100
Message-ID: <20120509172903.GP3955@opensource.wolfsonmicro.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
	<1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
	<20120509171833.GM3955@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1205091219570.6547@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8162500045750033590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0A982413A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:29:05 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1205091219570.6547@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8162500045750033590==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rKOZBEg9ux5nbisz"
Content-Disposition: inline


--rKOZBEg9ux5nbisz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 12:20:29PM -0500, Brian Austin wrote:

> can I just submit a new patch that adds the AIF widget changes? Or
> resend this one with it included?

They really ought to be squashed down into a single patch since you're
sending anyway...

--rKOZBEg9ux5nbisz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqqgtAAoJEBus8iNuMP3dmwsP/iaYYgRSLTTYOkAsLYeoCxL9
pCrp0ky1PLSSNFjWwCrkhwYVbvdA13eCd4bOXpjE6pXO+tU8J8LmPj0z1Kv98f7k
Br3SXDOgzAiAWv/UCvkG5zyU+fdOpOlrxymm+yQjs7c2tSnm2kXhtCN5EuEGVd3G
Lz36ym/cVdegQIn7G/61bfDqWnElwyj77gi9Gi7ve89OTpUDt4OIYvZNe6yy5lo1
eLEQj60s5+ZSZBk/p3NVTM1G2fV75HhhvFh5OaitQkLNNUUfnfQg1Y/IsR1Jk/AP
rZbiLmuc3ebDHX6ysXZ8LHczU2gpcy9+2H+eh0QaJF/kSc1QGrkYl4BvsgSNPY0j
tOCKNJPm8E29TrrCqP6aVrat1sjE6AhoDll/vEIQa/7HWbDTajG5kTXQE/f/lwIS
S+S/G1rv0xXKrr1H9WBS1ANYCTezSeICviAVXggXiOf/EVYOAq0tTpPmcdEvekJl
zZTAgRN+N6tnrRwfOy9GMHSPlw4Bp8cSkO1/MV8eoHfZ5iDzwuOLqdMO2ABzPQHj
+2JEDm11s/OCpzw8CDwkvzGrpNHBvlCg+npSzQs6U1nJCcmylIPFgJIQ5GTwbr0N
8N8YzBLWJt+v1XOsbL58ijspjzrvazAvgVReDy/VUZ3T84QG7HAq6fdBqD2iECq0
+GMUoYPU8/mRIVKAKPBI
=xjHT
-----END PGP SIGNATURE-----

--rKOZBEg9ux5nbisz--

--===============8162500045750033590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8162500045750033590==--
