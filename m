From: Tony Vroon <tony@vroon.org>
Subject: Re: [PATCH] ALSA: emu10k1: fix device names
	for	Live!/Audigy1/2/4/E-mu and coding style
Date: Wed, 22 Oct 2008 11:27:19 +0100
Message-ID: <1224671239.4001.19.camel@localhost>
References: <fd3eb9bf0810190533l75f8b20kd31a3dbb158d7c0f@mail.gmail.com>
	<s5h7i83rdvr.wl%tiwai@suse.de>
	<fd3eb9bf0810210200l45b33311o7ec5d674b53f5912@mail.gmail.com>
	<s5habcykl3o.wl%tiwai@suse.de>
	<fd3eb9bf0810211018r50a12e5bu6a3141e16762fe91@mail.gmail.com>
	<s5hprltj71z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4886143135139178377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id A72272451E
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 12:28:43 +0200 (CEST)
In-Reply-To: <s5hprltj71z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vedran =?UTF-8?Q?Mileti=C4=87?= <rivanvx@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4886143135139178377==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PRN4kQBtH/KMkU0J4gv6"


--=-PRN4kQBtH/KMkU0J4gv6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Vedran,

With regard to the SB0228 comment, just make sure you're reading the
product ID from the correct location. The silk-screened number on the
PCB will always end in 0, but if you read the serial number label on the
back of the card, you'll find the real product ID.
Generally something along the lines of M1SB0228xxxxxxxxx
Skip the first two characters, read the next 6. This works on Creative
soundcards that are Live! or newer, before then their serial numbers
looked different.

This may help you find more specific product IDs for other OEM Live! &
Audigy boards.

Regards,
Tony V.

--=-PRN4kQBtH/KMkU0J4gv6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj/AAcACgkQp5vW4rUFj5rlogCeJV2EZ8D04QMTAN6lNbiQcaCF
wzsAmgIXnvT9NLxDx4YvHk5dw1xax3wH
=4YzR
-----END PGP SIGNATURE-----

--=-PRN4kQBtH/KMkU0J4gv6--


--===============4886143135139178377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4886143135139178377==--
