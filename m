From: Russ Pridemore <russ.pridemore@comcast.net>
Subject: Re: Chaintech AV710
Date: Sun, 12 Dec 2004 14:05:22 -0500
Message-ID: <1102878321.8947.21.camel@localhost>
References: <Pine.HPX.4.33n.0412081858390.21064-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0412081858390.21064-100000@studcom.urz.uni-halle.de>
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

On Wed, 2004-12-08 at 13:00, Clemens Ladisch wrote:
> Russ Pridemore wrote:
> > I have a Chaintech AV710 (Envy24HT) card
> 
> The driver doesn't know about this model.
> 
> >  ice1724: Invalid EEPROM version 1
> >
> > 0 [AUDIO2000      ]: ICE1724 - AMP Ltd AUDIO2000
> 
> This has the same PCI ID as the AUDIO2000 card, so it isn't detected
> correctly.
> 
> Please show the contents of /proc/asound/card0/ice1724 and the output
> of "lspci -nv" for this device.
> 
> 
> Clemens
> 
Sorry for the delay.  Been a very busy week!  Ok, the PCI ID explains a
lot.

# cat /proc/asound/card0/ice1724
AMP Ltd AUDIO2000 at 0x9000, irq 169

EEPROM:
  Subvendor        : 0x12142417
  Size             : 28 bytes
  Version          : 1
  System Config    : 0x2
  ACLink           : 0x2
  I2S              : 0x10
  S/PDIF           : 0xc1
  GPIO direction   : 0xff
  GPIO mask        : 0xff
  GPIO state       : 0xff
  Extra #18        : 0x1
  Extra #19        : 0x0
  Extra #20        : 0x0
  Extra #21        : 0x0
  Extra #22        : 0x0
  Extra #23        : 0x0
  Extra #24        : 0x0
  Extra #25        : 0x0
  Extra #26        : 0x0
  Extra #27        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x02
  CCS05    : 0x02
  CCS06    : 0x10
  CCS07    : 0xc1
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x12
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0xaa
  CCS16    : 0xff
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0x00
  CCS1a    : 0x00
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x2a
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x08
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x5a
  MT05     : 0x08
  MT06     : 0x21
  MT07     : 0x82
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x20
  MT11     : 0x04
  MT12     : 0x3b
  MT13     : 0x1c
  MT14     : 0xf7
  MT15     : 0x3e
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x03
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0xff
  MT1d     : 0x0f
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

# lspci -nv
0000:00:00.0 Class 0600: 1106:3188 (rev 01)
        Subsystem: 1106:3188
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [80] AGP version 3.0
        Capabilities: [c0] #08 [0060]
        Capabilities: [68] Power Management version 2
        Capabilities: [58] #08 [8001]

0000:00:01.0 Class 0604: 1106:b188
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: [80] Power Management version 2

0000:00:09.0 Class 0401: 1412:1724 (rev 01)
        Subsystem: 1412:1724
        Flags: bus master, medium devsel, latency 32, IRQ 169
        I/O ports at 9000
        I/O ports at 9400 [size=128]
        Capabilities: [80] Power Management version 1

0000:00:0a.0 Class 0400: 4444:0016 (rev 01)
        Subsystem: 0070:4009
        Flags: bus master, medium devsel, latency 64, IRQ 177
        Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [44] Power Management version 2

0000:00:0b.0 Class 0400: 14f1:8800 (rev 05)
        Subsystem: 7063:3000
        Flags: bus master, medium devsel, latency 32, IRQ 185
        Memory at e6000000 (32-bit, non-prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:00:0b.2 Class 0480: 14f1:8802 (rev 05)
        Subsystem: 7063:3000
        Flags: bus master, medium devsel, latency 32, IRQ 185
        Memory at e7000000 (32-bit, non-prefetchable)
        Capabilities: [4c] Power Management version 2

0000:00:0f.0 Class 0104: 1106:3149 (rev 80)
        Subsystem: 1458:b003
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at 9800
        I/O ports at 9c00 [size=4]
        I/O ports at a000 [size=8]
        I/O ports at a400 [size=4]
        I/O ports at a800 [size=16]
        I/O ports at ac00 [size=256]
        Capabilities: [c0] Power Management version 2

0000:00:0f.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP
PriP])
        Subsystem: 1458:5002
        Flags: bus master, medium devsel, latency 32, IRQ 193
        I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2

0000:00:10.0 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.1 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.2 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at bc00 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.3 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 201
        Memory at e8000000 (32-bit, non-prefetchable)
        Capabilities: [80] Power Management version 2

0000:00:11.0 Class 0601: 1106:3227
        Subsystem: 1458:5001
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

0000:00:13.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 1458:e000
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at c400
        Memory at e8001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:00:18.0 Class 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

0000:00:18.1 Class 0600: 1022:1101
        Flags: fast devsel

0000:00:18.2 Class 0600: 1022:1102
        Flags: fast devsel

0000:00:18.3 Class 0600: 1022:1103
        Flags: fast devsel

0000:01:00.0 Class 0300: 10de:0322 (rev a1)
        Subsystem: 1458:3103
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 209
        Memory at e4000000 (32-bit, non-prefetchable)
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

The sound card is on IRQ 169:
# cat /proc/asound/cards
0 [AUDIO2000      ]: ICE1724 - AMP Ltd AUDIO2000
                     AMP Ltd AUDIO2000 at 0x9000, irq 169




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
