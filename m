From: "David E. Storey" <dave@tamos.net>
Subject: Re: still losing with hdsp (me too)
Date: 04 Jun 2003 13:55:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054749305.443.12.camel@localhost>
References: <50411.24.225.156.130.1054593994.squirrel@webmail.ouroboros-complex.org>
	 <200306031413.13936.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0GO8/2D6I0zU+YqvmIH5"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306031413.13936.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-0GO8/2D6I0zU+YqvmIH5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm also having problems with the hdsp driver, however, I can get my
multiface + PCMCIA card working just fine so long as I boot XP first. XP
will load the firmware and when I reboot into linux and do a "modprobe
snd-hdsp", it loads up just fine and states that the firmware has
already been initialized. If I don't boot into XP first...

(root@scorpius root)# lspci -vvv -s 07:00
07:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 0b)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 21000000 (32-bit, non-prefetchable)
[size=3D64K]

(root@scorpius root)# modprobe snd-hdsp
(root@scorpius root)# dmesg
[snip]
cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
PCI: Enabling device 07:00.0 (0080 -> 0082)
Hammerfall memory allocator: buffers allocated for 1 cards
PCI: Setting latency timer of device 07:00.0 to 64
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4107: card initialization
pending : waiting for firmware

(root@scorpius root)# hdsploader=20
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : Intel 82801CA-ICH3 at 0x1c00, irq 9
Card 1 : RME Hammerfall DSP at 0x21000000, irq 9
Upload firmware for card hw:1
Hwdep ioctl error on card hw:1 : Input/output error.

(root@scorpius root)# dmesg
[snip]
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4107: card initialization
pending : waiting for firmware
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <=3D 0
failed after 30 iterations
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3803: initializing firmware
upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:508: Hammerfall-DSP: no
Digiface or Multiface connected!

While the XP boot-up is annoying, the driver works fine otherwise.

d!

--=-0GO8/2D6I0zU+YqvmIH5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+3jJ5+5sC2muyxOMRAnATAJ4riR4QBcZbxPbQ6ByghQ80hrgXNgCfUzmG
76D+n53N5IX+ZHF6OWk3Wxo=
=R8YQ
-----END PGP SIGNATURE-----

--=-0GO8/2D6I0zU+YqvmIH5--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
