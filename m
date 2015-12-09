From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: next-20151208 - CONFIG_SND_HDA_I915
Date: Tue, 08 Dec 2015 22:46:38 -0500
Message-ID: <8943.1449632798@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1449632798_5901P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1449632798_5901P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <8918.1449632787.1@turing-police.cc.vt.edu>
Content-Transfer-Encoding: quoted-printable

I'm experiencing a spot of trouble with this commit:

commit aad730d0704545ad97654bd929b0aba05adb1436
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Dec 2 13:33:57 2013 +0100

    ALSA: hda - Always do delayed probes for HD-audio devices

That adds some code:

#ifndef CONFIG_SND_HDA_I915
	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
		dev_err(card->dev, "Haswell must build in CONFIG_SND_HDA_I915\n");

"Oh, bother" -- Winnie the Pooh

So I go looking how to fix this, and 'make menuconfig' tells me:

Symbol: SND_HDA_I915 [=3Dn]                                               =
                                              x  =

  x Type  : boolean                                                       =
                                                x  =

  x   Defined at sound/hda/Kconfig:8                                      =
                                                x  =

  x   Depends on: SOUND [=3Dy] && !M68K && !UML && SND [=3Dy] && DRM_I915 =
[=3Dn] && SND_HDA_CORE [=3Dy]

And why is DRM_I915=3Dn?

# lspci | grep NV
01:00.0 VGA compatible controller: NVIDIA Corporation GF108GLM [NVS 5200M]=
 (rev a1)

Because this Dell laptop has NVidia graphics onboard, and no sign of I915
graphics that needs I915 DRM.

I think the infrastructure that you're trying to re-use from DRM_I915 need=
s
to be moved to another symbol which can be SELECT/DEPEND by both DRM_I915
and SND_HSA_I915.

Comments/suggestions?

--==_Exmh_1449632798_5901P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVmekHQdmEQWDXROgAQJO0A//UCbjkLDt9fcHlJgcR3VN5Em7X6gzMlAc
Saq78vyPWnn754FUnM51l7VHtTtkfR6EVTptwtaUJRGAclQsHNF8M27IwP/CEGPZ
CgktpSf6km5f1Hyp19E47F8Env68+AjkdV8Dm61LvL8D7CxdFIsGY4wE7khDpGWw
nJGzyq8iFC8NYHjK1BqzyTvCHdmJQfbfSyi9cJcaXygdXhALapl8jB+IxhxPXAxB
x9Q8YuK6rfRADg/dPITC3yRs6SBdewmOYFWZLocA2J4BLewH/KNAd6mCmxXaL9O0
szp7inBd4/MZiuxV9SvfwlwSAf2PfzGB33wYqtExrkc//6z/T/IkS4ltX07Di+F7
OGgUwQ99va1q3MoHVQ6sCAblf4r/43XWqe7TRjme/n7pnCBKw7bHy1hCWYSI/MOe
Rz95q5RPp8KnWt3AqhMe0lQt5k9qZJMuW86DdCyStH/z2+GFjcT6v/EVjrGaltca
Lh/+GrfxfZtBEe3W75YTNNo/3pV561OvwcCNqybZHUdD5MbN5Ow4O9J4joxBfFO0
wc1K5Vs51JzbY2zU9Z6E/YnMYDnSKhuL/vhVh72Hss7uu09CJes4OSi2k5H/P/D/
RYG1g+qEgRGYhlpxxsIDmmOEIXuDdiBNujI//alQzjJtGAoemXifhAd5RPy8ACoq
Kt7SlGLMjlA=
=sOzt
-----END PGP SIGNATURE-----

--==_Exmh_1449632798_5901P--
