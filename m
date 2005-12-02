From: Ivan Baldo <ibaldo@adinet.com.uy>
Subject: snd-via82xx dxs_support=5 works but uses 3 by default.
Date: Thu, 01 Dec 2005 22:25:37 -0200
Message-ID: <438F9481.8060907@adinet.com.uy>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010004090705060206090009"
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

This is a multi-part message in MIME format.
--------------010004090705060206090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    Hello.
    Well, my kernel told me to try dxs_support=5 and read 
ALSA-Configuration, which I did.
    It works and sounds good, I verified it is working with 44100 with 
hw_params of all 4 subdevices (only 1 opened and it says 44100 with 
dxs_support=5 and 48000 with dxs_support=0 or 3).
    I will not try to be smart and better send you all the output of 
lspci -nv without striping anything.
    Thanks for everything and if you need something else from me don't 
hesitate.

P.s.: vanilla 2.4.14.3 kernel (only NVidia module as an extra).


-- 
Ivan Baldo - ibaldo@adinet.com.uy - http://ibaldo.codigolibre.net/
ICQ 10215364 - Phone/FAX (598) (2) 613 3223.
Caldas 1781, Malvin, Montevideo, Uruguay, South America, planet Earth.
In favour of world peace and freedom, against U.S.A. and allies!!!
Alternatives: ibaldo@codigolibre.net - http://go.to/ibaldo


--------------010004090705060206090009
Content-Type: text/plain;
 name="lspci_nv.via.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_nv.via.txt"

0000:00:00.0 0600: 1106:3189 (rev 80)
	Subsystem: 1849:3189
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

0000:00:01.0 0604: 1106:b198
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdd00000-ddcfffff
	Capabilities: [80] Power Management version 2

0000:00:0f.0 0104: 1106:3149 (rev 80)
	Subsystem: 1849:3149
	Flags: bus master, medium devsel, latency 32, IRQ 169
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2

0000:00:0f.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1849:0571
	Flags: bus master, medium devsel, latency 32, IRQ 169
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:10.0 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 0c03: 1106:3038 (rev 81)
	Subsystem: 1849:3038
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1849:3104
	Flags: bus master, medium devsel, latency 32, IRQ 177
	Memory at dfffbe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

0000:00:11.0 0601: 1106:3227
	Subsystem: 1849:3227
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 1849:9761
	Flags: medium devsel, IRQ 193
	I/O ports at c400 [size=256]
	Capabilities: [c0] Power Management version 2

0000:00:12.0 0200: 1106:3065 (rev 78)
	Subsystem: 1849:3065
	Flags: bus master, medium devsel, latency 32, IRQ 185
	I/O ports at c000 [size=256]
	Memory at dfffbd00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:01:00.0 0300: 10de:0322 (rev a1)
	Subsystem: 1682:1351
	Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 201
	Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 3.0


--------------010004090705060206090009--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
