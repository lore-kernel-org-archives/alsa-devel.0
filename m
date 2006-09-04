From: Jochen =?iso-8859-1?B?Vm/f?= <voss@maths.warwick.ac.uk>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Mon, 4 Sep 2006 13:12:32 +0100
Message-ID: <20060904121232.GC24842@localhost.localdomain>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
	<s5hejurlv98.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1967863424=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejurlv98.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1967863424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Sep 04, 2006 at 01:35:31PM +0200, Takashi Iwai wrote:
> Yes, the exactly same table appears in AK4524 datasheet, too.
> The only question is whether they really behave _indenpendently_.
>=20
> On AK4524, IPGA and IATT are actually two different values.  As I
> wrote, 0x82 only changes IPGA value but doesn't change IATT.  0x02
> changes only IATT but not IPGA.  And the total volume is IPGA + IATT.
Ok, I will try to play with my card and figure this out tonight.

All the best,
Jochen
--=20
http://www.maths.warwick.ac.uk/~voss/

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/Bgwf+iD8yEbECURAqaAAJ9NFZ0tCbDa1t5tbAUXbCk3E1u3/gCfaIqA
B5O92nWa7D4s1CScCCTIIfw=
=0mG7
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


--===============1967863424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1967863424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1967863424==--
