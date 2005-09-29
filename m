From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001381]: No sound on Thinkpad T40p
Date: Thu, 29 Sep 2005 12:02:12 +0200
Message-ID: <9a39266fe707ce33aca046b348a46967@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C85E6191
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:02:12 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000978.
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
Last Modified:              09-29-2005 12:02 CEST
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

----------------------------------------------------------------------
 Soft - 09-22-05 23:12 
----------------------------------------------------------------------
Upgraded to kernel 2.6.14-rc2, which I think integrates alsa-driver
1.0.10rc1,
No change.

----------------------------------------------------------------------
 jdthood - 09-23-05 09:36 
----------------------------------------------------------------------
>  Upgraded to kernel 2.6.14-rc2, which I think integrates alsa-driver
1.0.10rc1,
> No change.

You can tell what ALSA version you have by looking in
/proc/asound/version.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
