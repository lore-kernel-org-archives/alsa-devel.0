From: Thomas Dietterle <thomas.dietterle@alice-dsl.de>
Subject: Chip: SigmaTel ID 7645
Date: Sun, 16 Nov 2008 20:05:05 +0100
Message-ID: <49206EE1.30705@alice-dsl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.hansenet.de (mx02.hansenet.de [213.191.73.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 265021037EE
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 20:05:02 +0100 (CET)
Received: from [80.171.165.39] (80.171.165.39) by webmail.hansenet.de
	(8.5.014) (authenticated as thomas.dietterle%alice-dsl.de)
	id 4911297501AB1291 for alsa-devel@alsa-project.org;
	Sun, 16 Nov 2008 19:59:40 +0100
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
List-Id: alsa-devel@alsa-project.org

Sehr geehrte Damen und Herren,

ich habe ein Mainboard mit eingebauter Soundkarte.
Leider bekomme ich keinen vern=FCftigen Sound zu h=F6ren, der Klang kratzt
und verliert sich im Echo.

head -n 1 /proc/asound/card0/codec*
Codec: SigmaTel ID 7645

hwinfo --sound
22: PCI 07.0: 0403 Audio device
  [Created at pci.301]
  UDI: /org/freedesktop/Hal/devices/pci_10de_774
  Unique ID: M71A.I3CGe6sNjHC
  SysFS ID: /devices/pci0000:00/0000:00:07.0
  SysFS BusID: 0000:00:07.0
  Hardware Class: sound
  Model: "Elitegroup Audio device"
  Vendor: pci 0x10de "nVidia Corporation"
  Device: pci 0x0774
  SubVendor: pci 0x1019 "Elitegroup Computer Systems"
  SubDevice: pci 0x2666
  Revision: 0xa1
  Driver: "HDA Intel"
  Driver Modules: "snd_hda_intel"
  Memory Range: 0xfce78000-0xfce7bfff (rw,non-prefetchable)
  IRQ: 20 (9832 events)
  Module Alias: "pci:v000010DEd00000774sv00001019sd00002666bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=3Dno, avail=3Dyes, need=3Dno, active=3Dunknown

lsmod| grep snd

snd_pcm_oss            50432  0
snd_mixer_oss          20096  1 snd_pcm_oss
snd_seq                54452  0
snd_seq_device         12172  1 snd_seq
snd_hda_intel         273180  0
snd_pcm                82564  2 snd_pcm_oss,snd_hda_intel
snd_timer              26756  2 snd_seq,snd_pcm
snd                    58164  7
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_pcm,snd_=
timer
soundcore              11460  1 snd
snd_page_alloc         14472  2 snd_hda_intel,snd_pcm

||
Suse 10.3

uname -a
Linux linux-winxp 2.6.22.19-0.1-default #1 SMP 2008-10-14 22:17:43 +0200
i686 athlon i386 GNU/Linux

Woran k=F6nnte es ihrer Meinung noch liegen?
