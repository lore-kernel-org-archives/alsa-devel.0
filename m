From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000346]: no master volume set when maestro/alsa settings save & "restart"
Date: Thu, 31 Mar 2005 20:29:18 +0200
Message-ID: <5526bc9a1f31ad1a4ab5633482c1437d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4805924B
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 20:29:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=346> 
======================================================================
Reported By:                phoenixreads
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   346
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-26-2004 12:00 CEST
Last Modified:              03-31-2005 20:29 CEST
======================================================================
Summary:                    no master volume set when maestro/alsa settings save
& "restart"
Description: 
Gentoo uses a init.d script to handle alsa, called alsasound

Stop: unloads the modules and saves settings using alsactl.
Start: loads appropriate modules and calls alsactl restore #
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 13:22 
----------------------------------------------------------------------
>   bash-2.05b# modprobe snd-maestro3
> the Master volume is at 0
> setting the Master volume with
>   bash-2.05b# amixer sset Master 28
> does not work even thou it registers so
>   bash-2.05b# /usr/sbin/alsactl restore
> This works but...
>   bash-2.05b# modprobe -r snd-maestro3
>   bash-2.05b# modprobe snd-maestro3
>   bash-2.05b# /usr/sbin/alsactl restore
> does not work

I think that this would have to be a driver bug.
Should this report be reassigned to alsa-driver?

Submitter: Was the problem fixed in a laster release of ALSA?

----------------------------------------------------------------------
 jdthood - 03-31-05 20:29 
----------------------------------------------------------------------
Submitter: Was the problem fixed in a laster release of ALSA?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 12:00 phoenixreads   New Issue                                    
06-26-04 12:21 eradicator     Issue Monitored: eradicator                    
06-30-04 16:43 tiwai          Note Added: 0001360                          
06-30-04 19:26 phoenixreads   Note Added: 0001363                          
06-30-04 19:40 phoenixreads   Note Added: 0001364                          
03-20-05 13:22 jdthood        Note Added: 0004080                          
03-31-05 20:29 jdthood        Note Added: 0004285                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
