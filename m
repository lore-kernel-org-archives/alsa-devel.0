From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000196]: full duplex doesn't work any more
Date: Fri, 30 Dec 2005 05:26:07 +0100
Message-ID: <1a01c6d1109c93e7d88b25aa20092c50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A6C33193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:26:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=196> 
======================================================================
Reported By:                nathanel
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   196
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             04-08-2004 20:59 CEST
Last Modified:              12-30-2005 05:26 CET
======================================================================
Summary:                    full duplex doesn't work any more
Description: 
I'm using the attached .asoundrc to separate front an rear speakers of my
Soundblaster Live! to dsp and dsp1 respectively. I have my headphones
connected to the rear speaker output and running gnomemeeting with
alsa-oss on dsp1. Unfortunately this setup stopped working with alsa-oss
version 1.0.3 or higher (Different versions of alsa-libs didn't make any
difference). Playing music solely on dsp1 still works (tried with xmms
OSS) and recording also works (other people can hear me in gnomemeeting),
but both at the same time is no longer functioning (read: I can't hear my
dialog partner). As gnomemeering opens the audio device for recording
first, i suspect that full duplex support got broken somewhere between
1.0.2 and 1.0.3.
======================================================================

----------------------------------------------------------------------
 nathanel - 03-21-05 16:15 
----------------------------------------------------------------------
Unfortunately no. Meanwhile I had some look at the changes between alsa-oss
1.0.2 and 1.0.3 and it seems to me that some major rewrite/refactoring was
going on at that time, making it quite hard to spot any differences that
could be the cause. I eventually gave up and for now I'm still sticking to
the old version.

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:26 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-04 20:59 nathanel       New Issue                                    
04-08-04 20:59 nathanel       File Added: .asoundrc                        
03-20-05 23:59 jdthood        Note Added: 0004104                          
03-21-05 16:15 nathanel       Note Added: 0004119                          
03-22-05 09:37 jdthood        Note Edited: 0004104                         
03-22-05 09:38 jdthood        Status                   new => feedback     
12-30-05 05:26 rlrevell       Note Added: 0007246                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
