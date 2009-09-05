From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: [PATCH] Bug#544607: /usr/share/alsa/init/default
 missing closing brace for format in 5 cases
Date: Sat, 5 Sep 2009 02:01:03 +0200
Message-ID: <20090905000103.GA3167@aragorn.home.lxtec.de>
References: <20090901202614.5849.99958.reportbug@base.lan>
	<20090902122915.GB4978@frodo.home.lxtec.de>
	<alpine.LNX.2.00.0909021433260.12522@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0480502119148577355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id D5F1B2436A
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Sep 2009 02:01:11 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0909021433260.12522@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: 544607@bugs.debian.org, Philipp Jocham <philipp.jocham@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0480502119148577355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jaroslav Kysela [090902 14:34 +0200]
> On Wed, 2 Sep 2009, Elimar Riesebieter wrote:
>=20
> >forward 544607 alsa-devel@alsa-project.org
>=20
> >>-ENV{has_pmaster_vol}=3D=3D"true",CTL{values)=3D"100%",GOTO=3D"headphon=
e0_end"
> >>+ENV{has_pmaster_vol}=3D=3D"true",CTL{values}=3D"100%",GOTO=3D"headphon=
e0_end"

It is not only line 52. We have 4 more c+p errors. See attached
patch.

Elimar

--=20
  We all know Linux is great... it does infinite loops in 5 seconds.
        -- Linus Torvalds

--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: attachment; filename="alsactl_brace.patch"

# Fix wrong enclosed values with braces
# -- Elimar Riesebieter <riesebie@lxtec.de>  Fri, 04 Sep 2009 22:15:12 +0200
Index: alsa-utils-1.0.21/alsactl/init/default
===================================================================
--- alsa-utils-1.0.21.orig/alsactl/init/default	2009-08-31 17:13:36.000000000 +0200
+++ alsa-utils-1.0.21/alsactl/init/default	2009-09-04 22:19:32.000000000 +0200
@@ -39,7 +39,7 @@
 CTL{name}="Front Playback Volume",PROGRAM!="__ctl_search",GOTO="front0_end"
 # if master volume control is present, turn front volume to max
 ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="front0_end"
-ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="front0_end"
+ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="front0_end"
 CTL{values}="$env{pvolume}",RESULT!="0",CTL{values}="$env{ppercent}"
 LABEL="front0_end"
 CTL{name}="Front Playback Switch",PROGRAM=="__ctl_search", \
@@ -49,7 +49,7 @@
 CTL{name}="Headphone Playback Volume",PROGRAM!="__ctl_search",GOTO="headphone0_end"
 # if master volume control is present, turn headphone volume to max
 ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="headphone0_end"
-ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="headphone0_end"
+ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="headphone0_end"
 CTL{values}="$env{pvolume}",RESULT!="0",CTL{values}="$env{ppercent}"
 LABEL="headphone0_end"
 CTL{name}="Headphone Playback Switch",PROGRAM=="__ctl_search", \
@@ -72,7 +72,7 @@
  CTL{name}="PCM Volume",PROGRAM!="__ctl_search", GOTO="pcm0_end"
 # if master volume control is present, turn PCM volume to max
 ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="pcm0_end"
-ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="pcm0_end"
+ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="pcm0_end"
 # exception - some HDA codecs have shifted dB range
 CTL{dBmin}=="-34.50dB",CTL{dBmax}=="12.00dB",CTL{values}="0dB",GOTO="pcm0_end"
 CTL{dBmin}=="-30.00dB",CTL{dBmax}=="0dB",CTL{values}="0dB",GOTO="pcm0_end"
@@ -86,7 +86,7 @@
   CTL{name}="PCM Volume",PROGRAM!="__ctl_search",GOTO="pcm1_end"
 # if master volume control is present, turn PCM volume to max
 ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="pcm1_end"
-ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="pcm1_end"
+ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="pcm1_end"
 # exception - some HDA codecs have shifted dB range
 CTL{dBmin}=="-34.50dB",CTL{dBmax}=="12.00dB",CTL{values}="0dB",GOTO="pcm1_end"
 CTL{dBmin}=="-30.00dB",CTL{dBmax}=="0dB",CTL{values}="0dB",GOTO="pcm1_end"
@@ -125,7 +125,7 @@
 CTL{name}="CD Playback Volume",PROGRAM!="__ctl_search", GOTO="cd0_end"
 # if master volume control is present, turn CD volume to max
 ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="cd0_end"
-ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="cd0_end"
+ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="cd0_end"
 # exception - some HDA codecs have shifted dB range
 CTL{dBmin}=="-34.50dB",CTL{dBmax}=="12.00dB",CTL{values}="0dB",GOTO="cd0_end"
 CTL{dBmin}=="-30.00dB",CTL{dBmax}=="0dB",CTL{values}="0dB",GOTO="cd0_end"

--sdtB3X0nJg68CQEu--

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqhqj4ACgkQ3Ig8bsVPf7DdxwCeLugh/iFujRaLSrPMFWQ8pFkT
6/sAnA33ZwtoOgOeoQlL3v1CVL4v/2ZZ
=WM/+
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

--===============0480502119148577355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0480502119148577355==--
