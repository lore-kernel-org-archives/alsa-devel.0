From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmic codec: Support for DT
Date: Tue, 15 May 2012 22:39:48 +0100
Message-ID: <20120515213947.GB4069@opensource.wolfsonmicro.com>
References: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508125837.GN15893@opensource.wolfsonmicro.com>
	<4FB241A3.3020104@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320033859346308906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CB24104394
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 23:39:52 +0200 (CEST)
In-Reply-To: <4FB241A3.3020104@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0320033859346308906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2012 at 02:44:35PM +0300, Peter Ujfalusi wrote:

> I don't think that we would need platform devices for most of the
> passive components you have listed.

I don't think we do either, but I think we should handle DMICs in a
similar way - we probably want to be able to get to a place where basic
devices that don't need complex clocking arrangements can be described
with the device tree in a generic, cross-device manner.  I think that's
going to mean that we need to be able to enumerate things like which
pins on the CODEC are actually in use and where the headset is which is
going to need at least some level of description of these passives.

For internal Linux purposes we might want to do something noticeably
different with the different devices but that is an orthogonal issue to
representing the hardware in a suitably abstract format.  I would be a
bit worried if a DMIC interface was substantially different to an AMIC
interface in DT since in terms of how they interface it's really not
that big a difference.

> AFAIK (Liam can correct me if I'm wrong) the reason that we have this
> (dmic codec) is to be able to use the OMAP4+ DMIC in a card.

Oh, I understand why it's there but this is more of a Linux internal
implementation issue than anything else.

> Not entirely sure if we will need to have dts section for the dmic, I
> can just create the platform device in the abe-twl6040 machine driver if
> the setup includes digital microphones.

That's another option and certainly seems like a good stopgap when we're
currently doing the same thing for analogue interfaces - I'm much more
comfortable with adding stuff later than with putting something that
I've got concerns about in.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPss0aAAoJEBus8iNuMP3dszEP/A7bSIsUFDl9+OX3RYrW3HSe
tQShOYDKSUKnRV+12RiYzub7JdVmD3ydPcs+7Y/Zcm+oBp1FlFUcsEQeTB4q71NV
E9yoR3Wpet/BmK4TX3PCbkKTu4MqCUlVWu03CXiwUCoxzhBRCVwSHeDH99DaclOi
vt38QFdqcf5U25R7RFSC9ak5OQ606jL/aDNBDKviEY5hcCOttLkQ52Xc/Ez33pJz
LJXB6HinfLi1A8ZAgTY5xKQbehYjjBFwCT+3IDdL1Y8xGiWWOPeIIcwuCwDNqK5T
aCwQePhE77J0qPQLUrCAQO1kcID9Q5n9nEKE6MSMfC1Eg7qWMvmMDNMIWj9gwK8p
gnHyp9bxMo9joo8jI5F8eze1u0IYcpYzZiXMOA3Ocr6RgO4DYTS/ukf+7xriJjzR
voVarm5IfVEXm4P5GWbeOEJRbGTu0VL/vJbCdje+bDq/vWARg6ydjlpycmR74p7P
IiAUWbsZ2TgwUXURXjxmTqOxVFyc6voyDMXgWErWrw9nJxAag04P5MWA/3omSnzb
ApRnCjDhhu7dt4z4LQNF8Hyl6YyqApUBTWFx+2M4OjRz8cTdJ4rKidhIgia5+fVI
qu1r1V7gLlUviDfb2GjL+BSDDIzESNEOPgIhbOGQDGwTHA3bkf8+SjgJ1G91dQzZ
e/yyXyvRln3AZ8gebsf2
=0zog
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--===============0320033859346308906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0320033859346308906==--
