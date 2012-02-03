From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 3 Feb 2012 13:55:45 +0000
Message-ID: <20120203135544.GP3151@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
	<20120202231427.GG3112@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
	<20120203132504.GK3151@opensource.wolfsonmicro.com>
	<4F2BE22A.7070006@nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3492112872564280508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B596A10B8A1
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 14:55:47 +0100 (CET)
In-Reply-To: <4F2BE22A.7070006@nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: M R Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3492112872564280508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Content-Disposition: inline


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 07:03:30PM +0530, M R Swami Reddy wrote:
> Mark Brown wrote:
> >On Fri, Feb 03, 2012 at 04:19:00AM -0800, Reddy, MR Swami wrote:

> >>Setting CHIP_EN bit as '0'. In the _STANDBY mode, CHIP_EN bit setting
> >>not needed and will remove in the next patch.

> >This also sounds broken, as I repeatedly said when reviewing previous
> >versions of the driver if disabling the chip does anything at all then
> >why don't you need to reenable the chip later?

> OK. I will remove chip disable code in case if _STANDBY and _OFF modes.

So the chip disable does nothing?  There's nothing wrong with disabling
the chip when it goes to idle, it's just that one would expect that
something ought to then reenable it when the device is needed again.

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK+daAAoJEBus8iNuMP3dpuMP/RXt4LIwVQxVIy8QzFOxACAg
ZmuYduy8eIXw6LufMAV2eE9GpXFtVUWlNQV/eREHduKViuQIyMPtwks/UqXhgWF5
dORnxHnnIHkDDsXwrNqHfs9He7y1g9OAEqQ0R3mm0CrLdltjsJT8P3eNvOXqtNLx
LOhsavovu0YcRnwvWcm9srfNFqB/R/aVqXTjdtm38zExfpRTbm+DV41b74Bt/Idk
z0oTwv04F4G9RryzxJqccuPCPAKRbz2yB7aonr0LM4HMqdN9MaKwPm1lPN8atzHn
OeQ3245v2gKxVGjKzdtlBGE9foXHgkINZBp2CHGEc5jtRabZOoTYiunczPlHWefq
k1ig9gb6XqMqkHcjDmSm1AnFQwOM5CDPPmZPoC8xDArCQ4aUu9FGXX1LzMp9rn9r
mPejM+ePbV82zx+Nm47hUQWp72KnogrHgQ4usN6qs2+vrhqCHf0jqScFpDIHNFf4
BTeY07cInJZEYCiCPox4djUmss7bItxYksRwhplkPyEHvQ2h57fqfdtSVM4RNBce
BQlIeV2ziT5Ypg1ak/gUEBvdG28cpPsKs5ZjSzOmYvRUu5YIJpbjaHYPVDkSNB19
Wg7pWf3VeKpNnu625OWf0rF3Ajg+3lgyiffgIEQLhmRX9/ZwB7Zfi31+w5KPrKFP
wPwRLTNMTRCah17vKcip
=Kp1r
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--

--===============3492112872564280508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3492112872564280508==--
