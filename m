From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000525]: Sound does not work
Date: Wed, 23 Mar 2005 16:32:55 +0100
Message-ID: <e32012a33c8446910ad5f7a73afc040e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 27A421B2
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 16:32:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=525> 
======================================================================
Reported By:                ao314
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   525
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-23-2004 10:00 CEST
Last Modified:              03-23-2005 16:32 CET
======================================================================
Summary:                    Sound does not work
Description: 
Sometimes, after the computer has been off for a while the sound refuses to
work. Rebooting a couple of times seems to "fix" it.
======================================================================

----------------------------------------------------------------------
 ao314 - 09-30-04 19:44 
----------------------------------------------------------------------
The motherboard is a MicroStar OEM board for Compaq, a MS-6553. The BIOS is
a Compaq 686Y4 3.06. Sound works everytime under Windows XP (which came
preinstalled). The computer itself is a Presario 6140EA, I can't seem to
find too much information about it.

----------------------------------------------------------------------
 jdthood - 03-23-05 16:32 
----------------------------------------------------------------------
> Also I think I know how to reproduce it slightly more often,
> as soon as grub offers boot straigtaway without any delay
> makes the sound work less frequently and waiting for the 10s
> to pass usually makes the sound work.

If true then this suggests are hardware or perhaps a firmware
related problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 10:00 ao314          New Issue                                    
09-23-04 10:00 ao314          Distribution              => Fedora Core 2   
09-23-04 10:00 ao314          Kernel Version            => 2.6.8           
09-23-04 14:29 ao314          Issue Monitored: ao314                       
09-23-04 18:16 tiwai          Note Added: 0001827                          
09-24-04 12:07 ao314          Issue End Monitor: ao314                     
09-24-04 12:18 ao314          Note Added: 0001873                          
09-24-04 12:18 ao314          File Added: amixer.out                       
09-24-04 12:18 ao314          File Added: dmesg.out                        
09-24-04 12:19 ao314          File Added: lspci.out                        
09-24-04 12:19 ao314          File Added: modprobe.out                     
09-24-04 12:26 tiwai          Note Added: 0001876                          
09-24-04 14:53 ao314          File Added: dmesg.out                        
09-24-04 15:37 ao314          Note Added: 0001891                          
09-28-04 16:11 djtm           Note Added: 0001949                          
09-30-04 19:44 ao314          Note Added: 0001985                          
03-23-05 16:32 jdthood        Note Added: 0004178                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
