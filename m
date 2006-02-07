From: Victor Porton <porton@ex-code.com>
Subject: dxs_support=5 testing result
Date: Wed, 08 Feb 2006 01:49:13 +0500 (YEKT)
Message-ID: <E1F6Zly-0001Tu-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am not a musician but for my ears it seems that dxs_support=3D5 works q=
uite
well on my system.

As a side note: With my (the most cheap) microphone the volume of the
audio files recorded using the microphone is very much too low. Maximizin=
g
"Microphone" and "IGain" volumes (using Gnome Volume Control) does not
solve the problem. (IGain seem to not influence it at all.) So I need to
purchase a "electronic signal volume increaser" (I do not know how to say
this in English) just to use the microphone? :-(

ASRock P4VM800

$ lspci -nv

00:00.0 Class 0600: 1106:0314
        Subsystem: 1849:0314
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: <available only to root>

00:00.1 Class 0600: 1106:1314
        Subsystem: 1849:1314
        Flags: bus master, medium devsel, latency 0

00:00.2 Class 0600: 1106:2314
        Subsystem: 1849:2314
        Flags: bus master, medium devsel, latency 0

00:00.3 Class 0600: 1106:3208
        Flags: bus master, medium devsel, latency 0

00:00.4 Class 0600: 1106:4314
        Subsystem: 1849:4314
        Flags: bus master, medium devsel, latency 0

00:00.7 Class 0600: 1106:7314
        Subsystem: 1849:7314
        Flags: bus master, medium devsel, latency 0

00:01.0 Class 0604: 1106:b198
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: eff00000-f7efffff
        Secondary status: SERR
        Capabilities: <available only to root>

00:0b.0 Class 0780: 14f1:10b6 (rev 89)
        Subsystem: 14f1:10b6
        Flags: bus master, medium devsel, latency 32, IRQ 225
        Memory at febe0000 (32-bit, non-prefetchable) [size=3D64K]
        I/O ports at bc00 [size=3D8]
        Capabilities: <available only to root>

00:0f.0 Class 0104: 1106:3149 (rev 80)
        Subsystem: 1849:3149
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at ec00 [size=3D8]
        I/O ports at e800 [size=3D4]
        I/O ports at e400 [size=3D8]
        I/O ports at e000 [size=3D4]
        I/O ports at dc00 [size=3D16]
        I/O ports at d800 [size=3D256]
        Capabilities: <available only to root>

00:0f.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1849:0571
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at fc00 [size=3D16]
        Capabilities: <available only to root>

00:10.0 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1849:3038
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at c000 [size=3D32]
        Capabilities: <available only to root>

00:10.1 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1849:3038
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at c400 [size=3D32]
        Capabilities: <available only to root>

00:10.2 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1849:3038
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at c800 [size=3D32]
        Capabilities: <available only to root>

00:10.3 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1849:3038
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at cc00 [size=3D32]
        Capabilities: <available only to root>

00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
        Subsystem: 1849:3104
        Flags: bus master, medium devsel, latency 32, IRQ 193
        Memory at febff800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: <available only to root>

00:11.0 Class 0601: 1106:3227
        Subsystem: 1849:3227
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1849:9761
        Flags: medium devsel, IRQ 185
        I/O ports at d000 [size=3D256]
        Capabilities: <available only to root>

00:12.0 Class 0200: 1106:3065 (rev 78)
        Subsystem: 1849:3065
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at d400 [size=3D256]
        Memory at febffc00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: <available only to root>

01:00.0 Class 0300: 1106:3344 (rev 01)
        Subsystem: 1849:3344
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 169
        Memory at f0000000 (32-bit, prefetchable) [size=3D64M]
        Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
        Expansion ROM at feaf0000 [disabled] [size=3D64K]
        Capabilities: <available only to root>



--=20
Victor Porton (porton@ex-code.com) - http://porton.ex-code.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
