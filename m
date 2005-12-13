From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000160]: snd-cmi8330 produces no sound
Date: Tue, 13 Dec 2005 12:42:45 +0100
Message-ID: <d8b585d335649ba8e70229c9a7a61e4e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD5A61C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:42:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=160> 
======================================================================
Reported By:                sb73542
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   160
Category:                   ISA - cmi8330
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4.25
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-27-2004 05:32 CET
Last Modified:              12-13-2005 12:42 CET
======================================================================
Summary:                    snd-cmi8330 produces no sound
Description: 
Hi, I'm trying to use my onboard cmi8330 soundcard with ALSA.  alsaconf
detectseverything correctly, but unfortunately no sound.  These are the
devices that appear under /dev/snd :
controlC0  
pcmC0D0c   
pcmC0D0p   
timer

I've been trying to use set this up with arts, and it when I overide the
defaults to any of the above, it says it's an invalid device, and can't be
written to.  The alsa docs list as a bug for this card: "Is broken".  Any
fixes?  Thanks for the help!
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:37 
----------------------------------------------------------------------
Submitter: Have you had better luck with more recent ALSA releases?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:42 
----------------------------------------------------------------------
no feedback was forthcoming

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-27-04 05:32 sb73542        New Issue                                    
03-27-04 05:32 sb73542        Distribution              => Slackware       
03-27-04 05:32 sb73542        Kernel Version            => 2.4.25          
03-19-05 09:37 jdthood        Note Added: 0004022                          
12-13-05 12:42 jdthood        Status                   new => closed       
12-13-05 12:42 jdthood        Note Added: 0006998                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
