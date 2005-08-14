From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001335]: No sound on first probe
Date: Sun, 14 Aug 2005 08:31:58 +0200
Message-ID: <685e4258674f2b45c859eb6ffef883b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD3271C8
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2005 08:31:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1335> 
======================================================================
Reported By:                cpx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1335
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             08-14-2005 08:31 CEST
Last Modified:              08-14-2005 08:31 CEST
======================================================================
Summary:                    No sound on first probe
Description: 
The first probe of the snd-via82xx module results in no sound from the
speakers/headphone jack. Removing the module and reloading it fixes the
problem. Upon reloading (sometimes when removing) a small bit of feedback
is audible (i.e. suggesting the hardware's been "initialized").

The module seems to have to be removed for it to work though... just
rebooting and having it reload the module that way doesn't work.

After performing the above to make it work the system can then be warm
booted with the sound continuing to work until powering off.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 08:31 cpx            New Issue                                    
08-14-05 08:31 cpx            Distribution              => Slackware 10.0  
08-14-05 08:31 cpx            Kernel Version            => 2.6.13-rc6      
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
