From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000650]: emu10k1 load fail with CT4760 SBLive! OEM
Date: Mon, 15 Nov 2004 15:41:38 +0100
Message-ID: <c2e6b9c2a27e63db97e20f018c47d117@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 19BCD28E
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2004 15:41:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=650> 
======================================================================
Reported By:                pancogi
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   650
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.27
======================================================================
Date Submitted:             11-15-2004 11:59 CET
Last Modified:              11-15-2004 15:41 CET
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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
