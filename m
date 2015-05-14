From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Thu, 14 May 2015 18:53:52 +0100
Message-ID: <20150514175351.GQ2761@sirena.org.uk>
References: <554E8634.2010008@maciej.szmigiero.name>
 <20150512175807.GL3066@sirena.org.uk>
 <5553BAB4.3040209@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RU5vHP6eAM91MAfE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5553BAB4.3040209@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--RU5vHP6eAM91MAfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 10:57:24PM +0200, Maciej S. Szmigiero wrote:
> W dniu 12.05.2015 19:58, Mark Brown pisze:
> > On Sun, May 10, 2015 at 12:12:04AM +0200, Maciej S. Szmigiero wrote:

> >> @@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
> >>  	select SND_SOC_88PM860X if MFD_88PM860X
> >>  	select SND_SOC_L3
> >>  	select SND_SOC_AB8500_CODEC if ABX500_CORE
> >> -	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
> >> +	select SND_SOC_AC97_CODEC
> >>  	select SND_SOC_AD1836 if SPI_MASTER
> >>  	select SND_SOC_AD193X_SPI if SPI_MASTER
> >>  	select SND_SOC_AD193X_I2C if I2C

> > No, you're missing the point of what _ALL_CODECS does - it builds
> > everything possible.  This will break the build for systems without
> > AC'97 support.

> How?
> In the second hunk of the patch I've made SND_SOC_AC97_CODEC select
> SND_SOC_AC97_BUS.

select doesn't respect dependencies, it'll just force on the selected
symbol.

--RU5vHP6eAM91MAfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVOEvAAoJECTWi3JdVIfQ06kH/RCDdbRLu5W16oGtrjPjP24i
miZXP/KqSy9apWuEODK4I0M+QY3wJnCTqKhYueLmhJO/mzZQ/D51iBLgmo3f+zPX
NjRq4hz/JsOkB4/b4QnfZdFQvcvCCO4EwIej3UfBFK4f07btvE/NjtcZj6Ee4wTg
vSNl9x4fcBjXT/CB2o+7uB088AnHvup5tPcpTks85gFIBZM03w312sL5LmQkxS/u
9tHE3eGSvficN1KQV+wgOKSWMpBWht5WL4sI3W1n7uzGb21BjpWIedXlappivHET
gmQaiTbrt3ZS/hqqPWO8zUXUnij+0W5xT8GC0MdIcO5MxNgZ6zkVbNjiAFJUiKE=
=wFxh
-----END PGP SIGNATURE-----

--RU5vHP6eAM91MAfE--
