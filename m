From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: add driver for max9768
	amplifier
Date: Fri, 27 Jan 2012 16:25:01 +0000
Message-ID: <20120127162501.GA18572@opensource.wolfsonmicro.com>
References: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
	<1327677023-29310-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9182267454816438823=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E6C7103839
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 17:25:04 +0100 (CET)
In-Reply-To: <1327677023-29310-3-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============9182267454816438823==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2012 at 04:10:23PM +0100, Wolfram Sang wrote:

> Mark: Still no DAPM support. We don't have PM on this board, and since I
> couldn't easily figure what is expected from me here, I'd like to leave t=
his
> for people who have real interest in that.

I don't understand what was unclear here...

You should at least use set_bias_level() to manage the shutdown GPIO I
guess.

> +static const struct snd_kcontrol_new max9768_volume[] =3D {
> +	SOC_SINGLE_TLV("Playback Volume", MAX9768_VOL, 0, 63, 0, volume_tlv),
> +};

> +static const struct snd_kcontrol_new max9768_mute[] =3D {
> +	SOC_SINGLE_BOOL_EXT("Mute Switch", 0, max9768_get_gpio, max9768_set_gpi=
o),
> +};

Should be "Playback Switch" to match the volume control - that way
userspace can present a single control to applications.

> +static bool max9768_always_false(struct device *dev, unsigned int reg)
> +{
> +	return false;
> +}

This should be the default in regmap for formats that use format_write
(and hence can't read back), please fix in regmap rather than add this. =20

> +	if (pdata) {
> +		/* Mute on powerup to avoid clicks */
> +		err =3D gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 M=
ute");

This need to avoid clicks is the reason I was asking for the DAPM stuff.

> +		/* Activate chip by releasing shutdown, enables I2C */
> +		err =3D gpio_request_one(pdata->shdn_gpio, GPIOF_INIT_HIGH, "MAX9768 S=
hutdown");
> +		max9768->shdn_gpio =3D err ?: pdata->shdn_gpio;

Eeew.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIs8kAAoJEBus8iNuMP3dJzEP/RagBCm6xHGd08eckZXaOmSy
EWM+ZlmSfqS7TgUp1AHj0lfsB87Jfd13nIE1tJ14L55KIe6ZhN1tzhfQlFxwSWlg
UiRRDavZMdtt3uWhyzOE0cL734ha4999g/qkIkc5p4ConOyR9XZ1tzpjMU87d3qH
s/7vk/QUYIOB++tHev4zhpU5/QMKPNhqd9lRSVny/gca2sKTW3QmfIjYyg/+R+1l
vuJ/vLrTedhePvPkep1XK9kjP/SlASkdcyO7kUCBNFPxlK8yddX/sIZYX6mxcvIs
Ggmk6cvtSDmbyo4s48BaMOiX7SVZWkRCq139qjKB77pz5nu9XXtu6LoKFjIkJNKT
NMWs76gBzF1P6abc5Qe4SLRwtKyojcTacI53S0c7Qs30KRYpmbxSkOD0XOLSbuUA
2vzkk7oHSM9WqAw2k5v3AjowWw4ujilDlRdBaLsuIsLIzWuqLRrf8pdwLO6V6Jrx
G3ij6s6t1w/4QGqfHIn7fUkYzIsnWw/+cp02nv4YAX3FRmgT9ewff8SqMh7MmSYq
Jy6/R2cUB92TisD2fk3U2LDrGDkItZATDmzAinRIj4NB5/5aD4d618feNeZ/9tlL
HV11nu0RWvQ1j0Km2xBz22Xw4Jj1F2GN4Bz9svavq6Mr84Vg9NmeYhPmO2ZOMeNY
9MFyp/ijgCgMEa2smfow
=bANZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============9182267454816438823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9182267454816438823==--
