From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
Date: Tue, 13 Nov 2012 18:41:46 +0900
Message-ID: <20121113094145.GV18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
 <20121113083031.GP18224@opensource.wolfsonmicro.com>
 <50A20E82.9020704@atmel.com>
 <20121113092038.GU18224@opensource.wolfsonmicro.com>
 <50A214FC.90201@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0iexB5Bk8cF8G6DP"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50A214FC.90201@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--0iexB5Bk8cF8G6DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 05:38:04PM +0800, Bo Shen wrote:
> On 11/13/2012 17:20, Mark Brown wrote:

> >The machine driver should know which SSC it is using all by itself, it's
> >specific to a particular machine.  This is how it's been doing it since
> >it was written...

> So, you mean, I should hard code this into machine driver, am I right?

Yes, exactly.

--0iexB5Bk8cF8G6DP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQohXNAAoJELSic+t+oim9kkUP/3YVZU+oNv1BMi5E++raWEBz
ijQcbbcTRc4i+xCiJQdYnLjDbZq0CzznxcM9hp1G5uk1FScGtUOniAFS6TCev23d
jaQhdn/KUQXG2ah87mX4w42T2WUTgwxJmv3iEVkxfbs/igzOYnNlov3RKEQC00/E
KI6wKVXqWzcAMNlvGG0stn/0Zu3jJ4m8JoZSJPua8xtdUd9xY8XSen4c++rYT9Nz
ePL5zju87Hhr9mjp+XtbyU+EmlhMcHuGsrWsyqgM3Vj8ahIzbvCYYTz13o2Qtsu/
eDOi6xX8caMe9wHNftv4I3HbGUKlXhGKo73Wf8EQRiGZ8wOi6aE0jABphaNqIVJ5
eCUQ77v5wNSV+8k5IG3V+h8bVwEUShRZbuNQbLLZ6z5oxRPYGSzF+xEVMgQj1ipt
K22AiFQjtENETTR299XY/RZ5Uuy/F+64irr46MsDU8m804rjDLNZyAXP3/Ak5XrX
bsZDf+wExuAcXk7hvTlJngUWcOFgFi6z+o3C8PEDMerZQAbSCeS5M5IrcI61qled
PEUI+WuMtrXV+/nfsp18aEF+aMcLoHS0TxDmzoWgKy6ichYbHYKgbzghW29Yy1fc
J7+EaHZuKgkXk/4gedL2dj1HXmIJD/WaBhVOjcW+QkDJzx2/Mgx/0uMbOaJBiUH8
OI+viF8nWNibwKvYVAkH
=BJQl
-----END PGP SIGNATURE-----

--0iexB5Bk8cF8G6DP--
