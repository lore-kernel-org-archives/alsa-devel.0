From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: problems with Maestro3 / NEC LM800J/7
Date: 01 Apr 2003 20:25:51 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049257551.28815.7.camel@cmn37.Stanford.EDU>
References: <1048897747.2386.64.camel@cmn37.Stanford.EDU>
	<1048899509.2386.76.camel@cmn37.Stanford.EDU>
	<s5h7kagj6cl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-i6+3kBe201iIQRINbi+8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kagj6cl.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, rsegnini@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org


--=-i6+3kBe201iIQRINbi+8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > > Hi gurus... I'm having problems getting sound out of this laptop:
> > >   NEC LM800J/7
> > > I'm using 2.4.20-pre6 + current alsa cvs (post 0.9.2)... After
> > > installing everything is fine, drivers load perfectly, I unmute all
> > > controls, raise all volumes and aplay seems happy playing a soundfile,
> > > except I get no sound (from the speakers or the headphone connection). I
> > > tried tweaking all controls in gamix with no success...
> > 
> > For future reference: I started playing with the module options and got
> > it to work when loading with:
> > 
> >   amp_gpio=3
> 
> great that you already found the solution.
> 
> could you give the output of lspci -nv to add this device entry to the
> quirk list?  at the next update, the driver should work without this
> option.

Sure, it is attached to this email (the owner of the laptop just sent it
to me - thanks Rodrigo)...

-- Fernando


--=-i6+3kBe201iIQRINbi+8
Content-Disposition: attachment; filename=lspci.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=lspci.txt; charset=ISO-8859-1

00:00.0 Class 0600: 8086:7190 (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 Class 0604: 8086:7191 (rev 03)
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fc100000-fdffffff

00:04.0 Class 0401: 125d:1988 (rev 12)
	Subsystem: 1033:80f1
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 1400 [size=3D256]
	Capabilities: [c0] Power Management version 2

00:06.0 Class 0200: 8086:1229 (rev 09)
	Subsystem: 8086:2411
	Flags: bus master, medium devsel, latency 66, IRQ 10
	Memory at fc020000 (32-bit, non-prefetchable) [size=3D4K]
	I/O ports at 1080 [size=3D64]
	Memory at fc000000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D1M]
	Capabilities: [dc] Power Management version 2

00:06.1 Class 0700: 115d:00d3 (prog-if 02)
	Subsystem: 8086:2411
	Flags: medium devsel, IRQ 10
	I/O ports at 1068 [size=3D8]
	Memory at fc021000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2

00:07.0 Class 0601: 8086:7110 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 Class 0101: 8086:7111 (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1070 [size=3D16]

00:07.2 Class 0c03: 8086:7112 (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 10c0 [size=3D32]

00:07.3 Class 0680: 8086:7113 (rev 03)
	Flags: medium devsel, IRQ 9

00:0c.0 Class 0607: 104c:ac51
	Subsystem: 1033:80cd
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0c.1 Class 0607: 104c:ac51
	Subsystem: 1033:80cd
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at 10001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D06, subordinate=3D09, sec-latency=3D176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:0d.0 Class 0c00: 1033:00ce (rev 01) (prog-if 10)
	Subsystem: 1033:00ce
	Flags: medium devsel, IRQ 10
	Memory at fc022000 (32-bit, non-prefetchable) [disabled] [size=3D4K]
	Capabilities: [60] Power Management version 2

01:00.0 Class 0300: 1002:4c4d (rev 64)
	Subsystem: 1033:80b7
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 10
	Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
	I/O ports at 2000 [size=3D256]
	Memory at fc100000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1


--=-i6+3kBe201iIQRINbi+8--



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
