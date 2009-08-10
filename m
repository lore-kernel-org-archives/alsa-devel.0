From: Tim Blechmann <tim@klingt.org>
Subject: hard freezes with hdsp with cardbus/pci adapter card
Date: Mon, 10 Aug 2009 23:32:28 +0200
Message-ID: <h5q3ur$13e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6699460052556463393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6792C248D6
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 23:37:43 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MacYn-0005nL-Q0
	for alsa-devel@alsa-project.org; Mon, 10 Aug 2009 21:37:41 +0000
Received: from 85-127-248-0.dynamic.xdsl-line.inode.at ([85.127.248.0])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 21:37:41 +0000
Received: from tim by 85-127-248-0.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 21:37:41 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6699460052556463393==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2638C3517E5BE25CE7A09242"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2638C3517E5BE25CE7A09242
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,

i have some issues with playback on one of my machines with different
kernels, having my rme hammerfall hdsp connected via a cardbus/pci
adapter card.

after some time (between a few seconds and several minutes) of flawless
playback, the system completely freezes, magic sysrq keys are not
functional either ... the freeze occurs with rt and non-rt kernels,
with jack running with and without realtime scheduling.

i have the suspicion, that it is related to the combination of the hdsp
with the cardbus controller of the adapter card ...

the interesting part of lspci is:
06:01.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
(rev 01)
	Subsystem: ENE Technology Inc CB1410 Cardbus Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 168, Cache Line Size: 64 bytes
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

07:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 0f)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 255
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at c8000000 (32-bit, non-prefetchable) [size=3D64K]
	Kernel driver in use: RME Hammerfall DSP
	Kernel modules: snd-hdsp

the irq 17 is used by these two devices only. i am not sure, how to
proceed debugging this, since i cannot get any useful debugging
information ...

thnx, tim

--=20
tim@klingt.org
http://tim.klingt.org

A paranoid is a man who knows a little of what's going on.
  William S. Burroughs


--------------enig2638C3517E5BE25CE7A09242
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqAkfIACgkQdL+4qsZfVsvRMgCfUtJf3Ycse0w0Hb2d9EauIf3q
XG8AoImzesX2b818ozkPoLgmaawRK9oZ
=PYRp
-----END PGP SIGNATURE-----

--------------enig2638C3517E5BE25CE7A09242--


--===============6699460052556463393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6699460052556463393==--
