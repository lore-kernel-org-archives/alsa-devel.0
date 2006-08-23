From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH] fix volume control for the AK4358 DAC
Date: Wed, 23 Aug 2006 11:45:45 +0100
Message-ID: <20060823104544.GC17791@localhost.localdomain>
References: <20060822200009.GC3025@tarte.seehuhn.de>
	<s5hfyfnss4j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510952215=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyfnss4j.wl%tiwai@suse.de>
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


--===============0510952215==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Aug 23, 2006 at 11:45:00AM +0200, Takashi Iwai wrote:
> >  #define AK_GET_CHIP(val)		(((val) >> 8) & 0xff)
> >  #define AK_GET_ADDR(val)		((val) & 0xff)
> >  #define AK_GET_SHIFT(val)		(((val) >> 16) & 0x7f)
>=20
> Shouldn't this be (((val) >> 16) & 0x3f) to exclude bit 22?
>=20
> > +#define AK_GET_NEEDSMSB(val)		(((val) >> 22) & 1)

Yes, I think you are right.  Currently there is no problem, since
shift is never used simultaneously with needsmsb, but this should be
fixed anyway.  I will check all users of shift to see whether they are
all fine with a 6 bit value.  If so, I will try to prepare another
patch until tomorrow or so.

All the best,
Jochen
--=20
http://seehuhn.de/

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE7DHYf+iD8yEbECURAm7IAKCVXzOJSF9o7QyX3Hi56+D6eUPwsgCgyz+r
tEy5iuvV/CiHqO6BS1VGqog=
=eoqp
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--


--===============0510952215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0510952215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0510952215==--
