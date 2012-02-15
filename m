From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm - Make DAPM reset code a
	separate function.
Date: Wed, 15 Feb 2012 07:57:35 -0800
Message-ID: <20120215155734.GA2996@opensource.wolfsonmicro.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4773789995334375625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90FB2103E95
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:57:39 +0100 (CET)
In-Reply-To: <1329318937-14488-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4773789995334375625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2012 at 03:15:34PM +0000, Liam Girdwood wrote:
> It's useful to export the DAPM reset as a static function for future use
> by other DAPM functions. e.g. The dynamic PCM query widgets resets the DAPM
> graph before working out active paths.

Applied, thanks.  Need to check that this does the right thing for the
performance stats too.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9XlAAoJEBus8iNuMP3dggoP/0okqNoZUoeO/7SdTFqNsjto
V/m/8+Jn+3I5JJN8pTL//79FjuWDHFHQoloFjiO0cKL6VLCX6nZI46kwhslj06Ol
DXq6TmTYULRSkLGunh6uLXb95WlHwpGkaxZDVa4NH1yhASU5mMeBiC9kRmS84eJ3
buTU5V5M74BAcfdB1My5PZWcW034HUlNyOvDpl8mZynRMaky594U3HWdXz03Vgmf
L0yrTm9XoT3zykg1OVM43iAo78KysG2uiuIBII4EySeJLz+kclkgooJeOCsfOb1a
losnq8uGD2bU51arsQQ9sCKluEbe4OQ7whMxzjYzVH+1NIkBOY28znPQEfDmshAr
UiNDMDnznQZ/O16KlzX/JvBfq00W0JPb//XvbSWUkU/ZOSS1H1WDrSFO5wc69MU2
D4MBXYNn8f0qBNAqm4HlRA4RI902qf9HYdyaTaVqFXPnnt+SmTID7ejNSOW8g3cM
9APZAVbOjJkPGj4eZQD8BVSZpw0RawyrLaFdsc+efRDF0PgpBkMYPn3wStG68gHh
apg2oA8bXhQXqhhq8NMtBS1LhzeOzbmaJ8pAVkdU11KP7AcW8qgGk1AGFXuq8tr4
UYEwbUVtC2MQw8W7q6JrOwC7RkWT5RCfOY5U5lS8UFhJhQEF237h3H6nF8nAfqwa
i5IOEqqmRJlX3VCiuNUw
=Zu4g
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============4773789995334375625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4773789995334375625==--
