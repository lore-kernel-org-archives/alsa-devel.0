From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Revo 7.1 setup ?
Date: Sat, 03 Dec 2005 20:08:03 +0100
Message-ID: <1133636889.4274.7.camel@rousalka.dyndns.org>
Reply-To: nicolas.mailhot@laposte.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-78Co7jG88LmlQOJVg+ls"
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
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-78Co7jG88LmlQOJVg+ls
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to setup a revo 7.1 in digital out mode (will do 5.1 analog
whenever I receive Y cables).

After much googling the best asoundrc setting I found is :

pcm.!default {
        type plug
        slave.pcm "spdif"
}

(no it's not in the wiki nor anywhere else, I had to merge two different
suggestions in messages separated by months to get any sound on this
card).

Problem is :
1. apps complain someone blocks accesses (probably means some dmixing is
in order ?)
2. I'm hearing stuttering when I manage to kick esd from the card.
3. I don't seem able to control sound anywhere in the gnome mixer

Can anyone help me ? I've already spend hours on this, and I'm still not
able to play a CD decently with what is supposed to be a well-supported
alsa card.


--=20
Nicolas Mailhot

--=-78Co7jG88LmlQOJVg+ls
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkOR7RIACgkQI2bVKDsp8g0VhQCePjYHc24sBWot4KBcw92Rj53C
tpgAn3+KM3Lp90Zqjxm31/2ZpxhNs/i6
=XIcY
-----END PGP SIGNATURE-----

--=-78Co7jG88LmlQOJVg+ls--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
