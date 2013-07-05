From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Fri, 5 Jul 2013 12:44:56 +0100
Message-ID: <20130705114456.GV27646@sirena.org.uk>
References: <1373024862.3233.63.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9207937047301384093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 786982625FF
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 13:45:00 +0200 (CEST)
In-Reply-To: <1373024862.3233.63.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============9207937047301384093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N5J5EYBkERdVQZxU"
Content-Disposition: inline


--N5J5EYBkERdVQZxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2013 at 05:17:42PM +0530, Ashish Chavan wrote:
> This patch updates i2c driver name and device id of da9055 codec driver.
> DA9055 is a PMIC + CODEC and currently, the corresponding PMIC driver
> also registers itself with the same name as codec, i.e. "da9055".
> Because of this the codec driver was broken. Now codec driver uses
> "da9055-codec" as driver name instead of "da9055".

>  static const struct i2c_device_id da9055_i2c_id[] = {
> -	{ "da9055", 0 },
> +	{ "da9055-codec", 0 },
>  	{ }
>  };

I can't believe that you've tested this.

--N5J5EYBkERdVQZxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1rG1AAoJELSic+t+oim9Jx4P/14OzdHSXQCGe74jOSGjR/uM
dPk1C5SneRbpPSZUW8nw+4AfqXrsbGicSjcK0vWXOEPgr1tOGOtIJQYIJIg3Mbjb
aFnehJ3PMlbDbLubrs3mvUObATKPljfnIOfWVW5iCqx4qea0SLDBFYtbxaAf6kpx
xqSaO7IbuOHLIyDHBkvhafNTDUW1k/FNoBcl64EyJ+P8xAPJNIHG6lQIdBZXzbIJ
pbh9+497WqZ/53JjPCl4RzDdbQTUsXa4URC79dl2eARzMK8MdcsEAxKYf+ShsAd9
FgPCaYW28/zBOqcK9EptUaATQg2fPJoO1E1FyHxCU3rRZIY2JO1G0qrpnFJ0W1Sx
evmvUAbM6qe5+2bA0iFboxuXualACC00GL0XhnIETL2/cch+BH2ig9AFpVkhDgJR
x5bgAw12oj13xWWSJe7OiIoaFj/7UFoMxakSD2IJHY3Od40kQFWGYXu7lk9AQ59z
CHemZ3kPNlz8JSZg1TnYKY3UnmuJAcYcT21GbJskJ/w1ImtL+Gx0zQG5G8V59w3G
7n6Cp9QDUfjn1QXX5ZpusjC7g4SFOh2dQn4g28+MjEkb9xwGpBbbxykFk3mquMiC
EaZ1VQXeuLnpvXndL8oSekKUAoyltvIsyQNWsA8VbSXNc8SL22+7/hIl8oUoFzR5
pnkNY8nn/FpbBogDMfh+
=CPM7
-----END PGP SIGNATURE-----

--N5J5EYBkERdVQZxU--

--===============9207937047301384093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9207937047301384093==--
