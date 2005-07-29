From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001282]: LFE Volumne Control & Mute/Unmute not working
Date: Fri, 29 Jul 2005 17:45:42 +0200
Message-ID: <0f01868b3c14fda70a0afe54e7814664@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1076194
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 17:45:42 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1282> 
======================================================================
Reported By:                notz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1282
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.12
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-26-2005 23:58 CEST
Last Modified:              07-29-2005 17:45 CEST
======================================================================
Summary:                    LFE Volumne Control & Mute/Unmute not working
Description: 
if try to set lfe volume or unmute lfe control with alsamixer or amixer, my
changes always will be reverted and so i never geht any lfe output. if
have an aopen i915GM-HFS motherboard and use alsa kernel from 2005-07-12
(nitro5 kernel).

also capture volumne seems to work not ok. i have set it 11 percent. it's
the maxmium for me. higher values produces oddly noises.

======================================================================

----------------------------------------------------------------------
 tiwai - 07-29-05 17:45 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-05 23:58 notz           New Issue                                    
07-26-05 23:58 notz           Kernel Version            => 2.6.12          
07-29-05 17:45 tiwai          Status                   assigned => resolved
07-29-05 17:45 tiwai          Resolution               open => fixed       
07-29-05 17:45 tiwai          Note Added: 0005580                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
