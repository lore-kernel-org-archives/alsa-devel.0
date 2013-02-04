From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: imx: audmux: add a integrated
 configuration function
Date: Mon, 4 Feb 2013 10:01:49 +0000
Message-ID: <20130204100148.GB4720@opensource.wolfsonmicro.com>
References: <1359614566-4660-1-git-send-email-b13634@freescale.com>
 <20130131142243.GE2735@S2101-09.ap.freescale.net>
 <20130131163517.GC13321@opensource.wolfsonmicro.com>
 <20130201131007.GA23922@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3730102840693213119=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C22F526163C
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 11:07:55 +0100 (CET)
In-Reply-To: <20130201131007.GA23922@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Gary Zhang <b13634@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3730102840693213119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2013 at 09:10:09PM +0800, Shawn Guo wrote:

> imx-sgtl5000 and imx-wm8960 driver.  I'm asking if you can merge Gary's
> the patch with leaving audmux setup as it is, and let me consolidate
> the common part between imx-sgtl5000 and imx-wm8960 with a follow-up
> patch.

Well, there were a bunch of other issues with the driver that I was
looking to see addressed.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD4cGAAoJELSic+t+oim93d8P/1PPkyyghI2xSasZE/SAF2TV
s76DK7MEPnSoa3g6eKup3RDXwzcmWq8ADXC0OE+EVNMCXRsnghuQ+JPF2dbfACbt
szcIddEEFJGNMsNx9TT8E9YLaM9nNQ3KC51s4n9yy5tv48ASBwB7JyyjXb3y2YH3
iiF7BnIHkLO4IUQNF/tCIWrtMglks5aunysTdS6ouESJ6jpq7gcBUVyNWRxawAA/
xL4ME1TiL7agSfQOJTMbnFlljc2NbpaHVQXVgiqKqzCfZn4GfOh4mL6DD1nr0DeT
yclZgvzOnW33+NBNjiOj0QyZrn19Ld90RQleU4hQEsGflbFjkaz9VihM9xp9xAHL
RLqE4IyrFalxbSP5VODyT0m+QRu7AD1AOOHk/Lpol9Zad1WB/B0aZ5rZXqJAOWTt
IiRev2Xr1Oqz4MDhNoNik1s6/QyaJRN9Ul/dZNVmRXcmb9y4Ui/DWRdegf1M4n+Z
u57oz0F+KVRFM2ZZ7qK0FsEHHacus4JfesYKry+yw0EN4keUa71yaJelr9wJ8MOc
Qs7/ziOoDcyOtkvklwlBNqriNb9iTYqJXXF8mnJXr3PfEqEB0CZunG5+K4L+pStU
PoR6v6U18mH0A7MY1SjywbpsppFpTpUt+kIjB+Ki2BYodEYbrGFVRu86Sfm/P+au
2c17HzzCPMot/R+ki5Ft
=v836
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============3730102840693213119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3730102840693213119==--
