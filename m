From: Ian Kumlien <pomac@vapor.com>
Subject: [snd_ca0106] volume, oss-emu etc
Date: Fri, 04 Mar 2005 16:05:29 +0100
Message-ID: <1109948729.21021.91.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7LgX8674s5EHOelbLMmY"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-7LgX8674s5EHOelbLMmY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I dunno how many others that has suffered from this... I just bought a
new machine and i thought i was getting a safer bet going with one that
had a soundcard from creative (i was hoping for EMU10k1 chip but..).=20

I now use snd_ca0106 which is compiled from alsa-driver 1.0.8 and it
works but there is some issues.

The worst one first:
There is no master volume, no pcm volume... I can only change the
individual channel volumes. This doesn't help me, i doubt it helps
anyone... Channel variance is something that should be tweaked once or
twice not constantly imho. Also with gnome volume thingies this problem
compounds... Right now selecting front works, but which front? digital
or analog? I will have sound coming from both...=20

And now some words on OSS emu:
It seems like this card defaults to a higher hertz than common oss, so
you get samples that play too quick and some clipping noises... I have
noticed that if you play something long enough it will eventually work
but that's not fun...

The same clipping noise can happen with apps using alsa... it doesn't
happen with the gstreamer framework though.

Common commandline mpg123 works (uses oss) but, f.ex. xmms doesn't work.
The OSS mixer doesn't work either...

If something plays via OSS, alsa won't work stating that it's busy...
But playing multiple streams over alsa seems to work.

That's about it from now, I guess i have been spoiled coming from
emu10k1 on OSS...=20

PS. CC: since I'm not subbed.
	alsa-devel was added as a initial post, if you use reply-to-all
	from alsa-user, please drop it since it might not be appreciated
	by them =3D).
DS.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-7LgX8674s5EHOelbLMmY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCKHk57F3Euyc51N8RApbNAJ4nJ1LKyScs/LDxycHKUhLn8r/qYwCfbdRP
ed8or5WgtGYttw2ruPgxjHk=
=jh/w
-----END PGP SIGNATURE-----

--=-7LgX8674s5EHOelbLMmY--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
