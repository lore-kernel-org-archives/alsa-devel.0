From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Tue, 20 Jun 2006 23:30:47 +0200
Message-ID: <9ef2a76d2ef948c09f3c3d5c578b70c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D156818C
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 23:30:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2219> 
======================================================================
Reported By:                El Santo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2219
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian etch (2006-06-18)
Kernel Version:             2.6.15-1-686
======================================================================
Date Submitted:             06-18-2006 17:41 CEST
Last Modified:              06-20-2006 23:30 CEST
======================================================================
Summary:                    snd-mpu401 don't load
Description: 
I have a Aopen MX63LE board with onboard sound managed by snd-via82xx
driver. It loads all necesary modules, includind snd-mpu401-uart, but no
snd-mpu401
The audio part of the driver works perfectly, but the midi port doesn't
work.

In BIOS i can set (and see) the mpu401 port (0x300 or 0x330) but there is
not a MPU401 IRQ setting in bios. When i tried to manually load snd-mpu401
(setting the port accordingly to BIOS) it doesnt work. I don't know the
mpu401 irq setting but i tryed them all. None of them worked. The driver
says "device not found".

Under windows xp the port works perfectly, so the hardware is ok. Anyway
under windows xp, i use a "system inspector" to monitor ioports and irq
usage, and i didnt see any irq assigned for mpu401 port, and the port
(0x330) wasn't occupied neither.

any idea?
======================================================================

----------------------------------------------------------------------
 tiwai - 06-20-06 19:49 
----------------------------------------------------------------------
Usually snd-mpu401 can be loaded without module options using ACPI PnP.

----------------------------------------------------------------------
 El Santo - 06-20-06 23:30 
----------------------------------------------------------------------
Hi again!

My message had a typo: the motherboard is not AOpen MX63LE, but AOpen
MX36LE.

I also tryed to load the module without parameters....

modprobe snd-mpu401

FATAL: Error inserting snd_mpu401
(/lib/modules/2.6.15-1-686/kernel/sound/drivers/mpu401/snd-mpu401.ko): No
such device
FATAL: Error running install command for snd_mpu401

... and a "MPU-401 device not found or device busy" is added to syslog

the outputs of the commands:

------------------
aplaymidi -l

 Port    Client name                      Port name
 62:0    Midi Through                     Midi Through Port-0
------------------
cat /proc/asound/cards

0 [rev50          ]: VIA686A - VIA 82C686A/B rev50
                     VIA 82C686A/B rev50 with AD1885 at 0xdc00, irq 10
------------------
lspci -vn

0000:00:00.0 0600: 1106:0601 (rev 05)
        Flags: bus master, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

0000:00:01.0 0604: 1106:8601
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e4000000-e6ffffff
        Prefetchable memory behind bridge: 20000000-200fffff
        Capabilities: <available only to root>

0000:00:07.0 0601: 1106:0686 (rev 40)
        Subsystem: 1106:0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

0000:00:07.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1106:0571
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: <available only to root>

0000:00:07.2 0c03: 1106:3038 (rev 1a)
        Subsystem: 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d400 [size=32]
        Capabilities: <available only to root>

0000:00:07.3 0c03: 1106:3038 (rev 1a)
        Subsystem: 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d800 [size=32]
        Capabilities: <available only to root>

0000:00:07.4 0680: 1106:3057 (rev 40)
        Subsystem: 1106:3057
        Flags: medium devsel, IRQ 9
        Capabilities: <available only to root>

0000:00:07.5 0401: 1106:3058 (rev 50)
        Subsystem: 11d4:5360
        Flags: medium devsel, IRQ 10
        I/O ports at dc00 [size=256]
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=4]
        Capabilities: <available only to root>

0000:00:09.0 0200: 10b7:9200 (rev 78)
        Subsystem: 10b7:1000
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec00 [size=128]
        Memory at e8000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 20100000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:00:0f.0 0400: 109e:036e (rev 11)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e8001000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:0f.1 0480: 109e:0878 (rev 11)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e8002000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:01:00.0 0300: 1023:8500 (rev 6a)
        Subsystem: 1023:8500
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        Memory at e5800000 (32-bit, non-prefetchable) [size=8M]
        Memory at e6000000 (32-bit, non-prefetchable) [size=128K]
        Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 20000000 [disabled] [size=64K]
        Capabilities: <available only to root>

------------------

Regards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 17:41 El Santo       New Issue                                    
06-18-06 17:41 El Santo       Distribution              => Debian etch
(2006-06-18)
06-18-06 17:41 El Santo       Kernel Version            => 2.6.15-1-686    
06-19-06 03:45 Raymond        Note Added: 0010305                          
06-20-06 19:49 tiwai          Note Added: 0010349                          
06-20-06 23:30 El Santo       Note Added: 0010357                          
======================================================================
