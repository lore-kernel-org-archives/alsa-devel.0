From: Jordi Mallach <jordi@debian.org>
Subject: Re: Fwd: via82xx problem
Date: Thu, 3 Apr 2003 00:58:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030402225838.GA5225@nubol.int.oskuro.net>
References: <3E854FD5.7070801@boosthardware.com> <s5h1y0nkjpt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1y0nkjpt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2003 at 10:45:34AM +0200, Takashi Iwai wrote:
> please give the chip verison (listed in /proc/asound/cards in the
> latest alsa driver).  and try pcm:0,1 (or /dev/adsp for oss) device.
> this should work (almost) as same as 0.9.0rc6.

Hi Takashi,

I'm seeing this same problem on my mother's box, which I just upgraded
to 0.9.2.

0 [8233A          ]: VIA8233A - VIA 8233A
                     VIA 8233A at 0xe000, irq 5

Where do I set pcm:0,1? I know where to do it for just one app
(QuakeForge), but not globally. Other apps just don't have where to set
this. Is it using a module parametre?

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+i2seJYSUupF6Il4RAqZKAKDvacfvhOj5Nz3NiObZRnRC4VNfuQCg1GMB
IdEFhCLNsdDD3Tvb3KJUSA4=
=LES0
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
