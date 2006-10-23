From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: Problems building alsa-driver on FC6 (2.6.18)
Date: Mon, 23 Oct 2006 13:03:18 +0200
Message-ID: <20061023110318.GG7410@neu.nirvana>
References: <20061022095459.GA8377@neu.nirvana> <s5hmz7n1eny.wl%tiwai@suse.de>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0854417920=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz7n1eny.wl%tiwai@suse.de>
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


--===============0854417920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2006 at 12:59:13PM +0200, Takashi Iwai wrote:
> At Sun, 22 Oct 2006 11:54:59 +0200,
> Axel Thimm wrote:
> >=20
> > Hi,
> >=20
> > I can't build alsa-driver on FC6. Comparing to FC5, which is also
> > 2.6.18 based I see the following differences during configure:
>=20
> Which version of ALSA did you try?  Hg version of alsa-driver checks
> the existence of linux/config.h and creates a dummy linux/config.h
> appropriately.

I used 1.0.13 release. I also had some progress with replacing
config.h with autoconf.h. I'm rebuilding for all dists at ATrpms which
include some old 2.4 kernels and will report back whether this works,
thanks!
--=20
Axel.Thimm at ATrpms.net

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPKF2QBVS1GOamfERAmACAKCacUCDflMd9rcMs4+fNFvItDy2gACeMbNI
NDKdr7lJTee2gzvRuFyw68M=
=0mQD
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--


--===============0854417920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0854417920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0854417920==--
