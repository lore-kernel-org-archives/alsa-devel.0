From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add number of periods constraint
	to	snd-aoa [try 3]
Date: Mon, 26 Nov 2007 15:58:17 +0100
Message-ID: <1196089097.4149.267.camel@johannes.berg>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
	<1195822183.4149.118.camel@johannes.berg>
	<s5h63ztt6uu.wl%tiwai@suse.de>
	<1195849391.4149.154.camel@johannes.berg>
	<s5hsl2wne5m.wl%tiwai@suse.de>
	<1196062105.9290.1223195775@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2510182158657768020=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 7399C2482F
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 16:48:45 +0100 (CET)
In-Reply-To: <1196062105.9290.1223195775@webmail.messagingengine.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Heikki O Lindholm <holindho@cs.helsinki.fi>
List-Id: alsa-devel@alsa-project.org


--===============2510182158657768020==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zgy9SfaFBvxoCBm5fYe5"


--=-zgy9SfaFBvxoCBm5fYe5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > > > > So what I'm not sure on... Why do we see the same behaviour with =
other
> > > > > drivers? Same bug?
> > > >=20
> > > > Which driver?  It should be fixed as well, then.
> > >=20
> > > snd-usb-audio I think.
> >=20
> > Oh that's I didn't know of.  Do you have more detailed information?
> >=20
> > usb-audio also has no integer periods constraint, so it might suffer
> > from the same problem, too.
>=20
> snd-usb-audio uses double buffering and doesn't have any requirements
> regarding periods.

Hm. I'm pretty sure I did see the same problem there. I guess I'll have
to test that again to convince myself (and then you) :)

johannes

--=-zgy9SfaFBvxoCBm5fYe5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0rfB6Vg1VMiehFYAQJUMRAAjCac5ZffZqjUdLPx1i9pOlqIyjEOZ5Ia
uELj2Qwv7evGYitPPxjk05NitWOhYgTIhtHNzYq3Pp+JUJ4HZeY4dPemWVtj6RSr
5+vneX82Te0S6gsJBpag/87Tti07t3mWvFl+ZVR/GkGd91A0GJk9TFoJWieBtJkq
z8wMDfuSzeM5w9Q9/g/tygCyC1YvbMKTWp/YKoxTB5rS7b/SrLeSDLPf+w6KN4Sv
SS8TcXYsMHrtJp0vL70UnIMOMLFZZRNVkUaYc/f8jzxPqBpjkaf2XzAZMY6vmeyI
hN7mFFPwFhET7/C4jh55SFBO3B81Jgb5qNiiPODAM93XSUeoXqkSaLnfN5kGQu2Z
A4rj/UAd/gI6hlkMIAnkC9hhSsrMYfjyxQJf7HMmd2AHAXWxeMI1SMOG9qvRujrT
hQTiXhzScUPCwO2mB/WKhKfiEj65tp0oAaFk+LOYzGj7SJlyuREJJbUZwJe9jMQS
zC2ZrcGHCbYm/3EAhZXIim3wpJuiZzayZVgRmBCeq3PMlZ1SwrZQ45ex83VWLQxB
8mwfBPbr7wFdvi4OM8W45+tPliV/5yYo/y2mNM9Obv1oxqpZpv9ZAeYOlHIZ+ZqU
viF34Erp/BOyezDwcO4dg6dc8eeJ3SgUoxznAZ6vUFkmII+CBHTcP058waQLP2xI
5EM6eq3SAoA=
=sjVy
-----END PGP SIGNATURE-----

--=-zgy9SfaFBvxoCBm5fYe5--


--===============2510182158657768020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2510182158657768020==--
