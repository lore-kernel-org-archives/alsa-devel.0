From: Hod McWuff <hod@wuff.dhs.org>
Subject: dolby digital output
Date: 17 Feb 2002 01:33:32 -0500
Message-ID: <1013927613.9422.10.camel@samoyed.wuff.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-aqJj/bhqTtO4K1FpLmoA"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-aqJj/bhqTtO4K1FpLmoA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


What would be involved in enabling 5.1-channel spdif output?=20


I'd imagine the first step would be to add an ac3 encoder, and then
(possibly) the 2->5.1 channel demuxing for stereo streams. This would
result in the ability to mix dolby digital streams (DVD's) with more
mundane PCM streams, such as IM or telephony apps.


I'm willing to tackle some moderate coding, but I haven't attacked alsa
internals at all yet... where's the best docs for that?

--=-aqJj/bhqTtO4K1FpLmoA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8b068CcSqvpnxLx8RAp8lAJ0cJ4mfvxbiJ0KVN6BvwdqqzL2WkACeIq/8
Nhy/TFejj9uCdTDhny3y8MY=
=Ew6P
-----END PGP SIGNATURE-----

--=-aqJj/bhqTtO4K1FpLmoA--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
