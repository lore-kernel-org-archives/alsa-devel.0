From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001049]: No sound at all
Date: Mon, 19 Dec 2005 02:14:42 +0100
Message-ID: <82d5b46e2640dd1bf538e62c3f05b4d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFF89134
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:14:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1049> 
======================================================================
Reported By:                DF5JT
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1049
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.770_FC3 #1 Thu Feb 24 14:00:06 EST 2005
i686 i686 i386 GNU/Linux
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-13-2005 11:25 CEST
Last Modified:              12-19-2005 02:14 CET
======================================================================
Summary:                    No sound at all
Description: 
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



======================================================================

----------------------------------------------------------------------
 rlrevell - 11-23-05 21:49 
----------------------------------------------------------------------
Try tiwai's suggestion as well as newer ALSA release

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:14 
----------------------------------------------------------------------
No response from submitter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 11:25 DF5JT          New Issue                                    
04-13-05 11:25 DF5JT          Distribution              => Fedora Core 3   
04-13-05 11:25 DF5JT          Kernel Version            => 2.6.10-1.770_FC3 #1
Thu Feb 24 14:00:06 EST 2005 i686 i686 i386 GNU/Linux
04-13-05 11:25 DF5JT          Issue Monitored: DF5JT                       
04-13-05 16:34 tiwai          Note Added: 0004469                          
04-13-05 16:52 DF5JT          Note Added: 0004470                          
04-13-05 17:19 tiwai          Note Added: 0004473                          
04-15-05 12:08 DF5JT          Note Added: 0004497                          
04-15-05 12:38 stransky       Note Added: 0004498                          
04-15-05 14:09 DF5JT          Note Added: 0004499                          
04-19-05 17:52 tiwai          Note Added: 0004529                          
04-19-05 17:55 tiwai          Category                 PCI - azx => PCI -
hda-intel
06-09-05 16:20 Ballbreaker    Issue Monitored: Ballbreaker                    
08-12-05 18:12 Ballbreaker    Issue End Monitor: Ballbreaker                    
11-23-05 21:20 rlrevell       Note Added: 0006834                          
11-23-05 21:49 rlrevell       Note Added: 0006836                          
11-23-05 21:49 rlrevell       Status                   new => feedback     
12-19-05 02:14 rlrevell       Status                   feedback => closed  
12-19-05 02:14 rlrevell       Note Added: 0007078                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
