From: Jochen Voss <voss@seehuhn.de>
Subject: GPIO connections for the M-Audio Revolution 5.1
Date: Mon, 7 Aug 2006 21:31:14 +0100
Message-ID: <20060807203113.GA5305@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0013293619=="
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
To: matplotlib development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0013293619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

last week I reported bug #2325: capturing sound on the M-Audio
Revolution 5.1 does not work.  While trying to figure out the
cause of the problem, I encountered the following question:

What are the GPIO pins of the Envy24GT connected to for this card?
Since there is already a driver, somebody will probably have figured
this out, but I could not find documented anywhere.

What I did find out:

1) The ice1712/revo.h header file (shared by Revolution 7.1 and 5.1)
defines the following:

#define VT1724_REVO_CCLK	0x02
#define VT1724_REVO_CDIN	0x04	/* not used */
#define VT1724_REVO_CDOUT	0x08
#define VT1724_REVO_CS0		0x10	/* not used */
#define VT1724_REVO_CS1		0x20	/* front AKM4381 chipselect */
#define VT1724_REVO_CS2		0x40	/* surround AKM4355 chipselect */
#define VT1724_REVO_MUTE	(1<<22)	/* 0 =3D all mute, 1 =3D normal operation =
*/

Why are the "not used" ones there?

2) From visual inspection of the card (a photo is at
http://seehuhn.de/comp/hardware/revoboard.jpg ) I think that the
following GPIO pins are connected to something:

    0x01 (seems to go to the PCI bus)
    0x02
    0x04
    0x20
    0x40
    0x80
    (1<<22)

Note that 0x80 is not mentioned in the header file.  Is this a
problem?

3) I think that AK4381 and AK4355 as mentioned in the header file are
DACs.  The Revolution 5.1 has only one DAC (an AK4358), not two.
Could this cause problems?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE16MRf+iD8yEbECURAswqAKDIXH94g083aNtLEVKtQZrtxuoz7gCgmS8h
YihGw3v6e/1WMj6q3t2VH/0=
=egTw
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


--===============0013293619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0013293619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0013293619==--
