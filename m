From: Peter Good <psgood@petesinternet.net>
Subject: Re: [PATCH] cs46xx: variable period size support,
	Santa Cruz rear output fixes
Date: 09 Nov 2002 14:50:49 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036817449.30137.2.camel@pete>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sOdVUfPuySiZefn5G80Y"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-sOdVUfPuySiZefn5G80Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So should the drive be able to set period size with this patch?

Reason I ask is this.

spongy@pete:~$ alsaplayer
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (181 11610)
PERIOD_SIZE: [8 512]
PERIOD_BYTES: [32 2048]
PERIODS: (0 2048]
BUFFER_TIME: (362 371520)
BUFFER_SIZE: [16 16384]
BUFFER_BYTES: [64 65536]
TICK_TIME: 10000


Pete

--=20
"I am neither especially clever nor especially=20
gifted. I am only very, very curious." Einstein.

Peter Good
Pete's Internet Services
GnuPG Public Key: http://www.petesinternet.net/public.gpg

--=-sOdVUfPuySiZefn5G80Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9zJQpxDSKIXbtT7gRAsDhAJ498jA/NQ4yxdP6akF3mrsBPlylxwCffKIN
6wZH3GqszOdzQMXrWiQbIZg=
=a/aT
-----END PGP SIGNATURE-----

--=-sOdVUfPuySiZefn5G80Y--



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
