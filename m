From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001501]: intel8x0 surround channels missing and swapped
Date: Thu, 26 Jan 2006 23:19:59 +0100
Message-ID: <1a90535b3b2af7eeaa35097e7528ae3f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED91E19E
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 23:19:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1501> 
======================================================================
Reported By:                dkoch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1501
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.14-rc5-gac9b9c66
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-25-2005 16:45 CEST
Last Modified:              01-26-2006 23:19 CET
======================================================================
Summary:                    intel8x0 surround channels missing and swapped
Description: 
By default, the front channels are OK, the rear channels come out on the
center/LFE jack and the center/LFE channels don't come out at all.

Using ICH5/AD1985 (Intel P865PERL motherboard).

Anomolies found: double-rate slot (DRSLOT) is set to 7,8 instead of the
default
10,11 (register 0x20=0400 instead of 0).  After setting 0x20 to 0, the
rear
channel jack starts working.  RL/RR and Center/LFE are still swapped.

I would assume the swappage was hardware, but the Center and LFE volume
controls
affect the speakers on the Center/LFE jack which would indicate the driver
is
incorrectly routing the signals.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001521 Speakers misplaced in 5.1 surround
related to          0001369 Rear left/right channels swapped with c...
related to          0001173 No sound from rear channels
related to          0001206 No center channel; rear left and right ...
related to          0001191 Center channel and 32-bit emulation bro...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:11 
----------------------------------------------------------------------
Any improvement with the patch and/or later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 01-26-06 23:19 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 16:45 dkoch          New Issue                                    
10-25-05 16:45 dkoch          Distribution              => Fedora Core 3   
10-25-05 16:45 dkoch          Kernel Version            => 2.6.14-rc5-gac9b9c66
10-25-05 17:56 tiwai          Note Added: 0006546                          
10-25-05 18:09 dkoch          Note Added: 0006547                          
10-25-05 18:11 tiwai          Note Added: 0006548                          
10-25-05 18:12 tiwai          File Added: ac97-dra-conflict.diff                
   
11-01-05 15:27 jdthood        Relationship added       related to 0001521  
11-01-05 15:35 jdthood        Relationship added       related to 0001369  
11-01-05 15:42 jdthood        Relationship added       related to 0001173  
11-01-05 15:43 jdthood        Relationship added       related to 0001206  
11-01-05 15:45 jdthood        Relationship added       related to 0001191  
11-06-05 10:11 densg          Issue Monitored: densg                       
12-31-05 03:11 rlrevell       Note Added: 0007321                          
01-10-06 12:08 C-MoH          Issue Monitored: C-MoH                       
01-26-06 23:19 rlrevell       Status                   new => closed       
01-26-06 23:19 rlrevell       Note Added: 0007792                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
