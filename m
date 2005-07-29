From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001052]: Riptide/Context Audio Drivers
Date: Fri, 29 Jul 2005 18:48:19 +0200
Message-ID: <3c8438d2edceed70642ab6e072e59452@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AC1C197
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 18:48:19 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1052> 
======================================================================
Reported By:                JKnife
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1052
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-13-2005 21:59 CEST
Last Modified:              07-29-2005 18:48 CEST
======================================================================
Summary:                    Riptide/Context Audio Drivers
Description: 
there is a set but its only for the 2.4 kernel.
i would like you toinclude them in alsa.
the 2.4 drivers can be found here
http://www.linuxant.com/drivers/
======================================================================

----------------------------------------------------------------------
 nokos - 07-25-05 13:27 
----------------------------------------------------------------------
I have tested the patch with a 2.6.12 kernel and removed all warning
messages.
It works for my Riptide chipset (hotplug needs the firmware "riptide.hex"
somewhere)

riptide.tar.bz2 contains 2 diffs, one for alsa-driver-1.0.9b and the other
for a recent 2.6 kernel ...

# lspci
0000:00:06.0 Multimedia audio controller: Rockwell International: Unknown
device 4310
0000:00:06.1 Communication controller: Rockwell International Riptide HSF
56k PCI Modem
0000:00:06.2 Input device controller: Rockwell International: Unknown
device 4312



----------------------------------------------------------------------
 tiwai - 07-29-05 18:48 
----------------------------------------------------------------------
Thanks.
The riptide driver was added to alsa-driver tree (not alsa-kernel tree
yet).
Will be pushd to alsa-kernel (e.g. linux kernel) tree once after the
driver is confirmed to work fine with the latest environment.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:59 JKnife         New Issue                                    
04-13-05 22:01 JKnife         Note Added: 0004479                          
06-06-05 10:51 perex          Assigned To              perex =>            
06-06-05 10:51 perex          Category                 ISA - GUS (classic, max,
extreme, interwave) => OTHERS
06-08-05 15:15 tiwai          Note Added: 0004932                          
06-08-05 23:25 JKnife         Note Added: 0004976                          
06-15-05 14:41 nokos          Note Added: 0005027                          
06-23-05 12:07 tiwai          Note Added: 0005176                          
06-23-05 15:10 nokos          Note Added: 0005187                          
06-23-05 15:21 tiwai          Note Added: 0005188                          
06-23-05 15:26 tiwai          Note Added: 0005189                          
06-23-05 15:35 nokos          Note Added: 0005190                          
06-24-05 15:09 tiwai          Note Added: 0005226                          
06-26-05 22:48 JKnife         Note Added: 0005268                          
06-27-05 18:35 nokos          Note Added: 0005285                          
07-08-05 14:57 tiwai          Note Added: 0005430                          
07-19-05 11:27 nokos          Note Edited: 0005285                         
07-19-05 11:27 nokos          File Added: riptide-alsa-1.0.9b.patch.gz          
         
07-19-05 11:28 nokos          Note Edited: 0005187                         
07-22-05 12:14 nokos          Issue Monitored: nokos                       
07-22-05 12:24 nokos          Note Added: 0005548                          
07-22-05 12:25 nokos          File Added: riptide.tar.bz2                    
07-22-05 12:26 nokos          Note Edited: 0005548                         
07-25-05 13:27 nokos          Note Edited: 0005548                         
07-29-05 18:48 tiwai          Status                   assigned => resolved
07-29-05 18:48 tiwai          Resolution               open => fixed       
07-29-05 18:48 tiwai          Assigned To               => tiwai           
07-29-05 18:48 tiwai          Note Added: 0005585                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
