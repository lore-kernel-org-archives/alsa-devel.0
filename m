From: Jiri Slaby <slaby@liberouter.org>
Subject: Re: [PATCH] cs5536 ID for cs5535audio
Date: Wed, 14 Dec 2005 23:01:11 +0100
Message-ID: <43A09627.60106@liberouter.org>
References: <200512141431.32685.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965009AbVLNWBk@vger.kernel.org>
In-Reply-To: <200512141431.32685.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Ren=C3=A9 Rebe napsal(a):
> Hi all,
>=20
> relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:
>=20
> Added AMD CS5536 to the cs5535audio driver.
>=20
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactcode.de>
>=20
> --- sound/pci/cs5535audio/cs5535audio.c.orig	2005-12-14 14:39:11.0000=
00000 +0100
> +++ sound/pci/cs5535audio/cs5535audio.c	2005-12-14 14:29:23.000000000=
 +0100
> @@ -46,8 +46,10 @@
>  static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
> =20
>  static struct pci_device_id snd_cs5535audio_ids[] =3D {
> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> -		PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
Seems like a PCI_DEVICE() candidate

regards,
--=20
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
