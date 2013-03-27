From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Constify the 'driver' field of
	snd_soc_platform
Date: Wed, 27 Mar 2013 23:09:57 +0000
Message-ID: <20130327230957.GB18316@opensource.wolfsonmicro.com>
References: <1364382144-30151-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8862019460105345820=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3A1826531C
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:10:00 +0100 (CET)
In-Reply-To: <1364382144-30151-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8862019460105345820==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4hVWSOEjyjyaPny9"
Content-Disposition: inline


--4hVWSOEjyjyaPny9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 12:02:22PM +0100, Lars-Peter Clausen wrote:
> The ASoC core does no not modify the driver of a platform. Making it const
> allows ASoC platform drivers to declare the snd_soc_platform_driver struct as
> const.

Applied all, thanks.

--4hVWSOEjyjyaPny9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRU3w3AAoJELSic+t+oim9Nb4QAJGDrpP/f9bJqhEIEwTQntbq
nwe+WlYhQvshkjkHXy09RYkTY+zjFpzap2xOBT1aN0SANCxqUp8qLfXa15uf+eJG
zfq+FSSIzlwcqV/tFR34LiC4NAYMA/Cm2KtxJgxAyZRBAlC1gRLMqXOvCG31e4oM
ihMbnZZqcMZf+KwljDqYS00WqjgXrJHby7fxtRuM/CSPHB4m6fiB4Phkl9qu2A8E
ojtHiDpxK+L3PN4BsXf720JepNNq0IkJVNzMsqUqQ6xgUJ3oq0C2WxKLGfma+7RD
lqO+osYsz0xmra+qug9450GTkcfGdH3NezB0hzYL4cALSolkWvij/PvY7RTFhRSA
h+PV7i1MKLPo9dsEall60n3JQPypKDLqsWHSKfgNqH73/N4tVauQaDB9Kp4P15Sx
saOwkoo5FM06fH1bhYX4D17ziOdutrlVCsjpKvj1qTNR+NWPjWIku3F/uH4q+f8T
lKmkQY4ZrXbeOBq7yq+wM+fKd3pyDpW6exgoIy+BDeX8YtiNIa9w/36MggmF+Xwl
y4dAuGcsoowrqVeUPVSLeMvitTZmorgXXmy5R4KVv0RQplbHMjn2frqGCRxMeMh7
k4Opr+JUEqmP1BTBE/QLJPzjroeYaLVfFh6+3Fr4xgkjBtUL/+ENXzmMUhiV6H+g
FoR4KtREI0+Zsqv8DoNF
=jmev
-----END PGP SIGNATURE-----

--4hVWSOEjyjyaPny9--

--===============8862019460105345820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8862019460105345820==--
