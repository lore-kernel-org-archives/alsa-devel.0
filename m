From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000472]: Built-in soundcard on Soltek SL-75DRV5 motherboard works only with ac97_quirk=0 option.
Date: Tue, 9 Nov 2004 16:15:13 +0100
Message-ID: <cdd57479f0fab68375aa4b98a6cd9d85@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 888CA244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:15:13 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=472> 
======================================================================
Reported By:                Dawid Gajownik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   472
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-29-2004 21:34 CEST
Last Modified:              11-09-2004 16:15 CET
======================================================================
Summary:                    Built-in soundcard on Soltek SL-75DRV5 motherboard
works only with ac97_quirk=0 option.
Description: 
Built-in soundcard on Soltek SL-75DRV5 motherboard works only with
ac97_quirk=0 option. This mobo has VIA VT8233A southbridge (snd-via82xx
ALSA kernel module).

Is there any possibility, that it would be set up automatically by the
alsa driver? (I'm not a programmer, but I've seen some ac97_quirk
structure in via82xx.c source file).
======================================================================

----------------------------------------------------------------------
 tiwai - 09-03-04 16:06 
----------------------------------------------------------------------
Try the attached patch.

----------------------------------------------------------------------
 Dawid Gajownik - 09-03-04 23:09 
----------------------------------------------------------------------
Hi!

That's me again ;) I patched the source and installed the driver, which
has overwritten old drivers. I don't know whether is that a proper
instalation (should I recompile the kernel without ALSA drivers before
instalation?), but it works ->
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=271&type=bug

Anyway, with your patch there is sound out-of-the-box without any
additional options in /etc/modprobe.conf :-) Big thanks for your work!!!

edited on: 09-03-04 23:09

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 21:34 Dawid Gajownik New Issue                                    
08-29-04 21:34 Dawid Gajownik Distribution              => Fedora Core 2   
08-29-04 21:34 Dawid Gajownik Kernel Version            => 2.6.8-1.521     
08-31-04 13:36 tiwai          Note Added: 0001673                          
09-01-04 22:49 tiwai          Note Added: 0001677                          
09-02-04 12:30 Dawid Gajownik File Added: ac97.txt                         
09-02-04 12:45 Dawid Gajownik Note Added: 0001682                          
09-02-04 12:46 Dawid Gajownik File Added: ac97_0a.png                      
09-02-04 12:48 Dawid Gajownik File Added: ac97_quirk=1.png                    
09-02-04 12:48 Dawid Gajownik File Added: ac97_quirk=2.png                    
09-02-04 12:50 Dawid Gajownik Note Edited: 0001682                         
09-03-04 15:56 tiwai          Note Added: 0001693                          
09-03-04 16:06 tiwai          Note Added: 0001694                          
09-03-04 16:06 tiwai          File Added: via-double-quirk.dif                  
 
09-03-04 22:57 Dawid Gajownik File Added: alsamixer.png                    
09-03-04 23:07 Dawid Gajownik Note Added: 0001697                          
09-03-04 23:09 Dawid Gajownik Note Edited: 0001697                         
09-06-04 18:37 tiwai          Status                   new => resolved     
09-06-04 18:37 tiwai          Resolution               open => fixed       
09-06-04 18:37 tiwai          Assigned To               => tiwai           
11-09-04 16:15 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
