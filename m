From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001188]: quake3 crashes, capture not working
Date: Sat, 10 Sep 2005 13:09:46 +0200
Message-ID: <c8ae6752d33c08bd30bf07df416663d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 327F2167
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 13:09:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1188> 
======================================================================
Reported By:                gnarlie
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1188
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.8.1 with the voluntary preempt patch
======================================================================
Date Submitted:             06-13-2005 19:41 CEST
Last Modified:              09-10-2005 13:09 CEST
======================================================================
Summary:                    quake3 crashes, capture not working
Description: 
The card is a sb live 24bit pci.
quake3 crashes me after a map has loaded, oddly one map works but crashes
everytime when I finish the map. The sounds in the menus work. Tried my
mic
with the mic-in and all possible mixer settings, no dice.
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:09 
----------------------------------------------------------------------
The ca0106 based sound card is currently unsuitable for any linux based
games.
The card cannot do 44100 Hz sound, and all games like Doom3 and Quake3 use
44100 Hz sound. I would suggest using a different sound card for now, or
wait until the alsa-lib resamplers have improved in order to support
this.
The improvements needed to the alsa-lib resamplers are rather complicated,
so don't expect it to happen any time soon.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-05 19:41 gnarlie        New Issue                                    
06-13-05 19:41 gnarlie        Distribution              => gentoo          
06-13-05 19:41 gnarlie        Kernel Version            => 2.6.8.1 with the
voluntary preempt patch
09-10-05 13:09 jcdutton       Note Added: 0006117                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
