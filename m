From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001121]: Very low volume through SPDIF (no master volume?)
Date: Sat, 10 Sep 2005 13:21:30 +0200
Message-ID: <a32b444514adf6b94e09432c088f2c20@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F11E1C4
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 13:21:31 +0200 (MEST)
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
Last Modified:              09-10-2005 13:21 CEST
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
 dacid - 05-30-05 15:35 
----------------------------------------------------------------------
Yup. I've got SPDIF Out activated, and all 4 SPDIF volume sliders are
cranked up.  

As for the instructions - yes, I am following the left portion (mono
miniplug-to-RCA cable) of the "Watching DVDs" section.  

One thing I noticed that seems a bit strange:  My test files are 2 channel
audio, but playback is occuring on all 5 speakers....

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:21 
----------------------------------------------------------------------
Please try the trouble shooter at: http://alsa.opensrc.org/TroubleShooting

The post the output of steps 1,2,3,4 here.
And also the output of:
amixer contents

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
05-30-05 15:35 dacid          Note Added: 0004819                          
09-10-05 13:21 jcdutton       Note Added: 0006121                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
