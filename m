From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: alsa-tools FTBFS on armel: gcc-6 narrowing conversions
Date: Mon, 12 Sep 2016 18:52:18 +0200
Message-ID: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8101866784569746749=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id AAFD326680E
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:52:20 +0200 (CEST)
Received: from h06.hostsharing.net (h06.hostsharing.net [83.223.95.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mailout2.hostsharing.net (Postfix) with ESMTPS id D8E59101899A9
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:52:19 +0200 (CEST)
Received: from mail.home.lxtec.de
 (HSI-KBW-46-223-54-142.hsi.kabel-badenwuerttemberg.de [46.223.54.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h06.hostsharing.net (Postfix) with ESMTPSA id 996DC6052C04
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:52:19 +0200 (CEST)
Received: from localhost ([127.0.0.1])
 by mail.home.lxtec.de with esmtp (Exim 4.87 2 (LXTEC))
 id 1bjUSw-0006mc-SU
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:52:18 +0200
Received: from mail.home.lxtec.de ([IPv6:::1])
 by localhost (baumbart.home.lxtec.de [IPv6:::1]) (amavisd-new, port 10024)
 with ESMTP id JDMG94gH3kmE for <alsa-devel@alsa-project.org>;
 Mon, 12 Sep 2016 18:52:18 +0200 (CEST)
Received: from galadriel.home.lxtec.de ([192.168.200.207])
 by mail.home.lxtec.de with smtp (Exim 4.87 2 (LXTEC))
 id 1bjUSw-0006tO-Lx
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:52:18 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8101866784569746749==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vnrsl2qlacbfh23t"
Content-Disposition: inline


--vnrsl2qlacbfh23t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

in Debian a FTBFS was discovered in building alsa-tools:

| arm-linux-gnueabi-g++ -DPACKAGE_NAME=3D\"hdspmixer\" -DPACKAGE_TARNAME=3D=
\"hdspmixer\" -DPACKAGE_VERSION=3D\"1.11\" -DPACKAGE_STRING=3D\"hdspmixer\ =
1.11\" -DPACKAGE_BUGREPORT=3D\"\" -DPACKAGE_URL=3D\"\" -DPACKAGE=3D\"hdspmi=
xer\" -DVERSION=3D\"1.11\" -DSTDC_HEADERS=3D1 -DHAVE_LIBASOUND=3D1 -I.   -W=
date-time -D_FORTIFY_SOURCE=3D2  -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR=
>>=3D. -fstack-protector-strong -Wformat -Werror=3Dformat-security   -I/usr=
/include/freetype2   -D_THREAD_SAFE -D_REENTRANT -fno-exceptions -MT channe=
lmap.o -MD -MP -MF .deps/channelmap.Tpo -c -o channelmap.o channelmap.cxx
| channelmap.cxx:59:1: error: narrowing conversion of '-1' from 'int' to 'c=
har' inside { } [-Wnarrowing]
|  };
|  ^

More Details can be found at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D837590

Could this be fixed for next release?

Thanks in advance
Elimar
--=20
  Experience is something you don't get until
  just after you need it!

--vnrsl2qlacbfh23t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: I welcome encrypted mail.

iQIcBAEBCAAGBQJX1t0+AAoJED2rN0233PG7XHAQAIpwYaAmgbrEtBTJxp/GKu1z
Q1WPB5upLX8KzUupL59sjXyMYlL8wpawACZd8CXDuQB9znMBk+wHWwZaH/VEp4to
g4nRgRtDFCI070M1VNaW4pYToYp9Iow0y7fjWSj/d2fPkvN/leWj5c90K59dOO+d
fyA7ivyMvkEU7IW3kpEXDRwTAEbfd/jXPrRUHZhVKuWnFbuRowXo6tLMhPa+8hfl
NCArUFrfVxu6ucj3PdfOpKJchpubBVUhm3lKyLELdjW3ndRU62ofk7ux8htNNycV
IFhZRPHd/WgQSx+E1akoGGtAILZ2hECOOuS8LMCSxuLp7JbpxX4Z22Ti3nECgwOV
gK0/kU/UumrvmD/aePMAGxXqyGUHD7QUHN4MbY/hy5FvSWqVWzlxKNLezEFTmtLR
1Njx0ZcNLHABHCKiogJKTB0gSPiP/f5sIknThLDC2WeclVgcvdLlW4RLuFLdkN3P
C7MGb4mqRH5xdiUSEM3p8YaYk9QBbUirjl6lfwa4/8WiGDsGJXfDa6I3D09J53rL
EG9e1pVODscETLSkwODG5YhxaULeOaNLKk0rKjcBab156ynbSdng7C+M2R3BuKMu
1Ay2Vcqx/jX8S7kqBmwipDRAKREUkZKmoX3HO7b2zLUvZ9sSAVuo6/Rh+zSLrrsE
HEfc9eKDTDhxbP+H9prt
=Ql2/
-----END PGP SIGNATURE-----

--vnrsl2qlacbfh23t--

--===============8101866784569746749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8101866784569746749==--
