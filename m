From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add number of periods constraint to
	snd-aoa [try 3]
Date: Sat, 24 Nov 2007 14:48:43 +0100
Message-ID: <1195912123.4149.192.camel@johannes.berg>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
	<1195822183.4149.118.camel@johannes.berg>
	<s5h63ztt6uu.wl%tiwai@suse.de>
	<1195849391.4149.154.camel@johannes.berg>
	<s5hsl2wne5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5390717834174491925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 80652247A8
	for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2007 14:48:54 +0100 (CET)
In-Reply-To: <s5hsl2wne5m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Heikki O Lindholm <holindho@cs.helsinki.fi>
List-Id: alsa-devel@alsa-project.org


--===============5390717834174491925==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-My6MQEjcgp6e+HNOZyNc"


--=-My6MQEjcgp6e+HNOZyNc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > snd-usb-audio I think.
>=20
> Oh that's I didn't know of.  Do you have more detailed information?

Not really. I just happened to have an usb audio dongle handy and
plugged it in for a quick test.

> usb-audio also has no integer periods constraint, so it might suffer
> from the same problem, too.

Interesting. What purpose serves not having the constraint globally?

johannes

--=-My6MQEjcgp6e+HNOZyNc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0gruaVg1VMiehFYAQLfFxAAhC4BX8eYrwHWD+FkeBeFgK95Op1+WIdf
jcY47hMblztJ3CvtX36DIM1ZcaZ9OW+vyFP2HEvyfTVjSUPc73TDSH87n9BpcVsY
6TqEQbrUbJMLDMjm1GIzrpH+PVwvLCun2waECPDgG9pyUzBwxNgyJywVOnYTOisB
wVEGGUZS+8HFIb2YIMJCL2CXGAAbsQESMwa3JHx9eNg+nX4LKijYvi7yZIl+U+0b
EQmVE1L+aeWQpHz8tVTnuLIvnneO4adQb3pJlk/eQSUuRvY8r93C/2+QLYBgp3gI
e7qCzsPRwlAYsDhBNBScocexst9edPw+HHw+Jy3IpI6dGE5K1I2VkDIT4K6P4J2p
6RP3XJ7cOf733s6NqithzHq4ye5puRR9eKZBXqMj/RicwMJItuucQ+GqgMFBjYch
Honuy1ZvwZhtisaSzLxJE0vi+dwMXQgdgc0m6Z82O2YpXy8+zAkenDtq5ufizleS
kjA21fhULygCxuIv+EiqiY/m59dSbvy/RlJoZ9gwRTz1KhW7N9ch1cxnANFrWujB
uPgjy7ys/wx2PQZNcs7rfnlviyrtc8bENnk3DH+VR0btsAdGu+B8+WeA66XbshTA
PMbGZDggDvfb+6GeKTyo7+Oovo6i50FMwfsODCgTgmCj25FxTYW7BAtbaqkB3OVz
D8PWozA39aI=
=R7r5
-----END PGP SIGNATURE-----

--=-My6MQEjcgp6e+HNOZyNc--


--===============5390717834174491925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5390717834174491925==--
