From: Fruhwirth Clemens <clemens@endorphin.org>
Subject: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio adapter
Date: Thu, 03 Mar 2005 10:34:37 +0100
Message-ID: <1109842477.13896.32.camel@ghanima>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d/1udmzgsqOnprFXRWPD"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-d/1udmzgsqOnprFXRWPD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My USB audio class device doesn't show all mixer controls in ALSA.
For reference, for other users searching this archive, it's a "Creative
USB Sound Blaster Live! 24-bit External".=20
(http://creative.com/products/product.asp?category=3D1&subcategory=3D206&pr=
oduct=3D10702&nav=3D2)

I have added some inspection code to usb-mixer.c, which basically dumps
all class specific USB interface descriptors.=20

My card got 2 x OUTPUT_TERMINAL, 2 x INPUT_TERMINAL, 2 x FEATURE_UNIT
for the AudioControl class. But this doesn't make me any wiser.

I wonder why the snd_usb_create_mixer code does only loop over the
OUTPUT_TERMINAL class, even there is support code for all other types in
the parse_audio_unit code, which is called subsequently by
snd_usb_create_mixer.

My aim is to have controls available for the Line-in mixer, both for
recording and for direct re-mixing into the Main Out Plug.

Is there a developer owning such a box, or anyone who can guess what I'm
supposed to do with the additional AudioControl class controls?=20

Are there any tools that helps inspecting the USB device, or further
dumping of class-specific content and/or inspection of the USB
flow between a vmware hosted windows system and the linux host system?

Thanks,

What's the reason why Bug#995 is not available to the public? I'm
getting access denied. Otherwise I would have put this message into the
bugtracker.
--=20
http://clemens.endorphin.org, for robots sp4mtrap@endorphin.org

--=-d/1udmzgsqOnprFXRWPD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJtotbjN8iSMYtrsRAvHXAKCF0Df1mn8HIAFH+iWD4YD2S3MhtwCcDd51
rVli9u25/vjcSNX6dop+RQ4=
=iGDc
-----END PGP SIGNATURE-----

--=-d/1udmzgsqOnprFXRWPD--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
