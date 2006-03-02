From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
Subject: [PATCH] Portability fix for alsa-lib on mips
Date: Fri, 3 Mar 2006 00:02:22 +0100
Message-ID: <20060303000222.bf53567f.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Mar_2006_00_02_22_+0100_3CxIL/XbsBMu_ILa"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Signature=_Fri__3_Mar_2006_00_02_22_+0100_3CxIL/XbsBMu_ILa
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__3_Mar_2006_00_02_22_+0100_6DlYpj7urpRrr/HT"


--Multipart=_Fri__3_Mar_2006_00_02_22_+0100_6DlYpj7urpRrr/HT
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

I recently had problems building alsa-lib 1.0.10 on mips (for my
Netgear WGT634U). Turned out the problem was in include/alsa-symbols.h
were there was __asm__ code that wouldn't work with the mips assembler.
Attached is a patch that makes this work again.

(Normally I'd open a bug report, but the bugtracker seems to be
dysfunctional currently.)

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Multipart=_Fri__3_Mar_2006_00_02_22_+0100_6DlYpj7urpRrr/HT
Content-Type: text/x-patch;
 name="alsa-symbols-mips.patch"
Content-Disposition: attachment;
 filename="alsa-symbols-mips.patch"
Content-Transfer-Encoding: quoted-printable

--- alsa-lib-1.0.10/include/alsa-symbols.h.orig	2006-03-01 21:59:33.5000978=
17 +0100
+++ alsa-lib-1.0.10/include/alsa-symbols.h	2006-03-01 22:00:22.323650362 +0=
100
@@ -57,7 +57,7 @@
 	__asm__ (".set " #name "," #real);		\
 	__asm__ (".set ." #name ",." #real)
 #else
-#ifdef __alpha__
+#if defined(__alpha__) || defined(__mips__)
 #define use_default_symbol_version(real, name, version) \
         __asm__ (".weak " #name); \
         __asm__ (#name " =3D " #real)

--Multipart=_Fri__3_Mar_2006_00_02_22_+0100_6DlYpj7urpRrr/HT--

--Signature=_Fri__3_Mar_2006_00_02_22_+0100_3CxIL/XbsBMu_ILa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEB3mEvI90l8kWns8RAnFdAJ0QitoMBf2kSFdRKXgUyQGPIvU6RwCghF6S
4RHzT4TCkQ2JnaXgVAR5UJ4=
=Ipg3
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Mar_2006_00_02_22_+0100_3CxIL/XbsBMu_ILa--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
