From: Kaushal Shriyan <kshriyan@redhat.com>
Subject: RE: Sound Card Driver
Date: Mon, 20 Dec 2004 12:25:53 +0530
Message-ID: <1103525753.5179.24.camel@oaks.mumbai.redhat.com>
Reply-To: kshriyan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hEuu1/1MxaVi6+QjKz6m"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: cltien@cmedia.com.tw
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-hEuu1/1MxaVi6+QjKz6m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Tien

I have used the following steps
./configure --with-oss=3Dyes --with-sequencer=3Dyes --with-cards=3Dazx
make
make install

The drivers get compiled successfully, but when I run the soundcard
detection gui application, I get NO SOUND CARD Detected.

My lsmod are as below:-
[root@pcs root]# lsmod=20
Module                  Size  Used by    Not tainted
snd-azx                25692   0  (unused)
snd-pcm                90432   0  [snd-azx]
snd-timer              21628   0  [snd-pcm]
snd                    51172   0  [snd-azx snd-pcm snd-timer]
snd-page-alloc          8296   0  [snd-pcm snd-timer snd]
soundcore               7044   0  [snd]

Awaiting your earnest reply

Regards

Kaushal Shriyan
--=20
Regards,

Kaushal Shriyan
Technical Engineer
Red Hat India Pvt. Ltd.
135, Mittal Towers
13th Floor, B Wing
Nariman Point
Mumbai 400021
India
Tel    : +91-22-22881326/27
Fax    : +91-22-22881318
Cell   : +91-9820367783
E-mail : kshriyan@redhat.com


--=-hEuu1/1MxaVi6+QjKz6m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBBxnd5bz6HAjcmEroRAhwSAJ9OuIS4R+GDGkzxNoIsCKalVJ+rswCfS+C6
EG7IjUQ3jVTKrpu2d2Ewhyk=
=H1T0
-----END PGP SIGNATURE-----

--=-hEuu1/1MxaVi6+QjKz6m--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
