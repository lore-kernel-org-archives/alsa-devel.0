From: Emmanuel Kasper <emmanuel@libera.cc>
Subject: Re: Vendor support in Alsa Drivers
Date: Thu, 12 Jun 2008 09:51:33 +0200
Message-ID: <4850D585.8000007@libera.cc>
References: <484E4E24.1060509@libera.cc> <s5h4p802ahz.wl%tiwai@suse.de>
	<4850CE12.9080908@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4584763817325025720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-05.sil.at (smtp-05.sil.at [78.142.186.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E278A1037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 09:51:39 +0200 (CEST)
In-Reply-To: <4850CE12.9080908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4584763817325025720==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig656676A678F9A225018E0B7A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig656676A678F9A225018E0B7A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Clemens Ladisch a =E9crit :
>> Emmanuel Kasper wrote:
>>> We will reference only devices which work with a free driver, so no
>>> nvidia binary thingie or atheros HAL.  Based on the information
>>> found on the alsa wiki we plan to reference the following sound
>>> devices:
>>>
>>> M-Audio Audiophile 24/96 (  snd-ice1712 driver )
>>> Terratec AUREON 5.1
>>> M-Audio Fast Track usb
>>> Hercules Muse Pocket LT
>>> Ion TTUSB usb turnable ( these 4 working with snd-usb-driver )
>=20
> Why only those?  All drivers in the ALSA tree are free.

Well right, now we rather try to find for each different consummer
scenario one or two working card ( like one 5.1 usb, one entry level 4
channels, one professional PCI card, possibly one USB speaker set )
We are not aiming at exhaustivity, we simply don't have the ressources.
It has also to be availaible new in the market and if possible also
working with FreeBSD.

> Takashi Iwai wrote:
>> I don't know about Ion.  Possibly Clemens had any contact?
>=20
> No, all my drivers have been written with already-public datasheets or
> using reverse engineering.
>=20
>=20
> Regards,
> Clemens
>=20

lg.
--=20
Emmanuel Kasper
System Administrator
www.libera.cc
Find, compare, buy Linux & FreeBSD compatible hardware


--------------enig656676A678F9A225018E0B7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIUNWKwfhkdwZoef4RAtC3AJ4r2HvqJs3Y6+k0vl2FSAI2N6vuzQCfSHAR
GLM+FS9Z22YqoBrBFJY8FS0=
=Wohy
-----END PGP SIGNATURE-----

--------------enig656676A678F9A225018E0B7A--

--===============4584763817325025720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4584763817325025720==--
