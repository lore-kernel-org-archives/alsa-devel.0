From: harald graef <haraldgraef@web.de>
Subject: ALC883, Headphones working only;
	ac97_quirk=hp_only does not work;
Date: Fri, 26 Jan 2007 07:44:53 +0100
Message-ID: <1105295702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 ALSA Developers ML
       mailto:alsa-devel@lists.sourceforge.net

Problem: Sound is on the headphones only; using the module options on the s=
nd-hda-intel
	 module doesn't help

Kernel: Linux 2.6.18-3-amd64 #1 SMP Mon Dec 4 17:04:37 CET 2006 x86_64 GNU/=
Linux
Mixer: ALC883
Chipset: NForce
Distribution: Debian etch AMD64, Weekly snapshot; =

(snippet from /etc/apt/sources.list:
Debian GNU/Linux testing _Etch_ - Official Snapshot amd64 DVD  20070122-10:=
29]/ etch)

>lspci -nv
00:00.0 0500: 10de:02f3 (rev a2)
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping

00:00.1 0500: 10de:02fa (rev a2)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel

00:00.2 0500: 10de:02fe (rev a2)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel

00:00.3 0500: 10de:02f8 (rev a2)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel

00:00.4 0500: 10de:02f9 (rev a2)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0

00:00.5 0500: 10de:02ff (rev a2)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] #00 [00fe]
	Capabilities: [fc] #00 [0000]

00:00.6 0500: 10de:027f (rev a2)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel

00:00.7 0500: 10de:027e (rev a2)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel

00:02.0 0604: 10de:02fc (rev a1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: b3000000-b31fffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d01fffff
	Capabilities: [40] Subsystem: 10de:0000
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/1 =
Enable+
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:03.0 0604: 10de:02fd (rev a1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	Capabilities: [40] Subsystem: 10de:0000
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/1 =
Enable+
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:05.0 0300: 10de:0247 (rev a2) (prog-if 00 [VGA])
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
	Memory at b2000000 (32-bit, non-prefetchable) [size=3D16M]
	Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
	Memory at b1000000 (64-bit, non-prefetchable) [size=3D16M]
	[virtual] Expansion ROM at 52000000 [disabled] [size=3D128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/0 =
Enable-

00:09.0 0500: 10de:0270 (rev a2)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 0601: 10de:0260 (rev a3)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0

00:0a.1 0c05: 10de:0264 (rev a3)
	Subsystem: 1558:0661
	Flags: 66MHz, fast devsel, IRQ 10
	I/O ports at 3040 [size=3D64]
	I/O ports at 3000 [size=3D64]
	Capabilities: [44] Power Management version 2

00:0a.3 0b40: 10de:0271 (rev a3)
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 255
	Memory at b0040000 (32-bit, non-prefetchable) [size=3D256K]

00:0b.0 0c03: 10de:026d (rev a3) (prog-if 10 [OHCI])
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 201
	Memory at 52020000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2

00:0b.1 0c03: 10de:026e (rev a3) (prog-if 20 [EHCI])
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 209
	Memory at b0005000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:0d.0 0101: 10de:0265 (rev f1) (prog-if 8a [Master SecP PriP])
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0
	I/O ports at 3080 [size=3D16]
	Capabilities: [44] Power Management version 2

00:0e.0 0101: 10de:0266 (rev f1) (prog-if 85 [Master SecO PriO])
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
	I/O ports at 30b0 [size=3D8]
	I/O ports at 30a4 [size=3D4]
	I/O ports at 30a8 [size=3D8]
	I/O ports at 30a0 [size=3D4]
	I/O ports at 3090 [size=3D16]
	Memory at b0006000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/2 =
Enable-
	Capabilities: [cc] HyperTransport: MSI Mapping

00:10.0 0604: 10de:026f (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D05, subordinate=3D09, sec-latency=3D64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: b3200000-b32fffff
	Prefetchable memory behind bridge: 50000000-51ffffff
	Capabilities: [b8] Subsystem: 0000:0000
	Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 0403: 10de:026c (rev a2)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
	Memory at b0000000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: [44] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=3D0/0 =
Enable-
	Capabilities: [6c] HyperTransport: MSI Mapping

00:14.0 0680: 10de:0269 (rev a3)
	Subsystem: 1558:0661
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
	Memory at b0007000 (32-bit, non-prefetchable) [size=3D4K]
	I/O ports at 30b8 [size=3D8]
	Capabilities: [44] Power Management version 2

00:18.0 0600: 1022:1100
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 0600: 1022:1101
	Flags: fast devsel

00:18.2 0600: 1022:1102
	Flags: fast devsel

00:18.3 0600: 1022:1103
	Flags: fast devsel
	Capabilities: [f0] #0f [0010]

05:07.0 0607: 104c:8039
	Subsystem: 1558:0661
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at b3200000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D05, secondary=3D06, subordinate=3D09, sec-latency=3D176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	16-bit legacy interface ports at 0001

05:07.1 0c00: 104c:803a (prog-if 10 [OHCI])
	Subsystem: 104c:8023
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at b3201000 (32-bit, non-prefetchable) [size=3D2K]
	Memory at b3204000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: [44] Power Management version 2

05:07.2 0180: 104c:803b
	Subsystem: 1558:0661
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at b3202000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2

05:07.3 0805: 104c:803c (prog-if 01)
	Subsystem: 1558:0661
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at b3201800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2

output lsmod:
<snip>
snd_hda_intel          23708  1 =

snd_hda_codec         184192  1 snd_hda_intel
snd_pcm_oss            48672  0 =

snd_mixer_oss          21888  2 snd_pcm_oss
snd_pcm                88968  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
sdhci                  23180  0 =

snd_timer              29192  1 snd_pcm
rsrc_nonstatic         16384  1 yenta_socket
pcmcia_core            47012  3 pcmcia,yenta_socket,rsrc_nonstatic
psmouse                44432  0 =

snd                    65256  6 snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd=
_mixer_oss,snd_pcm,snd_timer
i2c_nforce2            12544  0 =

</snip>

/etc/modules.conf:
<snip>
### update-modules: end processing /etc/modutils/aliases

### update-modules: start processing /etc/modutils/alsa-base
# autoloader aliases

options snd-intel8x0 ac97_quirk=3Dhp_only =

options snd-hda-intel model=3D3stack-dig # I tried all other options too;

alias char-major-116 snd
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3
</snip>

restarting alsa-utils show:
> /etc/init.d/alsa-utils restart
Shutting down ALSA...warning: 'alsactl store' failed with error message 'al=
sactl: get_control:209: Cannot read control info '2,0,0,Surround Playback V=
olume,0': Invalid argument'...amixer: Mixer hw:0 load error: Invalid argume=
nt
amixer: Mixer hw:0 load error: Invalid argument
...
amixer: Mixer hw:0 load error: Invalid argument
failed.
Setting up ALSA...warning: 'alsactl restore' failed with error message 'als=
actl: set_control:970: failed to obtain info for control #3 (Invalid argume=
nt)'...amixer: Mixer hw:0 load error: Invalid argument
amixer: Mixer hw:0 load error: Invalid argument
...
amixer: Mixer hw:0 load error: Invalid argument
done.



Thanx,
Harald
_______________________________________________________________________
Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=3D022222


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
