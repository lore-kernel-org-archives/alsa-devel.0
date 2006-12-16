From: "tardo2002@libero.it" <tardo2002@libero.it>
Subject: (no subject)
Date: Sat, 16 Dec 2006 15:17:49 +0100
Message-ID: <JADEDP$7B7661E86B7825A8ECA7FB5E915275AF@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, I am an italian linux user. I have a serious noise problem with my integrated sound card (VIA8237, 5.1 channels AC'97 audio) on my Asrock motherboard (P4VT8). 

Follow my lspci -nv:

00:00.0 0600: 1106:3168 (rev 82)
	Subsystem: 1849:3168
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

00:01.0 0604: 1106:b198
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: bfd00000-dfcfffff
	Capabilities: [80] Power Management version 2

00:0b.0 0780: 14f1:2f00 (rev 01)
	Subsystem: 14f1:2004
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at dffe0000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at d400 [size=8]
	Capabilities: [40] Power Management version 2

00:0f.0 0104: 1106:3149 (rev 80)
	Subsystem: 1849:3149
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.1 0101: 1106:0571 (rev 06) (prog-if 8a)
	Subsystem: 1849:0571
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

00:10.0 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1849:3104
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at dfffbe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 0601: 1106:3227
	Subsystem: 1849:3227
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 1849:9739
	Flags: medium devsel, IRQ 19
	I/O ports at c000 [size=256]
	Capabilities: [c0] Power Management version 2

00:12.0 0200: 1106:3065 (rev 78)
	Subsystem: 1849:3065
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at bc00 [size=256]
	Memory at dfffbd00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 0300: 1002:5964 (rev 01)
	Subsystem: 174b:7c26
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 20
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a800 [size=256]
	Memory at dfef0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dfec0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
	Capabilities: [50] Power Management version 2

01:00.1 0380: 1002:5d44 (rev 01)
	Subsystem: 174b:7c27
	Flags: bus master, 66MHz, medium devsel, latency 32
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2


My problem is: when I am listening to some audio file, sound stream is disturbed by a strong noise component. This noise component, in my opinion, is strange becouse it follow rhythm of sound stream and there is both when PCM volume is 0 (but turned on) even PCM volume is high! I red documentation about alsa module snd-via82xx (chosen and loaded automatically by alsaconfig script) and I tried to change dxs_support option from 0 to 5 and other options. I tried to change any volumes, set 'on' just PCM and other tests in alsamixer. I did not found any solution in some forums. I tried different alsa versions, kernel versions, linux distributions, multimedia programs, OSS emulation, output jack of sound card and headphones, but my result is been always the same: NOISE!
I think it is not a hardware problem, becouse card work fine in Windows OS. It is possible to manage channels (sometimes usefull) and other enviroment effects (useless).
You are my last hope, before to buy the simplest pci sound card that work in linux.

Can you list me any kind of tests and tricks to solve my problem, most stupid too? (it is probable I forget to do something else or I don't know some deep tests or tricks)

Thanks for your good work


------------------------------------------------------
Passa a Infostrada. ADSL e Telefono senza limiti e senza canone Telecom
http://click.libero.it/infostrada16dic06



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
