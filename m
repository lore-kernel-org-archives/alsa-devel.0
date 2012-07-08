From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: 3.5-rc6 doesn't run powerpc SoundByLayout
Date: Sun, 8 Jul 2012 10:21:57 +0200
Message-ID: <20120708082157.GA3955@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2927053881448555205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
	[83.223.95.204]) by alsa0.perex.cz (Postfix) with ESMTP id 1A6452438F
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2012 10:22:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org


--===============2927053881448555205==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

trying 3.5.0-rc6 doesn't give me sound from my snd_aoa_codec_onyx.
ii  libasound2:powerpc                      1.0.25-3
ii  libasound2-plugins:powerpc              1.0.25-2
ii  alsa-utils                              1.0.25-3


alsamixer tells: This sound device does not have any controls.

$ aplay -l
**** List of PLAYBACK Hardware Devices ****

$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
default:CARD=3DSoundByLayout
    Default Audio Device
sysdefault:CARD=3DSoundByLayout
    Default Audio Device

Kernel 3.4.4 runs just fine!

Does one had similar experience?

Elimar
--=20
  Learned men are the cisterns of knowledge,
  not the fountainheads ;-)

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP+UMjAAoJED2rN0233PG7/5EQALIVf2Qll1gYesyLGKVtLLim
hnmSFMfa4SnWnQlXsU8PO1/xSFRl1Xv467AyXUr+aiVMeFymrm+DGZ53wpupoKNi
VClP7hIoyz0tDJIBpqL+Si/wnA6NZU3Gex7Ljk/v6VH6FWWFYjQAJom2dGiinE4f
L9l95GazuvDbpTodr6tx1wT+bkbejcbmabY5HxxRcp6JyNTEZRbFadODeVnuhDsS
Dq+21Yx4aG5Ha445IbNljlzg+T34SUSlFqPppumcdwByJ1Z82qUpiwKzIAvWFZQ3
RcLp0SsyWPurrQtKTRWd7vZuQJtpHMFAqqeVjxpDG8yziIFC8jEp0e4qlKM98stR
ZwD4yZKYWx4R8OMl+R1JoIqQmFxCj4cFLlhAO0rOPyHkS5TUvT2yKOvNqdOzq/rx
TELUyH1MYJgUhYsHeUwlx+jputCxi5w6lnsQJA6jvw8Yz3JmEE20ZXdIpOaGC8Uj
dxbTpX6FOuMQxruZTcVIZ2VwF0bqAOTBC2TufdhNHsXNGmjD0G2JKZHlniVBqoY+
5K6WBkHep+EfzD2npJGkSn0/Ofzupf2mWLRbZPDTqHNkX7REYxwyuKwQucRp9fyR
VwgOSASYkpCNyCgYpK3YjOaaeECubQqeumsVoN2aZ3DTnofN5fK4TyxFJdk+3+YO
pSpJC0c80ZJs5m4HT/vi
=K9/t
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============2927053881448555205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2927053881448555205==--
