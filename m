From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001121]: Very low volume through SPDIF (no master volume?)
Date: Sun, 29 May 2005 12:23:23 +0200
Message-ID: <66ac58c7efc6e680a162b0c12779444b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 954141B9
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 12:23:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1121> 
======================================================================
Reported By:                dacid
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1121
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo (vanilla kernel)
Kernel Version:             2.6.12-rc4
======================================================================
Date Submitted:             05-21-2005 03:21 CEST
Last Modified:              05-29-2005 12:23 CEST
======================================================================
Summary:                    Very low volume through SPDIF (no master volume?)
Description: 
Hello - 
   I've been trying for a few weeks now to get SPDIF out working on my
Soundblaster 24bit card working.
   The issue is that the output to my receiver is very low, if I crank it
way up (-8db), I can hear some audio, but it is very muffled and
distored.
   I've tried various setting combinations in alsamixer, to no avail.
   I'm also a little curious as to why this soundcard has no master volume
or PCM controls.

======================================================================

----------------------------------------------------------------------
 dacid - 05-29-05 03:27 
----------------------------------------------------------------------
I'm not using the dongle - my instructions say it is optional, and that for
coax output you can use a mono miniplug-to-RCA adapter (which is what I'm
using).
I dual-booted into windows, and I can get SPDIF playback through the
output at normal levels.
The model on my instructions is Sound Blaster Live! 24-bit

----------------------------------------------------------------------
 jcdutton - 05-29-05 12:23 
----------------------------------------------------------------------
Have you adjusted the volume controls in alsamixer?
"SPDIF Front" and selected "SPDIF Out" to not say [Off] ?

Are you looking at the Creative instructions for "Watching DVDs" ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-21-05 03:21 dacid          New Issue                                    
05-21-05 03:21 dacid          Distribution              => Gentoo (vanilla
kernel)
05-21-05 03:21 dacid          Kernel Version            => 2.6.12-rc4      
05-24-05 01:54 dacid          Issue Monitored: dacid                       
05-28-05 12:13 jcdutton       Note Added: 0004763                          
05-28-05 12:30 jcdutton       Note Added: 0004772                          
05-28-05 12:30 jcdutton       Status                   assigned => feedback
05-29-05 03:27 dacid          Note Added: 0004778                          
05-29-05 12:23 jcdutton       Note Added: 0004783                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
