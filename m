From: noreply@alsa-project.org
Subject: [ALSA - driver 0000249]: Unable to detect HDSP card
Date: Fri, 16 Jul 2004 12:56:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105626.490F226008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9A297244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:56:26 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000249
======================================================================
Reported By:                winty
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     249
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               SuSE
Kernel Version:             2.4.21
======================================================================
Date Submitted:             05-01-2004 20:48 CEST
Last Modified:              07-16-2004 12:56 CEST
======================================================================
Summary:                    Unable to detect HDSP card
Description: 
I have a RME HDSP9632 card revision 0x97 which is working fine in Windows. 
I've tried it on 2 different PCs under SuSE Linux and am unable to load
the snd-hdsp driver.  I am wondering if it's the relatively recent
firmware (151) that is causing it to not be detected.  When attempting to
modprobe snd-hdsp I get:

/lib/modules/2.4.21-202-athlon/kernel/sound/pci/rme9652/snd-hdsp.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
     You may find more information in syslog or the output from dmesg
/lib/modules/2.4.21-202-athlon/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
/lib/modules/2.4.21-202-athlon/kernel/sound/pci/rme9652/snd-hdsp.o failed
/lib/modules/2.4.21-202-athlon/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
snd-hdsp failed

When checking /var/log/messages I see:

Apr 29 23:49:48 biglinux kernel: RME Hammerfall-DSP: no cards found

lspci -vv produces:

00:0a.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP
(rev 97)
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 255
       Interrupt: pin A routed to IRQ 5
       Region 0: Memory at dfff0000 (32-bit, non-prefetchable) [size=64K] 
======================================================================

----------------------------------------------------------------------
 winty - 05-03-2004 00:30 CEST 
----------------------------------------------------------------------
I discovered that hdsp.c seems to detect the card type by the firmware
revision number.  It's currently identifying HDSP9632 cards with a
revision of 0x96 so I added 0x97 to the case statements.  Now I can load
snd-hdsp at least, but it's not working yet.  I was also able to run the
hdspmixer which looks wonderful.

What a tantalising taste.... I'm going to keep trying to get this working,
but nonetheless any help would be gratefully appreciated.

----------------------------------------------------------------------
 winty - 05-03-2004 01:17 CEST 
----------------------------------------------------------------------
Well I've got working sound through the HDSP now and your wonderful
hdspmixer works too.  I'm really delighted.  Thank you for all your
wonderful work on this.  The only thing missing from Totalmix is the
ability to "gang" 2 faders together so that you can fade both sides of the
stereo up and down at the same level.

For some reason XMMS doesn't seem to work through the ALSA driver, but it
does work through libarts.so, whatever that is :/

I'm sure I'll iron the rest out anyway.  Thanks again.

----------------------------------------------------------------------
 perex - 05-03-2004 11:02 CEST 
----------------------------------------------------------------------
Added version 0x97 to CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-01-04 20:48 winty          New Bug                                      
05-01-04 20:48 winty          Distribution              => SuSE            
05-01-04 20:48 winty          Kernel Version            => 2.4.21          
05-01-04 20:49 winty          Bug Monitored: winty                         
05-03-04 00:30 winty          Bugnote Added: 0001016                       
05-03-04 01:17 winty          Bugnote Added: 0001019                       
05-03-04 11:01 perex          Status                   assigned => resolved
05-03-04 11:02 perex          Bugnote Added: 0001021                       
05-03-04 11:02 perex          Assigned To              charbonnel => perex 
05-03-04 11:02 perex          Resolution               open => fixed       
07-16-04 12:56 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
