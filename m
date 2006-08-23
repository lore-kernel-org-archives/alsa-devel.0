From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH] fix volume control for the AK4358 DAC
Date: Wed, 23 Aug 2006 17:36:13 +0100
Message-ID: <20060823163613.GB17932@localhost.localdomain>
References: <20060822200009.GC3025@tarte.seehuhn.de>
	<s5hfyfnss4j.wl%tiwai@suse.de>
	<20060823104544.GC17791@localhost.localdomain>
	<s5hzmdvy29d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2018796839=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmdvy29d.wl%tiwai@suse.de>
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


--===============2018796839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Wed, Aug 23, 2006 at 04:07:10PM +0200, Takashi Iwai wrote:
> > Yes, I think you are right.  Currently there is no problem, since
> > shift is never used simultaneously with needsmsb, but this should be
> > fixed anyway.  I will check all users of shift to see whether they are
> > all fine with a 6 bit value.  If so, I will try to prepare another
> > patch until tomorrow or so.
>=20
> It's a shift bit number, so 3 bit should be enough for a byte data.
> I'll fix it and queue to my local tree.

Excellent!  I was just worried that it is (mis-)used somewhere for
something else which needs higher resolution.

Many thanks,
Jochen
--=20
http://seehuhn.de/

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE7IP9f+iD8yEbECURAlOtAKC2nT7DIxhlhdksE9LWEWugpmNZvACgy4+N
zRYd8NGMUxlg/YI/WRF5OJY=
=PHz9
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--


--===============2018796839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2018796839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2018796839==--
