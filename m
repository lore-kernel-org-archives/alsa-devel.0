From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000796]: Behavior of LED on mute button
Date: Wed, 19 Jan 2005 17:38:07 +0100
Message-ID: <a0c68a33c6348a936f13e5b07c325ec7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F2BF26D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 17:38:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=796> 
======================================================================
Reported By:                kempokaraterulz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   796
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-09-2005 02:26 CET
Last Modified:              01-19-2005 17:38 CET
======================================================================
Summary:                    Behavior of LED on mute button
Description: 
On my laptop, there is this little blue LED on the mute button, muting  /
unmuting the sound doesnt have any effect on this LED currently, if i
unload the sound module the LED turns on, and if i reload the sound module
it turns back off. Since the sound driver turns the light on when being
unloaded, my (possibly incorrect) guess is that this would be a fairly
easy thing to implement properly, or at least allow control of the light
through the proc interface or something. 
======================================================================

----------------------------------------------------------------------
 tiwai - 01-11-05 12:11 
----------------------------------------------------------------------
Oh I forgot that atiixp still doesn't have this option.
Try the attached patch.
Also, please show the output of lspci -nv.

----------------------------------------------------------------------
 kempokaraterulz - 01-19-05 17:38 
----------------------------------------------------------------------
Sorry for the delay here -- got in a car accident the other day and i
havent had time to mess with alsa at all till now. I see your patch is in
the new alsa release -- and passing ac97_quirk=mute_led solves the
problem. I suspect you only need the sound portion of my lspci -nv but
here is the entire thing in case you need other parts of it:

HPimp alsa-driver-1.0.8 # lspci -nv
0000:00:00.0 Class 0600: 1002:5833 (rev 02)
        Subsystem: 1002:1234
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Memory at f6000000 (32-bit, prefetchable)
        Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [a0] AGP version 3.0

0000:00:01.0 Class 0604: 1002:5838
        Flags: bus master, 66Mhz, medium devsel, latency 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f4100000-f41fffff
        Prefetchable memory behind bridge: f8000000-fbffffff
        Expansion ROM at 00009000 [disabled] [size=4K]

0000:00:13.0 Class 0c03: 1002:4347 (rev 01) (prog-if 10)
        Subsystem: 1002:434c
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
        Memory at f4001000 (32-bit, non-prefetchable)

0000:00:13.1 Class 0c03: 1002:4348 (rev 01) (prog-if 10)
        Subsystem: 1002:434c
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
        Memory at f4002000 (32-bit, non-prefetchable)

0000:00:14.0 Class 0c05: 1002:4353 (rev 16)
        Subsystem: 103c:006b
        Flags: 66Mhz, medium devsel
        I/O ports at 8040
        Memory at 1f000000 (32-bit, non-prefetchable) [size=1K]

0000:00:14.1 Class 0101: 1002:4349 (prog-if 8a [Master SecP PriP])
        Subsystem: 103c:006b
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8060 [size=16]

0000:00:14.3 Class 0601: 1002:434c
        Subsystem: 1002:434c
        Flags: bus master, 66Mhz, medium devsel, latency 0

0000:00:14.4 Class 0604: 1002:4342 (prog-if 01)
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=69
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f4200000-f42fffff

0000:00:14.5 Class 0401: 1002:4341
        Subsystem: 103c:006b
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
        Memory at f4003000 (32-bit, non-prefetchable)

0000:00:14.6 Class 0703: 1002:434d (rev 01)
        Subsystem: 103c:006b
        Flags: 66Mhz, slow devsel, IRQ 5
        Memory at f4003400 (32-bit, non-prefetchable)

0000:01:05.0 Class 0300: 1002:5835
        Subsystem: 103c:006b
        Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency
66, IRQ 16
        Memory at f8000000 (32-bit, prefetchable)
        I/O ports at 9000 [size=256]
        Memory at f4100000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

0000:02:00.0 Class 0c00: 104c:8026 (prog-if 10)
        Subsystem: 103c:006b
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at f4208000 (32-bit, non-prefetchable)
        Memory at f4200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:02:02.0 Class 0280: 14e4:4320 (rev 03)
        Subsystem: 103c:12f4
        Flags: bus master, fast devsel, latency 64, IRQ 18
        Memory at f4204000 (32-bit, non-prefetchable)

0000:02:03.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 103c:006b
        Flags: bus master, medium devsel, latency 128, IRQ 19
        I/O ports at a000
        Memory at f4208800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:02:04.0 Class 0607: 104c:ac54 (rev 01)
        Subsystem: 103c:006b
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at 1f001000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

0000:02:04.1 Class 0607: 104c:ac54 (rev 01)
        Subsystem: 103c:006b
        Flags: medium devsel, IRQ 10
        Memory at 1f002000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

0000:02:04.2 Class 0880: 104c:8201 (rev 01)
        Subsystem: 103c:006b
        Flags: bus master, medium devsel, latency 64
        I/O ports at a400
        Capabilities: [44] Power Management version 2

0000:02:07.0 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 1033:0035
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at f4206000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

0000:02:07.1 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 1033:0035
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at f4207000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

0000:02:07.2 Class 0c03: 1033:00e0 (rev 04) (prog-if 20)
        Subsystem: 1033:00e0
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at f4208c00 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

The machine is an HP Pavilion ZV5030US

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 02:26 kempokaraterulzNew Issue                                    
01-10-05 14:59 tiwai          Note Added: 0003135                          
01-10-05 23:17 kempokaraterulzNote Added: 0003140                          
01-11-05 12:11 tiwai          Note Added: 0003143                          
01-11-05 12:12 tiwai          File Added: atiixp-add-quirk.diff                 
  
01-19-05 17:38 kempokaraterulzNote Added: 0003307                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
