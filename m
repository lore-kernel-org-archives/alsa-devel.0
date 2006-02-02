From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001728]: Modification of volume control for M-Audio Revolution 5.1
Date: Thu, 2 Feb 2006 15:15:07 +0100
Message-ID: <ef51b4fc2826d57ee5001b2adf5efadc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F16831BD
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2006 15:15:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1728> 
======================================================================
Reported By:                cyan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1728
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo testing
Kernel Version:             2.6.14-gentoo-r5
======================================================================
Date Submitted:             01-09-2006 23:35 CET
Last Modified:              02-02-2006 15:15 CET
======================================================================
Summary:                    Modification of volume control for M-Audio
Revolution 5.1
Description: 
In Alsamixer (and KMix) is not possible to change volume of both chanels at
once. Slides with names "DAC" and "DAC1" corresponds to left and right
chanel. 
I would like to make a suggestion to merge them together.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-27-06 15:20 
----------------------------------------------------------------------
Yes, the idea looks fine for most ice1724 boards, but not nice for some
ice1712 boards which have really independent mono jacks.
So, I'd like to rather allow the driver to select the behavior, whether
mono or stereo controls.

Also, it'd be not difficult to modify the code for driver to pass a static
array of control names including "Front", "Surround", "CLFE", "Side", so
that the mixer elements become more intuitive, too.

----------------------------------------------------------------------
 alinja - 02-02-06 15:15 
----------------------------------------------------------------------
Is second this suggestion. I consider the current implementation with
independent channel volumes broken (especially as there is no master
volume). I already had decided to make a similar patch, but I'm glad I
found this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-06 23:35 cyan           New Issue                                    
01-09-06 23:35 cyan           Distribution              => gentoo testing  
01-09-06 23:35 cyan           Kernel Version            => 2.6.14-gentoo-r5
01-14-06 22:31 wollschaf      Note Added: 0007656                          
01-25-06 00:07 wollschaf      Issue Monitored: wollschaf                    
01-25-06 00:09 wollschaf      File Added: ak4xxx-adda-stereomixer.patch         
          
01-25-06 00:29 wollschaf      Note Added: 0007776                          
01-27-06 15:20 tiwai          Note Added: 0007804                          
02-02-06 15:15 alinja         Note Added: 0007877                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
