From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Thu, 30 Dec 2004 13:02:33 +0100
Message-ID: <6f9961afa86afbee783ffa3277cca4e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9CC1F24B
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2004 13:02:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=750> 
======================================================================
Reported By:                aquarichy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   750
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             2.6.9+
======================================================================
Date Submitted:             12-28-2004 02:20 CET
Last Modified:              12-30-2004 13:02 CET
======================================================================
Summary:                    no sound since 2.6.8.1
Description: 
Sound using a kernel.org 2.6.8.1 kernel with ALSA built-in worked.  When I
compile  any newer stable kernel, there is no sound.  Compilation executes
without complaints.  No Sound related options change.  I have even tried
saying No to all the new options 2.6.9 and .10 provided in fear that one
of those might be interfering, but nada.  
======================================================================

----------------------------------------------------------------------
 aquarichy - 12-30-04 06:36 
----------------------------------------------------------------------
There are four cases I can describe, one of them results in a working 
configuration.  Is it possible that my via82xx depends on controls 1 and 2

controlling Master Playback?  I do not know much about ALSA's internals
(yet). 

  A = kernel 2.6.8.1
  B = kernel 2.6.10

  Sa = asound.state from kernel A
  Sb = asound.state from kernel B

case 1:
booting A with Sa results in working sound!
controls 1 and 2 are set to Master Playback.
controls 3 and 4 are set to Headphone Playback.

case 2:
booting B with Sa results in no sound :(
controls 1 and 2 are still set to Master Playback.
controls 3 and 4 are still set to Headhpone Playback.
Warnings are given (post 3007).

case 3:
booting B with Sb still results in no sound :(
controls 1 and 2 for Sb are not set in asound.state :(
controls 3 and 4 are set as the Master Playback.
No more warnings, as ALSA is happy with which settings go with which
controls.

case 4:
booting A with Sb also results in no sound.
controls 1 and 2 are intended for Master Playback but, not being set, are

 _muted_.
controls 3 and 4 are intended for Headphone Playback and use Master
Playback
 settings from B/Sb configuration.
Warning messages, of course.  



Though I install Slackware's alsa-driver packages, I think they go unused,
as
I build ALSA into the kernel.  So I suppose my issue is with a change in
the 
ALSA for my card.  Tomorrow I will try buildings a (presently working
kernel
version) with ALSA excluded, and then build the current ALSA separately,
and see
if I do not get sound from that.  If I do not, then I suppose I am free
to
upgrade my kernel as long as I do not update my ALSA drivers :) 

I hope this is not the case.  Thank you for your continuing support :)

----------------------------------------------------------------------
 tiwai - 12-30-04 13:02 
----------------------------------------------------------------------
Forget about the control number id.  It's not consistent when the mixer
controls are changed.  When -F option is given to alsactl, it tries to
find the matching control from the name.  Don't worry the warnings.

Anyway, first, please use the latest ALSA 1.0.8rc1 or the CVS version.  I
won't debug 1.0.7 right now.

The problem is likely either the inproper mixer setting or the invalid
ac97_quirk option.  Attach the current /etc/asound.state, the contents of
/proc/asound/card0/codec97#0/* files.

Then check the module config whether you have ac97_quirk module option
there.  If yes, remove it or set "ac97_quirk=-1".  If still doesn't help,
set "ac97_quirk=0", and raise/unmute Master and Headphone.

Also, don't forget to raise DXS volumes if they are set to 0.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
12-29-04 19:17 aquarichy      Note Added: 0003008                          
12-29-04 19:37 aquarichy      Note Added: 0003009                          
12-29-04 20:39 aquarichy      Note Added: 0003011                          
12-29-04 20:46 rlrevell       Note Added: 0003012                          
12-30-04 00:07 aquarichy      Note Added: 0003015                          
12-30-04 06:05 aquarichy      Note Edited: 0003015                         
12-30-04 06:36 aquarichy      Note Added: 0003017                          
12-30-04 13:02 tiwai          Note Added: 0003018                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
