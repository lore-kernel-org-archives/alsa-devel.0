From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000196]: full duplex doesn't work any more
Date: Thu, 16 Mar 2006 08:47:20 +0100
Message-ID: <f7b12167e9d067496c4d0bba3671a81f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AF751FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:47:20 +0100 (MET)
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
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-08-2004 20:59 CEST
Last Modified:              03-16-2006 08:47 CET
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
 rlrevell - 12-30-05 05:26 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:47 
----------------------------------------------------------------------
No response

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
03-16-06 08:47 rlrevell       Status                   feedback => closed  
03-16-06 08:47 rlrevell       Note Added: 0008600                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
