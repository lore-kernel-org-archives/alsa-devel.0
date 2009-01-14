From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel on macbook5,
	1 (was: lockdep	warning	on	2.6.29-rc1	with	pulseaudio)
Date: Wed, 14 Jan 2009 18:22:35 +0100
Message-ID: <1231953755.3776.4.camel@johannes>
References: <1231866121.3847.6.camel@johannes>
	<s5hiqoj870o.wl%tiwai@suse.de> <1231868779.3840.11.camel@johannes>
	<s5hk58yfko5.wl%tiwai@suse.de> <1231928348.3730.7.camel@johannes>
	<s5h4p0288sb.wl%tiwai@suse.de> <1231949930.3789.1.camel@johannes>
	<s5hk58x7t74.wl%tiwai@suse.de> <1231950785.3789.4.camel@johannes>
	<s5hbpu97r0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2792997183721836261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E44A103816
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 18:22:28 +0100 (CET)
In-Reply-To: <s5hbpu97r0t.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2792997183721836261==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UOLw2Uwzi0z38u+5OOFy"


--=-UOLw2Uwzi0z38u+5OOFy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-14 at 18:10 +0100, Takashi Iwai wrote:

> Well, first off, you need to figure out the pin mapping, which
> pin-widget NID corresponding to which actual I/O.
> You'd better start from the output jacks than speaker outputs since
> speaker outputs often require the special handling like GPIO and/or
> EAPD.
>=20
> With hda-verb, you can issue all commands, so free to change the amp
> volume and reconnect the widgets.  Jaroslav's hda-analyzer provides a
> better interface (GUI) for such a purpose.
>=20
> See Documentation/sounds/alsa/HD-Audio.txt in the latest kernel git
> tree.

Fun, ok.

> > > Or do they have any external information file like on Windows *.ini?
> >=20
> > Yes, Info.plist files, but none seem to contain any useful information,
> > what sort of information would you be looking for?
>=20
> There could be some list of pin ids and flags or sequences.
> At least, *.INI contains a sort of things like that.

There's some sort of binary information.

Actually, I played with things a little more, and dug a little deeper
into what the ubuntu forums say, and it turned out that I made a stupid
mistake, I typoed mbp3 as mpb3 when testing it.

Now, I actually get sound with model=3Dmbp3, but the controls are all
wrong, e.g. line-out controls the built-in speakers, and the speaker
on/off control doesn't do anything to the speakers. Also, I need to turn
up the volumes pretty much to max to get any output at all, which seems
a little strange. I'll try to figure out what the controls really are
and see if I can make a new model that links it all up correctly.

Anyway, sorry for the bother and thanks for all the help.

In other news, I've got a new aoa patch that actually works on the older
models, but so far doesn't fix the quiet sound problem either, I'm still
working with Andreas on that. And I'm also working with somebody else to
get optical output on topaz-based machines.

johannes

--=-UOLw2Uwzi0z38u+5OOFy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbh9ZAAoJEKVg1VMiehFYoToP/RWcI5BOS9XXwBFg8BVT6rw2
eBsZKqbOExXysJ9nS9i1zxdcLHLI3D4g3L87ONPgsK0tiUcPZVfK7/KyceDD8rXp
4JLTm6NCkZLoK15ucZVi6giI1Huqt+D80D7dNdWUMeVydq5t66BZmKNkfoz8rER1
7K46xTrAILMYKdVBwxCHRl04lzpEN/gX8IwDF5mJ/TXOVHKS06ITDCrymPoB2xQ9
HdNX1QXKYfnr2w36NUB+8T6dAAEP8yVYqfnlX+bwvGH4Q9X3fuAKTxmpkZ08XckW
PPn3raj9oYkPyswHt7ebFDydF9/IdP39zmlFPVFtLzKkGt3zQn29r42tbqd68M4W
bBx4r1/2rMXRNEx3Qy8fNJRIKs/WsqryOzLBwbN2/dTauCgW6rFUOxIH95QR75kg
cojhGjf2XY7plZkUjrNUdLohKkBwjLgzNs6ZVnHHG61iyFHIttdr8GijOAWTEhDW
HpykL82aiRc08Q8QZ6o/mCWhy3emS77AszTySaIeOmWzzYqSPuH0mF0YsaJdmvFi
hPt1dZ0sKVPOC6Nl0B+pA17x4iu1QNKtgOZ+Lpty7M5seyMwEA6VMT9PalCzab96
dh7KkF/A2CUkrW9FS0t4hJ1s42pVrn7qRryLYMBLpB52SuvAeh8yXthZHbFLkQxO
25FDkp+GG1QoCLOdyFd2
=VH9e
-----END PGP SIGNATURE-----

--=-UOLw2Uwzi0z38u+5OOFy--


--===============2792997183721836261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2792997183721836261==--
