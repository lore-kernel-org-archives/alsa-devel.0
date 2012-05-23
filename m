From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 23 May 2012 18:40:09 +0100
Message-ID: <20120523174009.GE4064@opensource.wolfsonmicro.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
	<4FBC8C11.6020602@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3270093464589817351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A77D2243F4
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 19:40:12 +0200 (CEST)
In-Reply-To: <4FBC8C11.6020602@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3270093464589817351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2012 at 09:04:49AM +0200, Ola Lilja wrote:
> On 05/08/2012 08:27 PM, Mark Brown wrote:

> >> +	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
> >> +		soc_enum_envdeththre),
> >> +	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
> >> +		soc_enum_envdetlthre),
> >> +	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
> >> +	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
> >> +		soc_enum_envdettime),

> > Again, why is this all exposed to userspace?

> These one we need as ALSA-controls. They are parameters that we can tune during
> runtime and are not hard-wired in any way.

This seems incredibly surprising - are you sure the configuration isn't
simply a case of enabling and disabling the charge pump voltage scaling?

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPvSDxAAoJEBus8iNuMP3daAsP/R7QmD+CUuLWM8dgXHjJMv/K
Q9taNlP4gHJmqN63muljO6Lsk2wWH7mMkSI69E8q7yx5xc7xPvBdtmxK2FV7IOkr
rbryknSAkklJTLyEIIOHWRdOVryNjWYkbmPlAzSPvcSFB18AhLCLDN9R0sKuKo/E
GTFkU0/JJlO1OxcLw9dCHiuN/0t6Ejfqu8BoE718OTlHSZDPi8xYg/jsv/6euUxi
4JJaT7EMonp9kTf0Fdjre6yMSLzFypxWp2aoLzJom0aJKhd3ZTUJofjRm4oEcT/+
6Qpf1ZtkXzkHJ8dvaOmgKv8kHpz4lqBZMOa4CSAM76qEIUADqqcb6bPHOFRkDLX/
DQSfj1HPj70gMmR3QSFJZPALGj/4JakTkvlFO20QUk9frgcLMCpppexzoV1vLQlQ
BXLXx47F1pyZVtDCUktEpuUWV8Q4XBoRRF39SsEJO1UK92HuyvSprZU1xsJUugUO
QKnLWC+iVRtF6qjqt8MI+guHh6WiGQ2NHEv70/Pb0j3FvWx3MS84pCZ+aWtkFd5W
eo5IEUvZjIwNiLsyOkrKfbOi5Wizn0S0lfaGtQtAfOmR0UJXGQKB3ehHo3/fMwB1
gq4u8qaD+vvsS94WTCrtGauiJtd/QWIxdI+nAv6sQzzN4zWQc26pZOV/hVg2NnJ+
SM5isBV8ikZ201rIlZgo
=pInb
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--

--===============3270093464589817351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3270093464589817351==--
