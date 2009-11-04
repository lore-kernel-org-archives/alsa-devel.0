From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH] alsa: echoaudio - pci id cleanup
Date: Wed, 04 Nov 2009 10:07:52 +0100
Message-ID: <4AF14468.7010006@klingt.org>
References: <4AD992E7.9020203@klingt.org> <s5h8wemzog1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5280685250040715679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 093A710386D
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 10:07:57 +0100 (CET)
In-Reply-To: <s5h8wemzog1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5280685250040715679==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27F0B22E5A340C4FB00A30A1"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27F0B22E5A340C4FB00A30A1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/04/2009 09:25 AM, Takashi Iwai wrote:
> At Sat, 17 Oct 2009 11:48:23 +0200,
> Tim Blechmann wrote:
>>
>> using the PCI_VENDOR_ID_MOTOROLA definition instead of the value 0x105=
7
>> makes code a bit cleaner.
>>
>> Signed-off-by: Tim Blechmann <tim@klingt.org>
>=20
> Well, I'm not always fond of this.  The only merit is that you can avoi=
d
> a typo.  But, if you look for a device from the source code from lspci,=

> this kind of change makes it hard.

it helps, if this device is referred to by PCI_VENDOR_ID_MOTOROLA
instead of 0x1057, as it is done somewhere in the cardbus code ...

but since it is a rather cosmetic fix, feel free to drop the patch ...

tim

--=20
tim@klingt.org
http://tim.klingt.org

You don't have to call it music if the term shocks you.
  John Cage


--------------enig27F0B22E5A340C4FB00A30A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrxRGsACgkQdL+4qsZfVsuYPgCff+2+cGUrt+I3UTaDr//dmWOj
bc0AoJZiRtjJ4Vblt7+NqAUM+il8HYMp
=XXl/
-----END PGP SIGNATURE-----

--------------enig27F0B22E5A340C4FB00A30A1--

--===============5280685250040715679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5280685250040715679==--
