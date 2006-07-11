From: Valdis.Kletnieks@vt.edu
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 10:30:29 -0400
Message-ID: <200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>
	<20060711081528.4d3ab197.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0209805614=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 299FE1AA
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 16:30:31 +0200 (MEST)
In-Reply-To: Your message of "Tue, 11 Jul 2006 08:15:28 +0200."
	<20060711081528.4d3ab197.atlka@pg.gda.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org, rlrevell@joe-job.com, perex@suse.cz, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

--===============0209805614==
Content-Type: multipart/signed; boundary="==_Exmh_1152628229_5755P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1152628229_5755P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2006 08:15:28 +0200, Adam =3D?ISO-8859-2?B?VGxhs2th?=3D sa=
id:
> On Mon, 10 Jul 2006 22:09:51 -0400
> Valdis.Kletnieks=40vt.edu wrote:
>=20
> > On Tue, 11 Jul 2006 01:38:39 +0200, =3D?ISO-8859-2?Q?Adam_Tla=3DB3ka?=
=3D said:
> > > U=BFytkownik Lee Revell napisa=B3:
> > >
> > > > esd and artsd are no longer needed since ALSA began to enable sof=
tware
> > > > mixing by default in release 1.0.9.
> > >  >
> > >=20
> > > So why they are still exist in so many Linux distributions?
> >=20
> > As soon as somebody writes a patch to make the e16 window manager tal=
k ALSA
> > rather than use esd, I'm heaving esd over the side.
>=20
> Sorry to say but it is just not that way. Window manager is for managin=
g windows
> and it shouldn't depend on any audio system. It should use an external =
app using exec call
> to play sounds (aplay, sox, wavplay etc.) configured by some config opt=
ion.

So what you're saying is that something like 'esd' *is* needed.  (It's
certainly silly to keep doing fork/exec for every little sound sample whe=
n
you can just leave the app running and hand it requests...)

Either ALSA is up to the task, or it isn't and needs a front-end program
to babysit it. It doesn't matter if the program trying to play the sound
is a window manager, or an e-mail program, or something else....

--==_Exmh_1152628229_5755P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEs7YFcC3lWbTT17ARAmxiAJsEAjLcR4saPxKn94dsl9I9lL+d3wCfVn3W
1/Qj3S1t/6SivkkD0IBitRs=
=UgXy
-----END PGP SIGNATURE-----

--==_Exmh_1152628229_5755P--


--===============0209805614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0209805614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0209805614==--
