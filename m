From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958
 channel status word
Date: Tue, 5 Jun 2012 11:28:21 +0100
Message-ID: <20120605102821.GO23408@opensource.wolfsonmicro.com>
References: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1039919085381374287=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0981A245CC
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:28:24 +0200 (CEST)
In-Reply-To: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lrg@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1039919085381374287==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2012 at 02:07:15PM -0500, Ricardo Neri wrote:
> Hi Mark, Liam,
>=20
> This patch is to fix an bug that I found in K3.5-rc1. As the IEC-60958 ch=
annel
> status word is not initialized in hw_params, the params from previous
> calls corrupt those of the current playback.

Don't send cover letters for single patches, if there's anything useful
to say say it in the patch.

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzd3zAAoJEBus8iNuMP3du9AP/R9do7EWCagOItBgZ/50VhXB
vYZiK9CoH4atI9fQjGDq55GCPMfHRmmC27pOOPjh1XhGUUFIX3AufH88Hvr4BcfL
lkd38w7ifYpc6Kqe3K4pp2J6X9cmbbb+FhY30zsLRKMC7Fm3Suud+0lwOv76D5Gq
Tz6Q0m9xrxt9bsVxFdxTsBRUYF+ItRIUh2DJhzToHL+C3C2f2XsJ46Xk6yA2XKd+
8dKlYFB2kYWRA25y2VVad1IVl3GkVly0LaIK8cnEewRT7nGTMAPyN95E6XF8LSd7
M3QIHO66mXIoWQo4DzasYg2bdnRtqCnT782CW39Lyaf7daTIr6TQ1M2o2OJa5UVh
TA6iwI1rcSRRij8fLZdEIh6RxzKjBAOLUTsdgne7mJVCsE7bEX0qsXA8jxmNfX0a
C/N8HH5T9fCRrATCeZhxvT5Q3RhDDVhYHmKrP2PNfwTXJvw3q7FuiP4u6/nukeLh
vIp34z6/yC2ybSI/TbE+gbWaFZYyKYF8Bkt1F1jNX60o9KDadBsV9bvaPfFGyXw3
w/hwTXNyRxoyiyUbOkd8QOWI1s2GiEc2a3cfwL0q3QziUX8m9YPLOIv0wis9mXn9
n5v8t7goDhjUR28GBB9sKJceuUdU1hk7ENBaRvT2KlGgsvU9tKV9vzCPFg0x2XfM
bfGyaOKyZkpOoy67+y2i
=rTGb
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--

--===============1039919085381374287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1039919085381374287==--
