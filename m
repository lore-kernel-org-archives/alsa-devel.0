From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002095]: Choppy sound using default dmix config for some applications but not others.
Date: Wed, 3 May 2006 11:45:45 +0200
Message-ID: <8537b61d7944cd30b37c6c0f5fdd60df@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02DBD146
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 11:45:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2095> 
======================================================================
Reported By:                BigBaaadBob
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2095
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             05-03-2006 01:09 CEST
Last Modified:              05-03-2006 11:45 CEST
======================================================================
Summary:                    Choppy sound using default dmix config for some
applications but not others.
Description: 
As reported in http://forums.gentoo.org/viewtopic-t-457951.html
alsa 1.0.11 causes skipping sound in some applications but not others.

Sound skips in rhytymbox and totem, but not xmms, realplayer, or mplayer.

This occurs with default dmix setup (i.e. with no .asoundrc).  Creating an
.asoundrc like this causes the skipping to stop for those applications
that skip.

pcm.!default {
  type hw
  card 0
}

This has been reported using the cmipci driver, the Intel ICH4 driver, the
i915GM driver, and on a ppc iBook G4.

On user reports that fiddling with the .asoundrc parameters can lessen the
problem, but not eliminate the problem.
======================================================================

----------------------------------------------------------------------
 BigBaaadBob - 05-03-06 01:31 
----------------------------------------------------------------------
Reverting to media-libs/alsa-lib-1.0.10 and leaving everything else the
same resolves the problem for me.  Currently I'm using the driver in the
2.6.16-gentoo-r3 kernel and the following alsa lineup:

[I--] [  ] media-libs/alsa-lib-1.0.10 (0)
[I--] [  ] media-libs/alsa-oss-1.0.11 (0)
[I--] [  ] media-sound/alsa-headers-1.0.11 (0)
[I--] [  ] media-sound/alsa-tools-1.0.11 (0.9)
[I--] [  ] media-sound/alsa-utils-1.0.11 (0.9)

----------------------------------------------------------------------
 tiwai - 05-03-06 11:45 
----------------------------------------------------------------------
Try to set

    defaults.pcm.dmix_max_periods -1

in ~/.asoundrc.  This will take back the old dmix behavior.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-03-06 01:09 BigBaaadBob    New Issue                                    
05-03-06 01:27 wellwhoopdedoooNote Added: 0009580                          
05-03-06 01:28 wellwhoopdedoooIssue Monitored: wellwhoopdedooo                  
 
05-03-06 01:29 wellwhoopdedoooNote Edited: 0009580                         
05-03-06 01:31 BigBaaadBob    Note Added: 0009581                          
05-03-06 11:45 tiwai          Note Added: 0009586                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
