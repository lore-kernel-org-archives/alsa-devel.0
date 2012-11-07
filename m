From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 10:04:16 +0100
Message-ID: <20121107090416.GD12323@opensource.wolfsonmicro.com>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107082419.GB12323@opensource.wolfsonmicro.com>
 <20121107084733.GD20063@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121107084733.GD20063@game.jcrosoft.org>
Sender: linux-sound-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Bo Shen <voice.shen@atmel.com>, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 09:47:33AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> Mark I nack the patch series this patch series does not run on any DT kernel

> as no picntrl is done

> do not apply until this patfh handle the pinctrl

Nicholas seemed to be disagreeing you on that one and his observation
that it won't be an issue until v3.8 anyway seemed totally reasonable.
In any case it doesn't seems like it'll be an issue to get it resolved
before it actually gets merged down to become an issue.

Of course there's also some ongoing discussion on the question of having
to add mindless pinctrl_get_set_default() to all the drivers at all, the
fact that we're having to do that at all seems like a failure to me at
least.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmiQKAAoJELSic+t+oim9+p8P/j9oXunGHxezMTom2f+8+NVp
W17kDEzi+gmML/TFKnXVlZMKXjGfGTf/0Ha1LSuxDRmWFk3bZy07lQc63RirSt/j
ml9xRfYZcN8qzDbdCTLzgYFAYL46OzIBTSWtcLsFki1OfjMTjtSYVOv9A89PxM3V
8PfVmfFmFv66unnXQcmWn85uS8Msad8Kf6oy4fj3IbAB831ozbatI+TQ5v/+3QKX
beHenfwyThGj2uMAm2L6O4CqhVsmy4eEwgPDh8wdwG//KoN9KgoYYXfjfAo2bKcx
E2ub3hHjs+Zl2GqoeIsqjNtwX3P8UNDHH9v1DLm/PpZZG9GktnH87PbUAOHwbXBp
rgf5092uvF622QTdULHaNHyD7sHNN7EArVvyi2H3zbhXhqiKkegku26tFf/bFGd/
8XaktNXSr1eQ9j4QYQ8UPuYd8ixtrhqfyh1qh6pNrz8HBMq3Enq91AxQAtR4P2lS
LCSiWiJfmDfNSw9IJ2BJN6Ig/NrURB022ekntziYYvEuRK6+ecvuHcEbkfK5bBgV
ahEAY36P02sXQjD/clOVb223NZ8cnQLnQLgFN15dduseFBrMfc5HI0UKOV5TNC6o
xIwnJgBAF+4N2TGyCs92trLzki80yhT3Ej1D+d3J2jwbfR/ZUu7UHpL3DOwtB9l5
revcZyNL3q/dP4r82yhB
=Kxm8
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
