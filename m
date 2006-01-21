From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000854]: Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Date: Sat, 21 Jan 2006 03:45:10 +0100
Message-ID: <9d1f4ff5ea4cb9e35bd96b2a20ec3e7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF8AED8
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 03:45:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=854> 
======================================================================
Reported By:                mrpee
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   854
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8-2-386
======================================================================
Date Submitted:             01-28-2005 13:18 CET
Last Modified:              01-21-2006 03:45 CET
======================================================================
Summary:                    Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Description: 
I can't load any modules for my sound carc Cirrus Logic cs4237b on my Dell
Latitude CP M233XT. I tried snd-cs4236, snd-cs4236 and also the
soundblaster module snd-sb8 with the same result "no such device".

I think I'll tried everything, kernel 2.4 with alsamodules, 2.6.1, alsa
1.0.7-2. half/full duplex, changing irq, dma etc.

Here is a link from another forum whith the same problem:
http://www.talkaboutsoftware.com/group/linux.debian.laptop/messages/7049.html
======================================================================

----------------------------------------------------------------------
 briand - 01-21-06 03:39 
----------------------------------------------------------------------
apparently not, as this sounds suspicously like the problem I reported on
my Dell Inspiron 3200 (0001748).



----------------------------------------------------------------------
 rlrevell - 01-21-06 03:45 
----------------------------------------------------------------------
This bug report is too vague to be actionable.  Please provide more
information - what EXACTLY did you do that produced the "no such device"
message, etc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 13:18 mrpee          New Issue                                    
01-28-05 13:18 mrpee          Distribution              => Debian          
01-28-05 13:18 mrpee          Kernel Version            => 2.6.8-2-386     
01-28-05 13:23 mrpee          Note Added: 0003426                          
03-28-05 04:23 jdthood        Note Added: 0004233                          
03-30-05 09:49 mrpee          Note Added: 0004264                          
12-30-05 05:22 rlrevell       Note Added: 0007243                          
01-21-06 03:39 briand         Note Added: 0007731                          
01-21-06 03:39 briand         Note Edited: 0007731                         
01-21-06 03:40 briand         Issue Monitored: briand                      
01-21-06 03:45 rlrevell       Note Added: 0007732                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
