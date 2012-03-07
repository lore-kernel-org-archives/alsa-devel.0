From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 19:19:50 +0000
Message-ID: <20120307191949.GZ3107@opensource.wolfsonmicro.com>
References: <CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
	<20120307163456.GQ3107@opensource.wolfsonmicro.com>
	<CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
	<CAJDSjBjMJMBvJrjhwEqU3S+hKMD_E1MU3taJOPoxS+3QSo-r7g@mail.gmail.com>
	<20120307171149.GS3107@opensource.wolfsonmicro.com>
	<CAJDSjBiH7=btSWPX-zh8FLokKGDVVD52ngdiv1fvd7QpkV3ZyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270435560905899693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95E99104117
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 20:19:51 +0100 (CET)
In-Reply-To: <CAJDSjBiH7=btSWPX-zh8FLokKGDVVD52ngdiv1fvd7QpkV3ZyA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin PAI <nitinmpai@gmail.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1270435560905899693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrEcvySKR+fOA8iz"
Content-Disposition: inline


--yrEcvySKR+fOA8iz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 11:28:49PM +0530, Nitin PAI wrote:
> >>Perhaps your BSP is doing things differently to mainline here; it's
> >>vanishingly rare in mainline for machine drivers to enforce any limits
> >>themselves.  Usually the CODEC and SoC drivers do this.

> I meant the SoC drivers can still enforce these limits, and need not rely
> on CODEC driver.

Usually the CODEC will be way more limited than the SoC, for example the
WM8727 (which is one of these dumb drivers) only supports sample rates
down to 32kHz but I'd be astonished if a SoC didn't do standard audio
rates from 8kHz up.

--yrEcvySKR+fOA8iz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7TOAAoJEBus8iNuMP3dJ2MP+wV5Jfv7gX+Dg3Se90y0yfs4
4otvr6LFq5m5joRieMdYzBDMQWlhzDDWDf0Xm0PRFlWW3mO29tovAFVvnf7d5Yxe
32Dr9piTyGcq/577wsAu+7hgqfvZ3gYybClRi7zF6wQGDgcUjaskdk+EkNOVYcGa
LtSDW9uIHXCV2wQfffE0xdleJ//iPL7KIkXwIhfWi9qjXpTlSJGL5mt76VlBLIgT
EK/b7xqwIAMxjaEOvf1YUZ4wSrTJcU4C6lcpRAdMSsDat8axFQQSxONHgmbPFmmQ
pILmh26Y98L7WCVg5zY4PG5Q5Sw2+GlqK87rjVvwEpynR5ntsG+8TVEqQVCfQEQs
SgNN4j6pVxPVU5xrkaUzk/3yQLEPBG0DaQ3+P1tjKOAsyPau3jWGRI0l7N9qMjtg
prA4R9DLSpvidb38TLDBS8rYv0LMAFQQSMZgTUFaoeipKPCOIvYBqoi+v7amU/M0
kK5QkEE1PmmkDVtqrq0UO7pnx8q1NuMyQdisn/6MYqpyBpou0bkALryC2TQuyZaH
zzZ3sduNQCs5x4VdII7kXMZE/2y4SKRroPHL9utso/1PCErYOG5JQb8/P24rDVH1
aywj1Vbv1NpWLd5ysJ+pM7/v9fHhSwypygZLGtqnOIjF3foreFGB6ThaJm3wQSIh
oWF7qpRUHAXY8mbvYCAR
=GGlC
-----END PGP SIGNATURE-----

--yrEcvySKR+fOA8iz--

--===============1270435560905899693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1270435560905899693==--
