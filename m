From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001852]: Network transparency through polypaudio
Date: Thu, 2 Mar 2006 16:02:57 +0100
Message-ID: <d492b9c26e247e2d1d2ceef6233d1985@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18FF3191
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 16:02:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1852> 
======================================================================
Reported By:                drzeus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1852
Category:                   PCM - oss
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-17-2006 20:47 CET
Last Modified:              03-02-2006 16:02 CET
======================================================================
Summary:                    Network transparency through polypaudio
Description: 
This is a request to include the polypaudio (a sound server) plugin I've
written. Having it in ALSA would mean that all ALSA apps could
transparently work across the network.

The plugin can currently handle:

 * PCM playback.
 * PCM capture.
 * Playback volume control.

I supports polled mode and direct access.

Polypaudio needed to be extended a bit to support this plugin so to
compile and use it you need the svn version of polypaudio:

svn co svn://svn.0pointer.de/polypaudio/trunk polypaudio
======================================================================

----------------------------------------------------------------------
 drzeus - 02-20-06 13:53 
----------------------------------------------------------------------
New version that follows API changes in polypaudio svn.

----------------------------------------------------------------------
 tiwai - 03-02-06 16:02 
----------------------------------------------------------------------
Merged to ALSA CVS tree.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 20:47 drzeus         New Issue                                    
02-17-06 20:47 drzeus         File Added: alsa-polyp-1.0.10-3.tar.bz2           
        
02-18-06 02:12 rlrevell       Note Added: 0008113                          
02-18-06 03:16 drzeus         Note Added: 0008115                          
02-20-06 13:52 drzeus         File Added: alsa-polyp-1.0.10-4.tar.bz2           
        
02-20-06 13:53 drzeus         Note Added: 0008144                          
03-02-06 16:02 tiwai          Status                   new => resolved     
03-02-06 16:02 tiwai          Resolution               open => fixed       
03-02-06 16:02 tiwai          Assigned To               => tiwai           
03-02-06 16:02 tiwai          Note Added: 0008317                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
