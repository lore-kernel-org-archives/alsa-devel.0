From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000166]: strange high-pitched noise
Date: Sat, 20 Aug 2005 16:00:57 +0200
Message-ID: <512a4804cb51df5200204a8310511d82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 458D01DB
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2005 16:00:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=166> 
======================================================================
Reported By:                lichentrope
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   166
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2004 22:45 CEST
Last Modified:              08-20-2005 16:00 CEST
======================================================================
Summary:                    strange high-pitched noise
Description: 
My HW: MSI K7N2 Delta-L with integrated AC97 soundcard (intel-8x0 with
ac97_codec drivers used).

I could always hear some high-pitched noise. It is quite low in volume,
altough quite annoying when playing silent music/videos; the noise could
be best described as "wind", there is some random static audible in it.
The noise is independent from CPU load, whether some sound is being played
or not. At first I thought it was caused by heat noise from the
motherboard. Once I noticed it disappeared after reboot and reappeared
after running alsamixer to restore previous mixer settings. I played a bit
with the sound controls and found out what was the cause: the "Video"
control caused this. I had to unmute it and put it at full volume, then
the noise disappeared (strange though, I'd understand it if it were other
way round).
======================================================================

----------------------------------------------------------------------
 jdthood - 03-30-05 19:38 
----------------------------------------------------------------------
It seems that there are two problems here:

* Video slider operates in reverse

* alsamixer sets Video mixer level to an inappropriate value
  without the user touching the control itself

Submitter: Is that right? Do both problems still exist in the current ALSA
release?

----------------------------------------------------------------------
 jdthood - 08-20-05 16:00 
----------------------------------------------------------------------
No new information was provided.  Presumed fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-04 22:45 lichentrope    New Issue                                    
03-19-05 13:05 jdthood        Note Added: 0004045                          
03-30-05 19:38 jdthood        Note Added: 0004274                          
08-20-05 16:00 jdthood        Status                   new => closed       
08-20-05 16:00 jdthood        Note Added: 0005876                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
