From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000048]: M-Audio Quattro initialization problem
Date: Wed, 22 Mar 2006 03:18:49 +0100
Message-ID: <e5643d89521b5bfebcff2478bdf7ed90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D62C1A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:18:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=48> 
======================================================================
Reported By:                giggls
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   48
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.24
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-09-2004 11:45 CET
Last Modified:              03-22-2006 03:18 CET
======================================================================
Summary:                    M-Audio Quattro initialization problem
Description: 
If a M-Audio Quattro device is plugged into the USB Port the driver does
not always initialize the device in a correct way.

It seems to work, but it does not record any useful sound.

Unfortunately it does work occasionally (about 50% of the time)!

Replugging the device until it works does resolve the Problem.


======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 16:03 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions or using more
recent kernels?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:18 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-04 11:45 giggls         New Issue                                    
02-11-04 10:26 giggls         Issue Monitored: giggls                      
02-11-04 14:58 v2             Note Added: 0000218                          
02-11-04 14:58 v2             Issue Monitored: v2                          
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 16:36 giggls         Note Added: 0000219                          
02-24-04 08:48 Clemens LadischSeverity                 feature => minor    
02-24-04 09:07 Clemens LadischNote Added: 0000302                          
02-25-04 09:30 giggls         File Added: proc-stream1.txt                    
02-25-04 09:30 giggls         File Added: proc-stream0.txt                    
02-25-04 09:53 giggls         Note Added: 0000310                          
02-25-04 10:12 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-25-04 10:15 Clemens LadischNote Added: 0000313                          
02-25-04 16:10 giggls         Note Added: 0000315                          
02-26-04 16:08 Clemens LadischFile Added: quattroif.patch                    
02-26-04 16:12 Clemens LadischNote Added: 0000352                          
02-26-04 16:12 Clemens LadischSeverity                 minor => major      
02-26-04 16:12 Clemens LadischReproducibility          always => sometimes 
02-27-04 15:42 giggls         Note Added: 0000381                          
03-01-04 18:45 Clemens LadischNote Added: 0000413                          
03-02-04 09:31 giggls         File Added: proc-asound-card1-stream0-junk.txt    
               
03-02-04 09:32 giggls         Note Added: 0000432                          
03-02-04 17:11 Clemens LadischNote Added: 0000443                          
03-04-04 10:09 giggls         Note Added: 0000471                          
03-04-04 12:53 Clemens LadischNote Added: 0000477                          
03-04-04 16:18 giggls         Note Added: 0000482                          
03-04-04 16:18 giggls         File Added: sinus.raw                        
03-04-04 16:19 giggls         File Added: silence.raw                      
03-04-04 19:50 Clemens LadischNote Added: 0000491                          
03-08-04 10:46 Clemens LadischFile Added: quattro-new.patch                    
03-08-04 10:48 Clemens LadischNote Added: 0000527                          
04-28-04 12:44 timblech       Note Added: 0000969                          
11-17-04 15:09 giggls         Note Added: 0002435                          
11-17-04 15:25 v2             Issue End Monitor: v2                        
09-14-05 16:03 jdthood        Note Added: 0006170                          
09-14-05 16:03 jdthood        Severity                 major => minor      
09-14-05 16:03 jdthood        Summary                  M-Audio Quattro
Initialisation Problem => M-Audio Quattro initialization problem
09-14-05 16:03 jdthood        Description Updated                          
03-22-06 03:18 rlrevell       Status                   assigned => closed  
03-22-06 03:18 rlrevell       Note Added: 0008809                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
