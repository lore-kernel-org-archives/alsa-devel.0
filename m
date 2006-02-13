From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001188]: quake3 crashes, capture not working
Date: Mon, 13 Feb 2006 19:48:47 +0100
Message-ID: <df72c74e2e081034a2b4b1298e6d799b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64EA0160
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 19:48:47 +0100 (MET)
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
Last Modified:              02-13-2006 19:48 CET
======================================================================
Summary:                    quake3 crashes, capture not working
Description: 
The card is a sb live 24bit pci.
quake3 crashes me after a map has loaded, oddly one map works but crashes
everytime when I finish the map. The sounds in the menus work. Tried my
mic
with the mic-in and all possible mixer settings, no dice.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000373 Sound in Quake 3 does not work
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

----------------------------------------------------------------------
 avuton - 02-13-06 19:48 
----------------------------------------------------------------------
Is this and 0001725 related?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-05 19:41 gnarlie        New Issue                                    
06-13-05 19:41 gnarlie        Distribution              => gentoo          
06-13-05 19:41 gnarlie        Kernel Version            => 2.6.8.1 with the
voluntary preempt patch
09-10-05 13:09 jcdutton       Note Added: 0006117                          
01-03-06 12:41 perex          Relationship added       related to 0000373  
02-13-06 19:48 avuton         Note Added: 0008061                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
