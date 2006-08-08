From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 11:40:15 +0100
Message-ID: <20060808104015.GA20149@seehuhn.de>
References: <20060807203113.GA5305@tarte.seehuhn.de>
	<s5hbqqvr0i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1960868328=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqqvr0i6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1960868328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Tue, Aug 08, 2006 at 12:21:37PM +0200, Takashi Iwai wrote:
> The document for 7.1 was not publicly released.  And no known document
> for 5.1.  You should ask M-Audio about it.

I will be away for a few days so now is a bad time.
But I will try to ask them once I am back.
Is there a know contact person, or is the plan
to just search through their web page for a feasible
communication channel and then use this?

> > 1) The ice1712/revo.h header file (shared by Revolution 7.1 and 5.1)
> > defines the following:
> >=20
> > #define VT1724_REVO_CCLK	0x02
> > #define VT1724_REVO_CDIN	0x04	/* not used */
> > #define VT1724_REVO_CDOUT	0x08
> > #define VT1724_REVO_CS0		0x10	/* not used */
> > #define VT1724_REVO_CS1		0x20	/* front AKM4381 chipselect */
> > #define VT1724_REVO_CS2		0x40	/* surround AKM4355 chipselect */
> > #define VT1724_REVO_MUTE	(1<<22)	/* 0 =3D all mute, 1 =3D normal operat=
ion */
> >=20
> > Why are the "not used" ones there?
>=20
> Why not? :)

Because they are not used?

> > Note that 0x80 is not mentioned in the header file.  Is this a
> > problem?
>=20
> Might be.  The code was originally written for Revo 7.1, and I have no
> revo 5.1.  Just heard that it works so.

Playback works fine.  Capture does not.

Many thanks,
Jochen
--=20
http://seehuhn.de/

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE2GoPmQikLRypuYcRAiySAJ9c5wGjoKIObPpz0NaYotiZxo3bOwCferkY
0wLxi/SuRnKmTO3GmLw28Ac=
=ublk
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


--===============1960868328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1960868328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1960868328==--
