From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001381]: No sound on Thinkpad T40p
Date: Sun, 13 Nov 2005 14:21:31 +0100
Message-ID: <3fd5074e178b2b13994ef35665a3e9ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A47E7171
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2005 14:21:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1381> 
======================================================================
Reported By:                Soft
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1381
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             
======================================================================
Date Submitted:             08-31-2005 09:50 CEST
Last Modified:              11-13-2005 14:21 CET
======================================================================
Summary:                    No sound on Thinkpad T40p
Description: 
When attempting to play a sound on a Thinkpad T40p, all sound players
behave as if playing normally, but no sound comes out of the speakers. 
This is with Debian Sarge + various package upgrades to testing, with a
number of kernels from 2.4.27 through 2.6.13-rc6-mm1, alsa-driver
1.0.8/1.0.9/1.0.10rc1.

I have already tried various "tricks", including muting Headphone Jack
Sense and Line Jack Sense.  Please see the following thread on alsa-user
mailing-list:
http://sourceforge.net/mailarchive/forum.php?thread_id=8013709&forum_id=1751
for more information.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000978 intel8x0 sound does not work on 2.6.10 ...
has duplicate       0001433 No sound output
======================================================================

----------------------------------------------------------------------
 jdthood - 09-23-05 09:36 
----------------------------------------------------------------------
>  Upgraded to kernel 2.6.14-rc2, which I think integrates alsa-driver
1.0.10rc1,
> No change.

You can tell what ALSA version you have by looking in
/proc/asound/version.

----------------------------------------------------------------------
 Soft - 11-13-05 14:21 
----------------------------------------------------------------------
Correction: alsa-driver 1.0.10rc1 in kernel 2.6.14(-rc2|.2) does seem to
correct the issue!  I didn't see it at first because "alsaplayer
/usr/share/sounds/KDE_Beep_Beep.wav" does not beep.  alsaplayer on other
sound files and mplayer now play audible sound.

The problem persists with alsa-driver 1.0.9b (I checked with kernel
2.6.13).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 09:50 Soft           New Issue                                    
08-31-05 09:50 Soft           Distribution              => Debian          
09-17-05 18:48 jdthood        Note Added: 0006251                          
09-18-05 15:47 Soft           Note Added: 0006272                          
09-22-05 23:12 Soft           Note Added: 0006361                          
09-23-05 09:36 jdthood        Note Added: 0006363                          
09-29-05 12:02 jdthood        Relationship added       related to 0000978  
09-29-05 12:03 jdthood        Relationship added       has duplicate 0001433
11-13-05 14:21 Soft           Note Added: 0006692                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
