From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001381]: No sound on Thinkpad T40p
Date: Sun, 18 Sep 2005 15:47:10 +0200
Message-ID: <3a7b091b5c6c6f35caa863c8bb6ab30e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E5BC5161
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2005 15:47:10 +0200 (MEST)
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
Last Modified:              09-18-2005 15:47 CEST
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

----------------------------------------------------------------------
 jdthood - 09-17-05 18:48 
----------------------------------------------------------------------
Try muting 'External Amplifier'.

Try raising the volume using the special keys on the ThinkPad.

----------------------------------------------------------------------
 Soft - 09-18-05 15:47 
----------------------------------------------------------------------
> Try muting 'External Amplifier'.
> Try raising the volume using the special keys on the ThinkPad.

I had already tried, and now tried again in vain.  But thanks for the
suggestion.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 09:50 Soft           New Issue                                    
08-31-05 09:50 Soft           Distribution              => Debian          
09-17-05 18:48 jdthood        Note Added: 0006251                          
09-18-05 15:47 Soft           Note Added: 0006272                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
