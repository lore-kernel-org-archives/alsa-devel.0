From: Tim Blechmann <tim@klingt.org>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
	card
Date: Tue, 11 Aug 2009 09:26:19 +0200
Message-ID: <4A811D1B.2020709@klingt.org>
References: <h5q3ur$13e$1@ger.gmane.org>	<20090811050619.GA12438@pengutronix.de>
	<4A811076.6000603@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1486019005925576001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CD324452
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 09:26:24 +0200 (CEST)
In-Reply-To: <4A811076.6000603@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-pcmcia@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1486019005925576001==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8A5AA9A80207727C09DA79D9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A5AA9A80207727C09DA79D9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hm, actually, i think the issue is related to the pci latency of the
cardbus controller.

after changing the latency timer of the card to 0xff, i am running the
system for about an hour without freeze. the new output of lspci is:

06:01.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
(rev 01)
	Subsystem: ENE Technology Inc CB1410 Cardbus Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 255, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fb600000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D06, secondary=3D07, subordinate=3D0a, sec-latency=3D176
	Memory window 0: c4000000-c7fff000 (prefetchable)
	Memory window 1: c8000000-cbfff000
	I/O window 0: 0000e000-0000e0ff
	I/O window 1: 0000e400-0000e4ff
	BridgeCtl: Parity+ SERR+ ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
	Kernel driver in use: yenta_cardbus
	Kernel modules: yenta_socket


i am not sure, whether it is related, but the hdsp driver sets its
latency timer to 0xff as well, commented with:

	/* From Martin Bjoernsen :
	    "It is important that the card's latency timer register in
	    the PCI configuration space is set to a value much larger
	    than 0 by the computer's BIOS or the driver.
	    The windows driver always sets this 8 bit register [...]
	    to its maximum 255 to avoid problems with some computers."
	*/

maybe the ene bridge doesn't like to have devices connected, with a
higher latency timer value, that it is using itself?

tim

--=20
tim@klingt.org
http://tim.klingt.org

Every word is like an unnecessary stain on silence and nothingness
  Samuel Beckett


--------------enig8A5AA9A80207727C09DA79D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqBHRsACgkQdL+4qsZfVstQcQCdH5e7wE9ir0El4P2WHehkdSN7
AAIAn0BW67GO+xay4c2xmcXeAx1ZuaCQ
=p1ip
-----END PGP SIGNATURE-----

--------------enig8A5AA9A80207727C09DA79D9--

--===============1486019005925576001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1486019005925576001==--
