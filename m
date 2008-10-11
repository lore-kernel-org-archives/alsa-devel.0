From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sat, 11 Oct 2008 13:04:02 -0500
Message-ID: <1223748242.5199.7.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<s5hzlld6j6u.wl%tiwai@suse.de>
	<1223662652.5275.10.camel@petrie.sacredspiral.co.uk>
	<s5hd4i7p1ce.wl%tiwai@suse.de>
	<1223746569.5193.6.camel@petrie.sacredspiral.co.uk>
	<s5hiqrzqba0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8886451864468450646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 6087A10382B
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 20:04:24 +0200 (CEST)
In-Reply-To: <s5hiqrzqba0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Ted T. Logian" <tedtheologian@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8886451864468450646==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OTMXnh5spjmqUHWyHOKV"


--=-OTMXnh5spjmqUHWyHOKV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2008-10-11 at 19:41 +0200, Takashi Iwai wrote:
> Could you build with XXX_CONST_TIMER defined?  This will disable the
> adaptive timer-resolution handling I added to the driver, which
> doesn't
> exist in OSS sbxfi code at all.

No change in behaviour. It survives a little longer, but then the system
hardlocks... without me even touching the keyboard even.

>=20
> > Noise is now on the right channel only.
>=20
> Does it mean that the left channel plays normally as expected?
> Also, which sample rate are you using?  I'm curious whether the sample
> rate tracking is correct...

No. The left channel is silent.

>=20
> > It might make more sense to poll for the DAC reset in the interrupt
> > handler. I have noticed that the card generates an interrupt request
> in
> > Windows once the DAC is online.
>=20
> Interesting...  Maybe putting some debug prints in interrupt handler
> and else would help a bit for more understanding.
>=20
> > Something leads me to believe that the DMA mask is 32 bits, but
> given
> > that the behaviour is similar in both instances, I am unsure.
>=20
> This isn't a critical issue right now.  It can be figured out safely
> later.

I am now actually 100% positive the DMA mask is 32 bits.

By the way, it's an original X-Fi in this case (I have others to test
with). lspci -vvv gives us:

05:01.0 Multimedia audio controller: Creative Labs SB X-Fi
	Subsystem: Creative Labs Device 0021
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (1000ns min, 1250ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d200 [size=3D32]
	Region 1: Memory at f0000000 (64-bit, non-prefetchable) [size=3D2M]
	Region 3: Memory at ec000000 (64-bit, non-prefetchable) [size=3D64M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/0 =
Enable-
		Address: 0000000000000000  Data: 0000

Kernel is:
Linux version 2.6.27 (nenolod@petrie) (gcc version 4.2.4 (Debian 4.2.4-2
+b1)) #1 SMP Sat Oct 11 11:59:08 CDT 2008

William

--=-OTMXnh5spjmqUHWyHOKV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI8OqSoB+26npOQg4RAgBrAKCLc1Ff45ExRxNe6ditPamBhvXNaQCeOzOO
x8pnRu+ju4u859hl67X9rXA=
=ILmN
-----END PGP SIGNATURE-----

--=-OTMXnh5spjmqUHWyHOKV--


--===============8886451864468450646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8886451864468450646==--
