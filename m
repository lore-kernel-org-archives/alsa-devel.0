From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Fri, 11 May 2012 14:08:16 +0100
Message-ID: <20120511130816.GB3960@opensource.wolfsonmicro.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8370764351442111704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D34C1243D4
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 15:08:18 +0200 (CEST)
In-Reply-To: <4FACF1C2.7050008@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8370764351442111704==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2012 at 01:02:26PM +0200, Cousson, Benoit wrote:
> On 5/9/2012 3:35 PM, Mark Brown wrote:

> >Clearly.  This is all very circular.  Obviously if you're intent on
> >using a phandle specific to the MFD child then you need to have that in
> >the device tree but this is because you're making the child devices
> >externally visible...  Clearly if we're not going to use the MFD
> >subdevices in the DT then the links ought to reference the chip.

> I'm not sure to understand you concern here.

> Describing sub nodes, especially for big SoC is pretty useful.
> It is as useful as doing that for board that are sharing similar componen=
ts.

The concern here is that the device tree you're writing here is clearly
just a direct translation of the particular stuff Linux happens to use
internally into device tree; this is similar to the thing with using
hwmod in the device tree representation and omitting basic stuff like
the register ranges.

> It will allow to define several Audio / PMIC variants without having
> to rewrite a driver potentially.

This binding doesn't do anything to move towards that goal given that
the only information it includes about the contents of the chip is the=20
name.  Writing the name out in separate CODEC and vibra nodes really
isn't going to accomplish much to promote reuse that can't trivially be
achieved by parsing the name in the MFD driver.

If the binding were doing things like describing the internals of the
device in a way that meant the driver didn't need to know that this was
a twl6040 in particular this sort of thinking is useful but the binding
we have here just isn't doing that at all.

> Both Vibra and Codec IPs can be located elsewhere, so by exposing
> that inside the DT, you will increase the level of HW details and
> thus make the re-use of these sub-IPs easier.

Especially for the CODEC it's not really an IP in itself, it's an
assembly of large numbers of other IPs - digital audio interfaces,
analogue amps and whatnot.  Like I say if the device tree described
this assembly it'd be different but it's really not doing that.

> Moreover, the fact the Linux implementation uses MFD to represent
> that is irrelevant for the DT description. We should be able to use
> whatever SW representation for this type of HW.

This is precisely my point, what we're being presented with here is a
device tree description of the particular way that Linux wants to
understand this stuff rather than something that lets us learn about the
chip internals.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrQ85AAoJEBus8iNuMP3dCQoP/iQVo3WFCBlQzOm9YYenXKdB
c9r5UJ5My3eulOvKJN2BpjbilposCdahGx0Z+yoBmx6N5Sd/AvK8YhdUvdhGo61r
+ybA91IsFpABMoc9vyKOpkKG0FHRt/CUIWmqYx/LisUMdPCdVe+g/pvU3ajxyQYI
8TUZHxFOxGuG+tl3PS7aT0+3T5mDUMNSdC0VblLgSvVRnnUo6BHxU5rYMALwwXal
rtI2LbKYFnsWZerWBeRtPkFKg/Ak3GHkn+M7sk/8ZgSHpwsNCwqC/Oc09LURW4so
txS3HlNcpVRUnohUWNEdF1Kbhaax2Aqsl/cG90TgzCHUHCbI2FpV/SaVmhQQ5D6f
KNEnwvFpwiUBRHLkAf45o6Hl8tTWXfqfkexr6Od0yzQAu1nOZXhdrJfOrUZpTIe/
/sAXw8BYPk6odWmZljRFitXv18jZDy0BHwpyOp4CCYJwaNdV8TNZosmOocodoeLC
ONRWcUlDKm7CuZkWw42tFuMSeUSms+PqAfd5aU441acjHi790WgqFBi3x+n11wF4
Ju7B+g4+nBl5rvcR3IEr+2alJU9cVLngzgSK2FvOa8FYMm/dQ889sfys/EaeH5YF
CDVBFdqVtjYAPOpBztCtGClmteNvsi1iOCt0BZxIQaLQa+fEcZQP6QGqPAL368c7
dCbGQ/vgTOXH1LtUn4he
=CFnr
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--===============8370764351442111704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8370764351442111704==--
