From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Tue, 13 Dec 2005 22:06:01 +0100
Message-ID: <db6f7baa9ed4e438dc0e48bcbad37dde@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39A5D1B1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 22:06:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305> 
======================================================================
Reported By:                klausr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   305
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             Debian kernel 2.6.5-4-686
======================================================================
Date Submitted:             05-25-2004 14:49 CEST
Last Modified:              12-13-2005 22:06 CET
======================================================================
Summary:                    sound is locked up after suspend/resume (APM)
Description: 
Until recently I was running oss driver cs46xx without a problem. I could
suspend in the middle of playback and xmms would keep playing after resume
as if nothing happend at all.
After switching to the 2.6 kernel, currently running 2.6.5, I also
switched to ALSA beeing the new sound architecture of choice.
Unforunately now when I suspend and resume my notebook sound stops working
at all. Sometimes unloading all ALSA modules helps, sometimes even that is
not possible anymore.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 jdthood - 12-13-05 12:49 
----------------------------------------------------------------------
klausr: Does cs46xx suspend-'n'-resume work properly in 1.0.10?

----------------------------------------------------------------------
 jdthood - 12-13-05 22:06 
----------------------------------------------------------------------
Actually, try 1.0.11rc1 since the changelog reports that cs46xx PM is
fixed.  :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 14:49 klausr         New Issue                                    
05-25-04 14:49 klausr         Kernel Version            => Debian kernel
2.6.5-4-686
05-25-04 15:02 tiwai          Note Added: 0001213                          
05-25-04 15:31 klausr         Note Added: 0001215                          
05-25-04 15:59 klausr         Note Added: 0001217                          
05-25-04 16:02 klausr         Issue Monitored: klausr                      
05-25-04 16:05 tiwai          Note Added: 0001218                          
05-25-04 16:44 klausr         Note Added: 0001220                          
05-25-04 16:56 klausr         Note Edited: 0001220                         
05-27-04 08:49 klausr         Issue End Monitor: klausr                    
05-28-04 17:08 tiwai          Note Added: 0001269                          
05-29-04 09:36 klausr         Note Added: 0001276                          
01-17-05 10:57 jdthood        Note Added: 0003226                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
03-23-05 00:39 rlrevell       Note Added: 0004145                          
03-28-05 15:42 sboehler       Issue Monitored: sboehler                    
06-20-05 01:59 tromer         Issue Monitored: tromer                      
12-12-05 11:12 bheung         Issue Monitored: bheung                      
12-13-05 12:49 jdthood        Note Added: 0007003                          
12-13-05 22:06 jdthood        Note Added: 0007025                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
