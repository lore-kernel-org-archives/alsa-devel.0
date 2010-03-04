From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: no audio output with TYAN S7025 motherboard and
 Realtek ALC262
Date: Thu, 04 Mar 2010 10:15:59 +0100
Message-ID: <1267694159.9133.7.camel@mattotaupa>
References: <20100303185454.4D36231781@vis06.nas.nasa.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5762182442976140380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 559641039B9
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 10:16:06 +0100 (CET)
Received: from f053034008.adsl.alicedsl.de ([78.53.34.8] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Nn7A4-0002SB-Vi
	for alsa-devel@alsa-project.org; Thu, 04 Mar 2010 09:16:05 +0000
In-Reply-To: <20100303185454.4D36231781@vis06.nas.nasa.gov>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5762182442976140380==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-0Sumt0dQPvBMCmGXieb+"


--=-0Sumt0dQPvBMCmGXieb+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Bryan,


Am Mittwoch, den 03.03.2010, 10:54 -0800 schrieb Bryan Green:
> I have several systems with a TYAN S7025 motherboard and Realtek ALC262 c=
hipset.
> I have not been able to produce any audio output.  Well, that is except f=
or
> one of the systems: after a variety of tweeks and tests, I got sound work=
ing
> on one system, but I do not know what change enabled sound to start worki=
ng,
> and I have not been able to reproduce the effect on the other systems.

Can you give list of what tweeks you did (even incomplete).

> I have tested with kernels up to 2.6.33, and with ALSA version 1.0.22.1.
> For a non-working system, 'alsaconf' gives the following output:
> Unknown hardware: "HDA-Intel" "Realtek ALC262"
> "HDA:10ec0262,10ec0262,00100202" "0x8086" "0x3a3e"
>=20
> And dmesg gives the following:
> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> HDA Intel 0000:00:1b.0: irq 89 for MSI/MSI-X
> HDA Intel 0000:00:1b.0: setting latency timer to 64
> hda_codec: ALC262: BIOS auto-probing.
> autoconfig: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
>    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
>    hp_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
>    mono: mono_out=3D0x0
>    dig-out=3D0x1e/0x0
>    inputs: mic=3D0x18, fmic=3D0x19, line=3D0x1a, fline=3D0x0, cd=3D0x1c, =
aux=3D0x0
>    dig-in=3D0x1f
> realtek: No valid SSID, checking pincfg 0x411111f0 for NID 0x1d
> realtek: Enable default setup for auto mode as fallback
> input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input=
8
>=20
> For the working system, the dmesg output is the same except for two lines=
:
> autoconfig: line_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
>    inputs: mic=3D0x18, fmic=3D0x19, line=3D0x1a, fline=3D0x0, cd=3D0x1c, =
aux=3D0x14
>=20
> Is there a method for tweaking these values on the non-working system to =
match
> the working system, to see if that works?

Have you tried different values for the model parameter [1]? If I am not
mistaken you can use HDA-Analyzer [2] to change such values. But I never
used it myself.

> I've uploaded the alsa-info output from a non-working system here:
> http://www.alsa-project.org/db/?f=3D91057bfc12790688f1d257743e53d5d0ec2ce=
1e2
>=20
> I've uploaded the alsa-info output from the working system here:
> http://www.alsa-project.org/db/?f=3D198420f14cd0062713636408640636e6d474c=
f94


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA#.27model=
.27_parameter
[2] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA#Try_a_lo=
wlevel_GUI_tool_to_control_your_codec

--=-0Sumt0dQPvBMCmGXieb+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuPekkACgkQPX1aK2wOHVhI9gCeLP2swcNEMWCM2ZWbu+vP7i3Y
VmcAn3sBCKYRciUJv7lc1ZlRlB3+a1iG
=Z04C
-----END PGP SIGNATURE-----

--=-0Sumt0dQPvBMCmGXieb+--


--===============5762182442976140380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5762182442976140380==--
