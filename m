From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/17] ASoC: ux500: Use generic dmaengine
	PCM
Date: Thu, 18 Apr 2013 15:05:41 +0100
Message-ID: <20130418140541.GH13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-18-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3008928416776290488=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AA5B264F19
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 16:05:44 +0200 (CEST)
In-Reply-To: <1366046404-8759-18-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============3008928416776290488==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tQHaQFR6K/xpRpl8"
Content-Disposition: inline


--tQHaQFR6K/xpRpl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:20:04PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implemention.  There is
> a minor functional change, the ux500 PCM driver did not preallocate the audio
> buffer, while the generic dmaengine PCM driver will do this.

Applied, thanks.

--tQHaQFR6K/xpRpl8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRb/2gAAoJELSic+t+oim97BcP/jrk2zC/olaTrXw9qSSjpm7B
cFvLF85j4QXxdTlyPa4oVE5bRkVXGureTssSTac6S0XplgrgsnnPuFaX7yYE1Pn4
/iuayMKz8MmoQS7U3HM3P1pc2cL1dUO8Ekz2MJa0ofiSiDvgTE0q8m3MV8Gm8nR5
gP+aMptJFeMybk7ELDkKSY51RfteiuB6MhhRl8a4D2L+K0XGttaS8W12y3wTctF1
OV/gjnCDk7nRazW2aPk1snc1eoj9Y6atToQOAxg41EPaeT+NjvKyVAxPYw6YcKg5
ZETxTrQjXc/L8FKNCA2zoOKU+JvOPO9Gf1AcqpeSB+GJckocVR1wQiI26s4xwFaF
vFdY1ilDd8qGTl9SDh12BoEBQOvBPMAnnZBP9scVITkU3Or/c6IJKEoT5TFRuh/F
21Po2QdtDoAFxF3ttluDxeb6yjNXuaezCx4wzkdX4ysqvDg8QDVYZfzOT4up3acm
DjHLRWE9RIxfM05Rfu4NiZBxQfEIooyx3SCyYkfA91dLUkNvAvtv4P0Hutg4Uyz9
Zxjh28scxgmcC5rU78JShXlyR8Nax+6JilMPPiiESEbXoy3ActrSOuOIQyJk2MdU
uswXiFdQpMP8CZm2tXGhkxHfI8DCc8GwcmD+/mpwy9h1K16D+5/2Su0DLiUwC/B7
nxE/GsvhMBDiD0udPh6T
=nqt+
-----END PGP SIGNATURE-----

--tQHaQFR6K/xpRpl8--

--===============3008928416776290488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3008928416776290488==--
