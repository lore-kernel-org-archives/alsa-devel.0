From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000057]: Kernel device in bad state after suspend/resume
Date: Thu, 17 Nov 2005 11:07:00 +0100
Message-ID: <cb3a074a9a666988733e888f7fddaa37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8C351C5
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 11:07:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=57> 
======================================================================
Reported By:                daenzer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   57
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-13-2004 01:55 CET
Last Modified:              11-17-2005 11:06 CET
======================================================================
Summary:                    Kernel device in bad state after suspend/resume
Description: 
If a process has the kernel device open during a suspend/resume cycle,
playing sound fails afterwards with

pcm_write:1084: write error: File descriptor in bad state

until the process dies, then it works again.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001442 snapper: no sound after resume
======================================================================

----------------------------------------------------------------------
 Johannes Berg - 10-12-05 21:02 
----------------------------------------------------------------------
tiwai, no it did not, all was silent. However, the code in 2.6.14 fixes the
problem entirely for me.

----------------------------------------------------------------------
 daenzer - 11-17-05 11:06 
----------------------------------------------------------------------
The behaviour has changed with kernel 2.6.14: I no longer get the write
error, the process that was playing sound during suspend/resume just
hangs, apparently in a system call. It can be resumed with kill -STOP;
kill -CONT or by starting another sound app (via dmix), but playback is
then distorted (sounds like the frames are played in the wrong order)
until the PCM device is closed.

Also, after suspend/resume, I have to disable and then re-enable the
speakers and change the volume(!) before I can hear anything from the
speakers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 01:55 daenzer        New Issue                                    
02-26-04 19:30 daenzer        Note Added: 0000363                          
02-26-04 19:39 tiwai          Note Added: 0000364                          
02-26-04 22:47 daenzer        Note Added: 0000374                          
05-14-04 15:12 tiwai          Note Added: 0001111                          
09-29-05 20:55 jdthood        Relationship added       has duplicate 0001442
09-29-05 23:52 Johannes Berg  Issue Monitored: Johannes Berg                    
09-29-05 23:59 Johannes Berg  Note Added: 0006427                          
10-05-05 18:40 tiwai          Note Added: 0006432                          
10-12-05 21:02 Johannes Berg  Note Added: 0006474                          
11-17-05 11:06 daenzer        Note Added: 0006748                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
