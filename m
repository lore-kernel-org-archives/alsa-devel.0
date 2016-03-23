From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Reset codec based on
	sample rate changes
Date: Wed, 23 Mar 2016 14:37:10 +0100
Message-ID: <56F29C06.3090004@metafoo.de>
References: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
 <20160323124849.GL2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5435052255220096334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 05F2B2667F3
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 14:37:36 +0100 (CET)
In-Reply-To: <20160323124849.GL2566@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5435052255220096334==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oxbF86Ft6jwWvJAhTVTcUoR3X7oSjMUv3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oxbF86Ft6jwWvJAhTVTcUoR3X7oSjMUv3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/23/2016 01:48 PM, Mark Brown wrote:
> On Wed, Mar 23, 2016 at 12:58:23PM +0100, pascal.huerst@gmail.com wrote=
:
>=20
>> Instead of checking if mclk/lrclk ratio has changed, check if
>> sample rate has changed. In certain cases, the mclk might be
>> changed in the machine driver, which can lead to the same
>> mclk/lrclk ration, eventhow the sample rate has changed.
>=20
>> Since the codec has to be programmed differently for every
>> sample rate, its better to check for samplerate changes instead
>> of mclk/lrclk ration changes.
>=20
> Why does this mean we have to reset the CODEC rather than just
> reprogramming it?

Quoting from the datasheet:

	The clock mode should not be changed without also resetting
	the ADAU1701. If the mode is changed during operation, a
	click or pop can result in the output signals. The state of the
	PLL_MODEx pins should be changed while RESET is held low.

- Lars


--oxbF86Ft6jwWvJAhTVTcUoR3X7oSjMUv3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8pwRAAoJEOj3aLScRbOZPJAP/07tV5dbRrQ5OIj29oqg9GjG
wOio6lskBTgtpmDjLqgFz1vXoYtYqrpwrr0v2tL+SqjG643kZ9iWVwVg5Ks9XC2g
AfrtZnJcQRd64/s3MoUHzCmczmVJOQT3iOABUQxqgYrZ5ZVABsJN9L0aNN7HC8rK
q9wMEWUHu04/CX8jInK4+h5VUc2KFKbFMWu90zUhnmLms1KfqbK3ojqIxnpMAlmd
E6x5cUSusoeuCp7b2OdSbHnNJISOtyOvNUC4XCh16nZmfN7cnnsZMELH9vmSYON8
h0q2kzOSdueEAeFtmn0rNFbp91ZC6XTuT9oSAVe1l+A0ypVbIOYTEAVTXHQmDY0s
fCDISFoDUGN5GjwxNXxh/PjMpOqZ219VWOyj4vIuKRBn6wRcnZ1u6PdMET22cAVO
HV9BL1CORfTdLYTaJJdsvFlmoY2PGxdy4B4rfEwAAZl2fXo5cIlgI4lAfiHHKhE6
PXoMWsO9Wl64Uo1ENxkalc3BNA/stY+h1uWawqEQkd45KtHM+Eqom0eHoM3O7K85
CpNj39Z4tTxnGQoVcBo3OU0L+z153vT/WtEZt5Y41V7+JE7Vn8ZTpbH28ybVrjUI
D40s5O5hx9OSF638lRmVCaupUKPLhm+7DFZox62/wMWpJu7aVLq4gPsrEklX66s4
noGenAR4UuywwboqseRC
=ttNU
-----END PGP SIGNATURE-----

--oxbF86Ft6jwWvJAhTVTcUoR3X7oSjMUv3--

--===============5435052255220096334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5435052255220096334==--
