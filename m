From: "Y.Gosset" <ygosset@wanadoo.fr>
Subject: Need little help for Cvs compilation (for Via 8235 IC)
Date: Wed, 2 Apr 2003 13:14:12 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304021314.12904.ygosset@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.

I've some problem with my audio IC on my motherboard : A7V8X ,=20
the via 8235, only with big application like games : ut2003 for example.

For me, latest version (0.9.2) of alsa-lib and alsa-driver don't work ver=
y=20
well for my configuration, and, if it's not very hard, i want compile als=
a=20
with very latest files with the cvs access.

My knowledge of cvs is very basics, but I understand goals and I know a=20
commercial product : Clearcase, that makes same things.=20

Someone can tell me how I can download all files in the latest revision ?=
?,=20
and how I can download files with a selected revison (with a label).
(http://www.cvshome.org/ : too much documents, I'm lost, another links ar=
e=20
welcome)

Also, how I can compile files ? ( I launch "cvscompile" and/or "build", a=
nd=20
that's all ????).
--

I've an another question about messages in my syslog file:
what is the goal of the function "calc_linear_pos" ?=20
(not in details, please ;-) ),=20
a resume : the chip have no enough times to do what he wants ??
Is it a good point of view to reduce/increase PCI latency in this case,
of all PCI cards/functions ??

With a better CPU (more faster), my problems can be resolved ???


Here is piece of my hardware configuration.

Thanks.
Regards, Y.Gosset
--
ygosset@wanadoo.fr

"
# cat /proc/asound/cards
0 [8235           ]: VIA8233 - VIA 8235
                     VIA 8235 at 0xe000, irq 9
"

lspci -vvv
"........
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 A=
udio=20
Controller (rev 50)
Subsystem: Asustek Computer, Inc.: Unknown device 8095
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-=20
SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR-
 Interrupt: pin C routed to IRQ 9
Region 0: I/O ports at e000 [size=3D256]
Capabilities: [c0] Power Management version 2
 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=2E......
"

"
Apr  2 10:51:43 kta syslogd 1.4.1: restart.
Apr  2 10:51:43 kta kernel: klogd 1.4.1, log source =3D /proc/kmsg starte=
d.
Apr  2 10:51:43 kta kernel: Inspecting /boot/System.map
Apr  2 10:51:43 kta kernel: Loaded 17983 symbols from /boot/System.map.
Apr  2 10:51:43 kta kernel: Symbols match kernel version 2.4.20.
Apr  2 10:51:43 kta kernel: Loaded 404 symbols from 17 modules.
Apr  2 10:51:43 kta kernel: Linux version 2.4.20 (root@kta) (gcc version =
3.2=20
(Mandrake Linux 9.0 3.2-1mdk)) #22 sam mar 29 15:32:23 UTC 2003
=2E....
Apr  2 10:51:43 kta kernel: 511MB LOWMEM available.
=2E...
Apr  2 10:51:43 kta kernel: Kernel command line: auto BOOT_IMAGE=3Dlinux =
ro=20
root=3D343 pci=3Dbiosirq devfs=3Dmount
Apr  2 10:51:43 kta kernel: Found and enabled local APIC!
Apr  2 10:51:43 kta kernel: Initializing CPU#0
Apr  2 10:51:43 kta kernel: Detected 1200.072 MHz processor.
Apr  2 10:51:43 kta kernel: Console: colour VGA+ 80x25
Apr  2 10:51:43 kta kernel: Calibrating delay loop... 2392.06 BogoMIPS
=2E..
"

I've these errors in my /var/log/messages file:
Mar 31 22:55:58 kta kernel: fail: idx =3D 1/4, lastpos =3D 0x4000, bufsiz=
e2 =3D=20
0x2000, offsize =3D 0x1000, size =3D 0x1000, count =3D 0x0
Mar 31 22:55:58 kta kernel: ALSA ../alsa-kernel/pci/via82xx.c:675: invali=
d=20
via82xx_cur_ptr, using last valid pointer
Mar 31 22:55:58 kta kernel: fail: idx =3D 1/4, lastpos =3D 0x4000, bufsiz=
e2 =3D=20
0x2000, offsize =3D 0x1000, size =3D 0x1000, count =3D 0x0
Mar 31 22:55:58 kta kernel: ALSA ../alsa-kernel/pci/via82xx.c:675: invali=
d=20
via82xx_cur_ptr, using last valid pointer
Mar 31 22:55:58 kta kernel: fail: idx =3D 1/4, lastpos =3D 0x4000, bufsiz=
e2 =3D=20
0x2000, offsize =3D 0x1000, size =3D 0x1000, count =3D 0x0
=2E........
"



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
