From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP - snd-hdsp.o: init_module: No such device
Date: Fri, 17 May 2002 12:02:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E178eZd-0000DB-00@satellite>
Reply-To: thomas@undata.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite (ALyon-101-1-6-151.abo.wanadoo.fr [217.128.18.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA16634
	for <alsa-devel@alsa-project.org>; Fri, 17 May 2002 12:11:36 +0200
Received: from toma by satellite with local (Exim 3.35 #1 (Debian))
	id 178eZd-0000DB-00
	for <alsa-devel@alsa-project.org>; Fri, 17 May 2002 12:02:57 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I was very excited and pleased to see hdsp driver had reached cvs (thank =
you=20
Paul !) , so I gave it a try. Here are the results.
I manage to insmod everything needed except the snd-hdsp module. I get th=
e=20
following in syslog:
May 16 12:11:18 satellite kernel: RME Hammerfall-DSP: no cards found
May 16 12:15:36 satellite kernel: ALSA=20
../../alsa-kernel/pci/rme9652/hdsp.c:455: Hammerfall-DSP: no Digiface or=20
Multiface connected!
May 16 12:15:36 satellite kernel: RME Hammerfall-DSP: no cards found

I'm using a cardbus hdsp + multiface on a toshiba satellite notebook, wit=
h=20
kernel 2.4.18. The computer fails to boot with the card inserted, but acc=
epts=20
the card afterwards, and the host led on the multiface switches down.

cat /proc/pci outputs
Bus =A03, device =A0 0, function =A00:
=A0 =A0 Multimedia audio controller: PCI device 10ee:3fc5 (rev 10).
=A0 =A0 =A0 IRQ 10.
=A0 =A0 =A0 Master Capable. =A0Latency=3D64.
=A0 =A0 =A0 Non-prefetchable 32 bit memory at 0xd2400000 [0xd20fffff].
but syslog shows
May 16 09:54:57 satellite kernel: cs: cb_alloc(bus 3): vendor 0x10ee, dev=
ice=20
0x3fc5
May 16 09:54:57 satellite kernel: PCI: Failed to allocate resource=20
0(d2400000-d20fffff) for 03:00.0
May 16 09:54:57 satellite kernel: PCI: Enabling device 03:00.0 (0080 -> 0=
082)
May 16 09:54:57 satellite cardmgr[258]: socket 0: CardBus hotplug device

Any idea?

Regards,
Thomas


(ps: this is the second time I send this message. The first time I hadn't=
=20
subscribed so I guess it is waiting in the moderator's mail box. Sorry fo=
r=20
double posting. Since then I rebuilt my kernel, and got rid of the freeze=
 at=20
bootup, but the rest still applies.)

but=20

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
