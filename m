From: Chris White <chriswhite@gentoo.org>
Subject: VT82C686 and MIDI fun
Date: Thu, 10 Feb 2005 01:18:15 +0900
Message-ID: <1107965895.8941.21.camel@secures>
Reply-To: chriswhite@gentoo.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p/NSfv0McDxLcePTj0qa"
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


--=-p/NSfv0McDxLcePTj0qa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alright, so I thought I send this here just in case I RTFM wrong :P.  So
basically, here's the deal.. I'm on a ppc system (2.6.9 kernel) using
alsa driver 1.0.8 (latest), via82xx module (Via being the vendor, my
model being in the subject line), and all a nice midi keyboard hooked up
to the MIDI/Gameport with an adapater I got.  Now, I've tried the
following without much success:

1) I did the `modprobe snd-via82xx mpu_port=3D0x330` command to set the
mpu port, which is what it's documented as, /dev/midi does nothing
2) Ok, maybe my setup is jacked, so I tried hooking it up to my x86
system, works like a charm
3) I looked over the documentation.. which tells me to work with
snd-mpu401.. but I thought that was depricated by snd-mpu401-uart?

So.. that said.. I'm stuck here wondering what's going on.  It's either
a) go buy a card or b) there's some serious endian going on.
Comments/suggestions/flames welcome (though wait till I get the firesuit
on).

--=-p/NSfv0McDxLcePTj0qa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 
	=?UTF-8?Q?=E3=81=93=E3=81=AE=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B8=E3=81=AB=E3=81=AF=E3=83=87=E3=82=B8=E3=82=BF?=
	=?UTF-8?Q?=E3=83=AB=E7=BD=B2=E5=90=8D=E3=81=95=E3=82=8C=E3=81=9F?=
	=?UTF-8?Q?=E9=83=A8=E5=88=86=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE?=
	=?UTF-8?Q?=E3=81=99?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCCjfHFdQwWVoAgN4RAl6xAKDM4a1QOnwHg0yLorHCDB3T9pul+QCg1UZU
UOIBm+ABPiWOjVRCCxnIHMQ=
=SpyR
-----END PGP SIGNATURE-----

--=-p/NSfv0McDxLcePTj0qa--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
