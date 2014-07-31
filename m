From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: fsl: Add stream names to CPU DAI drivers for
 DPCM
Date: Thu, 31 Jul 2014 20:55:47 +0100
Message-ID: <20140731195547.GV17528@sirena.org.uk>
References: <cover.1406688048.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b6KVNqYBpl4d9+rq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1406688048.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org


--b6KVNqYBpl4d9+rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2014 at 11:10:25AM +0800, Nicolin Chen wrote:
> DPCM needs extra dapm routes in the machine driver to route audio
> between Front-End and Back-End. In order to differ the stream names
> in the route map from CODECs, we here add specific stream names to
> all Freescale ASoC CPU DAI drivers so that we can implement ASRC via
> DPCM to each of them.

Applied all, thanks.

--b6KVNqYBpl4d9+rq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2p9AAAoJELSic+t+oim9k7UP/jE5Gew7OjKcyLkB1HbSU48d
sNjdIdsAr9YqQIIOefbA6mjs1u9hdaNb6AMeR9y5BvT5JcW5Qa8yxtIpYbuy8GE7
aq5ocu11bgDbVOr6GPSfRtVDVPT/RXQOEAKBHV5AclVE+hQmESMLaQRNhKwiVVBK
GgqAdHiLSOH9BIq0kawhGvh50ltUhmw6F5BTEWMXCd7MYOqrTz108n76kqoV682q
+c4S4xLSbka5cM+W1VjzoNpCGOZzKC008WwC7ZjQcVjTdO409LRkIeekdWJalOR2
mS/HRXV186//768SnVDopG3I3KawR66LixfUHIqiyaNgaPtv97A9EqSPKN2ktO7f
IQZA3fKB12Z+BUsuUoV8Z1qbAWsatYgRdKbv6YJyLWIRfKw30PrnFgf5GjjMWnIj
T0hYQdIHeNIa3swNWI0/EQj29KHM9AYD2bPLUwsQWew2TDVtQ03el9Kn2+krCl+M
go/O43VdWpXJ4j/ZaI08LHXt5FERvykO6Hu6vSZZIxAyxy5eo6gvS97+t3IiKUse
DKXVjOKtw8wYBfrTJ3Rzaz2DF9iSrTpluYDRTnfMcaTB+yL7BIis4MkkHiDhvGOw
QLCJVg4vQzzOKQdPn9tqSPL0PNbcGAH+1IIqfl+YiJXmv4othPaf4Rc1r6XyT/gb
yeoNtIN12jM9cY4iL3Ay
=Q2VY
-----END PGP SIGNATURE-----

--b6KVNqYBpl4d9+rq--
