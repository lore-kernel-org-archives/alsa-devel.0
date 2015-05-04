From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential mono
 mode support
Date: Mon, 4 May 2015 12:25:37 +0100
Message-ID: <20150504112537.GA15510@sirena.org.uk>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8699936816056449452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4911261AC3
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:15:49 +0200 (CEST)
In-Reply-To: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8699936816056449452==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 08:13:57PM +0200, Sergej Sawazki wrote:

> +static const struct snd_kcontrol_new wm8741_snd_controls_mono_right[] = {
> +	SOC_SINGLE_TLV("Fine Playback Volume Right", WM8741_DACRLSB_ATTENUATION,
> +		1, 255, 1, dac_tlv_fine),
> +	SOC_SINGLE_TLV("Playback Volume Right", WM8741_DACRMSB_ATTENUATION,
> +		0, 511, 1, dac_tlv),
> +};

Please follow the control naming standard in ControlNames.txt: all
volume controls must have Volume as the last word in the name.

>  	.name = "wm8741",
>  	.playback = {
>  		.stream_name = "Playback",
> -		.channels_min = 2,  /* Mono modes not yet supported */
> +		.channels_min = 1,
>  		.channels_max = 2,

This should be varying with the platform data: in the mono modes we
can't do stereo and I suspect the stereo modes may have issues with
mono.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR1csAAoJECTWi3JdVIfQkzAH+gOP97s1mBz2YEAGwV+g2CDF
pCKDRlPzlNLdlhtAgdCzjqxnM8TKI6mHZfQr85DZ9TeTJBkFDdiI4bebYRh0XkV0
xvTu6jMGOxDluxg5RwR1K7mQ1kR96dDtKt9aL3L4SgHMw0BJ+FrD8ruhZBNn3vsY
C9a5+iAuzqfuW21ToOvEqseFSbP+lr0Xv9+ED62os4ge7fdBVPRZ6jFhIWlbE/P2
v8nbN1ONonRY+8sqOjTrG3Wxy7FWKdCHJndMi4LeQ23w7vGJEpP3tpypZorbxp4w
alNOns9iMlBurIw7rMj8W7lvP1X+I8VeylmANKq9CZBFknRrXp2Tkhux68IpsYs=
=1FLn
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--===============8699936816056449452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8699936816056449452==--
