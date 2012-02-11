From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 05/12] ASoC: alc5632: Remove unexisting
 route from Phone Mix to Mono Mix
Date: Sat, 11 Feb 2012 22:58:10 +0000
Message-ID: <20120211225810.GE3745@opensource.wolfsonmicro.com>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
	<1328995598-8788-6-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4483089739396967937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86829103AEA
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 23:58:12 +0100 (CET)
In-Reply-To: <1328995598-8788-6-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4483089739396967937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 11, 2012 at 11:26:31PM +0200, Leon Romanovsky wrote:

> @@ -443,7 +443,6 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
>  	{"Mono Mix", "ADC2MONO_L Playback Switch",	"Left Capture Mix"},
>  	{"Mono Mix", "ADC2MONO_R Playback Switch",	"Right Capture Mix"},
>  	{"Mono Mix", "LI2MONO Playback Switch",		"Line Mix"},
> -	{"Mono Mix", "VOICE2MONO Playback Switch",	"Phone Mix"},
>  	{"Mono Mix", "MIC12MONO Playback Switch",	"MIC1 PGA"},
>  	{"Mono Mix", "MIC22MONO Playback Switch",	"MIC2 PGA"},
>  	{"Mono Mix", "DAC2MONO Playback Switch",	"DAC Left Channel"},

I'd expect the corresponding switch in the mixer control array to be
removed?

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNvJ8AAoJEBus8iNuMP3dhLEP/0Oijg5TxMV9pI33NCvEFNbC
A818gJ6XZrR1L93lhJAaR6plR1ECwCN57+AVjMd9Ua+iTqm0zARgjlH3Isan2gWE
wDkO/TrVz+tJ+Kx3qKplMUGEx3nS4Y+z95U+csQ7oZIHzEjhA17vVBTBphGzpicX
pHztf+0hnMKFEJ4wx9YV6io9sWXbEXAR3JiGSfzCrEruVV9/3KvNU1zyLPrxvPrY
wSTJn0w3rWIk//+BmAVlZhl3u367R0NFOKRDeFiXi+EohFKKuyLgcW7n9EBDr7xt
psecW1rVzVKwQPH/agw4W3KnXCugmypAjpOOmtdNnRhhmpmBGJ+9WsXDCsjBKHpe
vzvchSZuc5d+EQQuLrN7ur8JWcnssuhsm7+0YW7YV7zkrI4TQ5nE3VDC/o020B22
31MF4gOCG7SnWjUO5ryXV1WhMUcud9Wcpagax4WwsJ7FO+mW942imPtLZpCElFra
+G64YPOLZDzY8UYli/Sugo8II1tbdq4QHB7hHUMSa8Er0moXhFGPjzUb8geL+ysT
jzFnTPV4Y2Opqt4Gup3s9BHvyCtWWec5MhmaIX2Wwzm0H6X53bydCY2/hMnuhCeb
2VHiv56Cw7vbMqbFtqb5Fx4xd/Vkm01uCcv3+GbOEat3wf3vuBVNvS9rFHjjuip/
qASgnKKexKpEhq3qM/ve
=Vg+x
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--===============4483089739396967937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4483089739396967937==--
