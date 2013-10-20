From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: cs42l73: Add Device Tree
	support for CS42L73
Date: Sun, 20 Oct 2013 18:30:39 +0100
Message-ID: <20131020173039.GQ2443@sirena.org.uk>
References: <1382124601-3317-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1445487572716087393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 57A8E26172B
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 19:30:42 +0200 (CEST)
In-Reply-To: <1382124601-3317-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1445487572716087393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VqAmk0+ajIWvODaI"
Content-Disposition: inline


--VqAmk0+ajIWvODaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 02:30:01PM -0500, Brian Austin wrote:
> This patch adds support for device tree for the CS42L73 CODEC

Applied, thanks, though this really ought to have been sent to the DT
folks.

> +  - chgfreq    : Charge Pump Frequency values 0x00-0x0F

Can you please send a followup patch explaining what these values mean
(eg, "Value written to register X")?

--VqAmk0+ajIWvODaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZBM8AAoJELSic+t+oim93YgP/0Hm4UHZrXyvyQu+xzF6fF32
OXSfNijNU9rBYu3YHvKuh0EnKW9HM63ang5j8Lg+ZqE+TPG0rGe8UlNFYTSkdECJ
r6jXPyfdQtjy0CTLIl3iAN7/rNNFZzz+OrFHgpqynLbNxk3Qt2J26vlVbjPG705y
9TA7pfQTHUq2SoiDrupfLpAxon+rkuRoaUVdwV3jhXCIP/ti2kE0YKyS92uMJWGb
cxNda0v2hWZ5r6K0l9tm/6mdpgR+fkQwHzDG1zT6RqXmI2rujg5wBhBAd3yMFamX
rrWWAGXhxlTNkvGW5tKZda4GonRg7EbHTqHR0/hwmHqRAdx1wgzoXuK9sac84soJ
Sgod4/LJ4aLEaNk7eX5anGiJanl0mEORoGoxFlaalr++cnOLL9+eLAEL7KXKjE1o
oofQXT2veBvMt77DQH94jUAIOXKLLgMbiOI9tspjrWRXnGEd9akEMLNOiqVHpKR9
2Z9T57c+4B1GnHcvFx/Wvpbb1yRREkFLRtLvx0WRYp1RQnExzRyICRqpFvZ3DXBJ
lKG37/h4ubD1S/8Xo9Z4lKK4M32Jg8lrMRkWtnderPp5GtDr0DH6c6+N+Rb+t7o5
lTHbWXV2x3M77AHOI8MGw/zs5I0yL/aKLgmVtbXyuqgZV/yJqCtPlHLTjqY2cA9M
ZfHCOXDczecD478KksOc
=ZSCC
-----END PGP SIGNATURE-----

--VqAmk0+ajIWvODaI--

--===============1445487572716087393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1445487572716087393==--
