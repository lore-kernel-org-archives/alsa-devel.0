From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000650]: emu10k1 load fail with CT4760 SBLive! OEM
Date: Tue, 22 Feb 2005 09:30:21 +0100
Message-ID: <a6bc58bf20ba4f51eb213b30e981db2b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F0CEE174
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:30:21 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=650> 
======================================================================
Reported By:                pancogi
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   650
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.27
======================================================================
Date Submitted:             11-15-2004 11:59 CET
Last Modified:              02-22-2005 09:30 CET
======================================================================
Summary:                    emu10k1 load fail with CT4760 SBLive! OEM
Description: 
hi
my Sb Live do not work with emu10k1, lspci -v say:

0000:00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 08)
        Subsystem: Creative Labs CT4760 SBLive! OEM version
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d800 [size=32]
        Capabilities: [dc] Power Management version 2

lspci -n, say:

0000:00:0d.0 Class 0401: 1102:0002 (rev 08)

dmesg after modprobe snd-emu10k1,

PCI: Found IRQ 5 for device 00:0d.0
ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1905: AC'97 0 does not
respond - RESET
ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1913: AC'97 0 access is not
valid [0x0], removing mixer.

dmesg after modprobe oss modules emu10k1, say:

emu10k1: EMU10K1 rev 8 model 0x8028 found, IO at 0xd800-0xd81f, IRQ 5
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

but no sound output.
with kernel 2.6.9, the same.

thanks,
giovanni.
======================================================================

----------------------------------------------------------------------
 pancogi - 11-15-04 12:20 
----------------------------------------------------------------------
excuse me for my(?) error.
it is not a compilation error.
the module fail to load and go.

----------------------------------------------------------------------
 pzad - 11-15-04 12:53 
----------------------------------------------------------------------
Wow.

Works this card under windows or other os ???

For me looks like hardware problem (if oss driver doesn't work too).

You can try dissable AC97 detection in alsa drivers, but this will
probably give you sound only on rear outputs and you will not have analog
inputs.

----------------------------------------------------------------------
 pancogi - 11-15-04 13:30 
----------------------------------------------------------------------
hum, hem...
windows (98,xp) ==> blue screen...

how can i disable AC97 detection?
without ac97 can i control volume?
mixer exist?

thanks...

----------------------------------------------------------------------
 pzad - 11-15-04 13:45 
----------------------------------------------------------------------
>windows (98,xp) ==> blue screen...

Then this is hardware fault.

To dissable AC97 you need change driver source - search for 
emu->no_ac97 = 1; 
in emu10k1_main.c

and add it before this line (sorry <------------- my mistake)
if (emu->revision == 4 && emu->model == 0x2002) { 

With this driver should load, but you will be able only use rear (through
rear device) speakers output and you will not have analog inputs and mixer
will be very limited.

I will recomend to swap soundcard.

edited on: 11-15-04 13:45

----------------------------------------------------------------------
 pancogi - 11-15-04 15:07 
----------------------------------------------------------------------
ok, source modified, compiled.

now module snd-emu10k1 is loaded, and alsamixer show me some control.
the pc is far from me, and now i can't hear sound, may be this evening.
if you want report from /proc/asound, ask

perhaps i can find a sister of this CT4760 working, and try if is a true
hardware problem.

> will recomend to swap soundcard.

thanks, which one?

anyhow, thanks a lot, and forgive my english.

----------------------------------------------------------------------
 pzad - 11-15-04 15:41 
----------------------------------------------------------------------
> thanks, which one?

Working one. :-)

This card looks damaged.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-15-04 11:59 pancogi        New Issue                                    
11-15-04 11:59 pancogi        Kernel Version            => 2.4.27          
11-15-04 12:20 pancogi        Note Added: 0002411                          
11-15-04 12:47 pancogi        Issue Monitored: pancogi                     
11-15-04 12:53 pzad           Note Added: 0002412                          
11-15-04 13:30 pancogi        Note Added: 0002413                          
11-15-04 13:43 pzad           Note Added: 0002414                          
11-15-04 13:45 pzad           Note Edited: 0002414                         
11-15-04 15:07 pancogi        Note Added: 0002415                          
11-15-04 15:41 pzad           Note Added: 0002416                          
02-22-05 09:30 perex          Assigned To              perex => pzad       
02-22-05 09:30 perex          Category                 0_compilation problem_!!!
=> PCI - emu10k1
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
