From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001590]: Not able to record with c46xx on IBM T20
Date: Tue, 22 Nov 2005 20:35:22 +0100
Message-ID: <a20268642a57d5db1ecbc3c6470c6748@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D615F19F
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 20:35:22 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1590> 
======================================================================
Reported By:                mayouan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1590
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.14-3
======================================================================
Date Submitted:             11-22-2005 20:35 CET
Last Modified:              11-22-2005 20:35 CET
======================================================================
Summary:                    Not able to record with c46xx on IBM T20
Description: 
Hi.

I am not able to record with my T20 and alsa cs46xx
driver. Playback works fine, the alsa mixer works as
expected and i can hear the sound from the mic in the
speakers.

But when i try to record does the recording program
outputs an empty file (exept for a tiny wave-header).
Most programs does not give any error message.

Ecasound gives me a message when stoping the recording:
Warning: DBC_ENSURE failed - "is_running() == false",
eca-control-base.cpp, 276.-

Accordinng to Kai Vehmanen does this mean that alsa
does not release the lock on the soundcard when user is
aborting. That is likely the case.

Trying to record with Ardour leavs the computer not
responding at all.

I can not find anything in my error-logs telling that
alsa have loaded correctly nor does alsaconf give me
any error messages.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 20:35 mayouan        New Issue                                    
11-22-05 20:35 mayouan        Distribution              => Debian          
11-22-05 20:35 mayouan        Kernel Version            => 2.6.14-3        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
