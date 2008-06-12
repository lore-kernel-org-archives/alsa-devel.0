From: Emmanuel Kasper <emmanuel@libera.cc>
Subject: Re: Vendor support in Alsa Drivers
Date: Thu, 12 Jun 2008 09:41:36 +0200
Message-ID: <4850D330.8070509@libera.cc>
References: <484E4E24.1060509@libera.cc> <s5h4p802ahz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0604372363709068494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-01.sil.at (smtp-01.sil.at [78.142.186.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 0011F1037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 09:41:46 +0200 (CEST)
In-Reply-To: <s5h4p802ahz.wl%tiwai@suse.de>
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
--===============0604372363709068494==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig23961FE5411A3A4F832425A0"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23961FE5411A3A4F832425A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai a =E9crit :
> At Tue, 10 Jun 2008 11:49:24 +0200,
> Emmanuel Kasper wrote:
>> Hello
>> With a couple of other french folks, we are building a kind of webshop=

>> for Linux/FreeBSD compatible hardware. We will reference only devices
>> which work with a free driver, so no nvidia binary thingie or atheros
HAL.
>> Based on the information found  on  the alsa wiki we plan to reference=

>> the following sound devices:
>>
>> M-Audio Audiophile 24/96 (  snd-ice1712 driver )
>> Terratec AUREON 5.1
>> M-Audio Fast Track usb
>> Hercules Muse Pocket LT
>> Ion TTUSB usb turnable ( these 4 working with snd-usb-driver )
>>
>> We would be also interested to indicate on each product description, i=
f
>> the vendor of the product, or the chipset maker for that matters had
>> been helpful with developers trying to write a free driver. So for the=

>> devices mentionned above, was any of the vendor helpful by providing
>> programming documentation or sample hardware ?
>
> We have a good contact with M-Audio.  The above two devices were
> provided once for testing by M-Audio indeed.
>
> The datasheet is another question -- for USB devices, it's often
> harder than PCI devices (by unknown reasons).

Then I will label M-audio devices "friendly".

>
> Terratec Aureon 5.1 (which model, BTW?) isn't well tested by
> developers.  We had once good contact with Terratec, and lost again.

Sorry I dropped a part of the name.
The vendor name is Terratec AUREON 5.1 USB MKII.

> AFAIK, no one had a contact with Hercules.
> I don't know about Ion.  Possibly Clemens had any contact?
> But, if the USB device works "as is", then it's all fine, even without
> a datasheet or a test device.  It means that the device is compliant
> to USB-standard protocol.  The bad case is that the device requires
> special vendor-specific protocols (often called "advanced mode").

=46rom what I have seen the Hercules Muse Pocket LT and the Ion TTUSB usb=

turnable both work "as is".
I think I'm going to label "friendly" standard usb sound devices which
work "as is"  without requiring an entry in usbquirks.h
(which does not mean the opposite will mean automatically "unfriendly" )

Thanks for these informations and also for people who replied to me
off-list.

--=20
Emmanuel Kasper
System Administrator
www.libera.cc
Find, compare, buy Linux & FreeBSD compatible hardware


--------------enig23961FE5411A3A4F832425A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIUNM4wfhkdwZoef4RAsMFAJsG5kGawA4WMqnBtQy1o5hzWjE3DACfX6WC
OSryl6rljaQK6aBzmyOcJes=
=13gU
-----END PGP SIGNATURE-----

--------------enig23961FE5411A3A4F832425A0--

--===============0604372363709068494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0604372363709068494==--
