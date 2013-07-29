From: Mark Brown <broonie@kernel.org>
Subject: Re: Broken headphone and speaker amplifier
 suppliesforthe rt5640 driver
Date: Mon, 29 Jul 2013 07:07:16 +0100
Message-ID: <20130729060716.GQ9858@sirena.org.uk>
References: <51F29064.8080003@metafoo.de> <20130727173509.GJ9858@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB935C48A592@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1406145308501449635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C3F28261A24
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 08:07:23 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C48A592@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============1406145308501449635==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lul0a8V/L6PD/aW+"
Content-Disposition: inline


--lul0a8V/L6PD/aW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 11:04:46AM +0800, Bard Liao wrote:

> The mute/unmute control is written in rt5640_snd_controls[] now.
> It allows user to unmute speaker or headphone before dapm power on the related power.
> And it will bring a pop noise.
> So I prefer to do the unmute/mute step in the widget event.
> Is that ok?

If you need to do that you should really still present the mute control
to the user; store the current state in a variable in the private data
so that the user always sees the control and then only write the value
out while the widget is powered.  Mute is expected to be fast and some
userspaces like to be able to mute individual outputs.

Ideally the core would be able to do this.

--lul0a8V/L6PD/aW+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9gaRAAoJELSic+t+oim9qugQAISwXNVWukRFZJPXoB4a44hi
r3d7VQPJgeBMJiTRL4B3kOhir9mjvFwRZw/ozk83ZSDOefd5wAC9XM9hmIXK4jr9
ef6g/E83W3XprNdWu/n8fGLjQwWaQKTjYneAdKjosq6LQNbAifFNSytmJXWaM03R
/a+Wiu9XRVeBXmoj175NkFMhBa1q3CjrnMLVl+5PBRMb+g4z1+pWpR6aTjzhEBbR
FCuXp39KoJFqJ/xW2IbW3jQsptouqfQ/yNoHsDBI7EwKFErzUFqn+Hz2q1Kwv5H9
cTXD/VkW7pJthhScHuIfSNKE5+tlHbNbT5Qosud1SV1Gjqbu/lKgdcRD2UBn3Uuw
g+d2ekJI3rVGl/LV5RnlMqInxFQvYQg01WWciYbe0HvZatb6b80XlrdxxabS3EG/
P9SSg9g7s7Xbg6IeEktNUo75+aqWItb7V0fOrCVfTi5DiaC4UUApfvo2iYNvF7EJ
I9V9VXEDTzkE0Yxe1K5ppYzEjkBKX5E295KZDLOzjaFwrCaxWjxtaD4jVJxqszlY
/BmvkDo4QZsfjetX0bMidqvAEhCXApQyfiP4MGKPBh/xm4gE7A2wzzT328arLk3K
mR9NVbcx6nUpgdUf38DGcZ/XrYXDa5V8DOyAREnYMpfV1NWA344d+r4Q2TqoktOj
LFC83SpwnuUNM+owRHGI
=YYG0
-----END PGP SIGNATURE-----

--lul0a8V/L6PD/aW+--

--===============1406145308501449635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1406145308501449635==--
