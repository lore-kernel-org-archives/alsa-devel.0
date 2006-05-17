From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 14:24:36 +0200
Message-ID: <1147868676.15507.14.camel__13077.5446574718$1147868790$gmane$org@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
	 <1147817058.6753.7.camel@localhost.localdomain>
	 <s5hzmhh0yq4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KL6qrLewIojKBYSi66Y6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 08774191
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 14:24:44 +0200 (MEST)
In-Reply-To: <s5hzmhh0yq4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-KL6qrLewIojKBYSi66Y6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 11:47 +0200, Takashi Iwai wrote:
>=20
> The mixer stuff is the weakest point in the current ALSA
> implementation, and it has to be sorted out better.=20

Here's another item for the wishlist:

Give applications an option to tell the library they can handle
ENUMERATED controls, and then don't mess with them. And then, if the
application *doesn't* tell the lib it can handle ENUMERATED controls,
split up *all* the enumerated controls instead of just the "Capture
Source" one. The current behaviour:
 - it splits up the Capture Source one but no others
 - it doesn't allow apps to get the real intention

is bogus for the following reasons:
 - most GUI programs get *checkboxes* that are mutually exclusive
 - a lot of GUI programs that cannot handle ENUMERATED items
   totally screw up when they still get an enumerated one just
   because it had a different name.

johannes

--=-KL6qrLewIojKBYSi66Y6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsWAqVg1VMiehFYAQJaGhAAi+o/2ELqofFsRY4N7Bq3fqhF+vwCNC6f
0WoZ93IIvfp/CwLOerOeuQqMoYL4+9OGTZT8aAOzibr6g+2Ho8O4Spg4vhSZSfZF
KzefVIMyBZ/JX8CsP5CtcV4EWL9Bg3DmJ9iouG28ch3hp53gTm7Ca0NS4aAg59lx
q29V3WBGzmAyQkuwHVt0ntsV2gjEeCPEPVJ3eK4u2eLMPIjPg7q0mtCZREMc3SOi
ecamP/mg0ptSXo99PVnVQfEaXFSBjb1Qhuuv6v49/m/PgEMPGLmcuXPVm+ZBvt08
wiIIu4J2mAAW5OP7J93S3vTdLbbLstn3DspQVCDnY2GbWP8zUIe4Hggn3OIAeyGO
JQmd998RGQ256shuJh+Umm1dYTdkrCz/CTF6eMZnZJhJI4UmLecNa/2MRRWQcEs5
tgGOWMqKMOqPRunvWvoow/Ym1a9uI47tZaK4PGUHYo/MwMZgZvwnERjXzMBUIysD
g8Jp4omZt4KsDxmLipuqoX/lsB48XmAgLxFGki/WwsvMo3/bfUY6aSei0H6zs5nR
E7B4/bjdNZYTUbUMPlDTdHKkeHkcr0ZyeMpS5ibY5LGlkglu8CSQjEKx7QqgrHjG
/yUbHuw4NR16vlkK26N2stskgdnlUnwNpmngpuuNzRxIjyBih2bJ6GBAxMBmzZWf
CeH6Gw1wqgU=
=9VWJ
-----END PGP SIGNATURE-----

--=-KL6qrLewIojKBYSi66Y6--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
