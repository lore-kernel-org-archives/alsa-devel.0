From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/12] ASoC: pxa: magician: Convert to
 table based DAPM and control setup
Date: Thu, 13 Mar 2014 09:41:16 +0000
Message-ID: <20140313094116.GF366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7192623679084033345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FECB26531B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 10:41:31 +0100 (CET)
In-Reply-To: <1394634460-15889-11-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7192623679084033345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:38PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than

Applied, thanks.

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIX04AAoJELSic+t+oim9JRAP/1TtFhkvUNymFwtMzWicVDf3
kgCBDrD45d6uTRC1A1qy1DnWqchpAjRazxEUe1wjDB3vHe3EKtXkuLFQ2zf11ApC
0Ri5adlrNlBygdftlOZQPBH1ekQLQWABiVLh2wYtPbpha8+WFcK/SdNi4TTZb1YL
F9oDHohjSjizX38uCdYHVxv+X3W+bMNnt7IucmXte+VQ0XrKCJz1KAYLAZHndm4c
Fa9ajYDp1lK/KrLecDi7WWg07IwXnVCJgU7Whhu0kUOvilGgayNG+ptPyefmzcfw
p3o4FEop4xLKD5Kf2hUJf9eppiZLCZUIJWssRs9Xj5k3U64FhUjVdteLTH05zQp3
IG1Dm0Bp1GuZeURicI0zL+SCSfgTdwCZB/mU5uzEklCP15lORkwrF8hQgsWRwfBZ
2B0+mcB84ku4zXcbxzuz6ECmdBOqSA2Z8WYZWwz6J1BnrOkkaIj8Fy+W/ldISAP3
PWYekcOCBHwc1xfeWGGUuUttD4nuaa1MEn1f8sGwac4uvV9qlaQNjW+SnwvUc0p3
lB3owEuFs9NtUisaJa60qLg6YOsXeVbqdOe7vST96Wa1ZM6sVFp0Aom8bjVvh1cf
FDOb02iv7qy48p3xKl7OMo/TdKCs6gjGI0SdXRVJSZ1mQHDbVT1ZBnVFd7RdKFv8
Rk+03tGPE249C3C7q1QZ
=Zsns
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--

--===============7192623679084033345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7192623679084033345==--
