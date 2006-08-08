From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH 0/2] Revolution 5.1 - add capture support
Date: Tue, 8 Aug 2006 19:57:58 +0100
Message-ID: <20060808185758.GA30577@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1171879861=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1171879861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the promised patch to enable capture support on the M-Audio
Revolution 5.1 card.

part 1: add AK5365 support to i2c/other/ak4xxx-adda.c
part 2: register the card's AK5365 ADC with ALSA

The mute button support is still missing.
If I find time, I will post a patch on top of these two
to enable the mute button.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2N62f+iD8yEbECURAizSAJ98pT6eXfepxHMFjN/wIvLHCI4pKwCfaFS/
GhtkvROCZVIRtKc5ta1H8Ns=
=iJyX
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


--===============1171879861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1171879861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1171879861==--
