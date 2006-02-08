From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001812]: Apps that uses alsa-1.0.11rc3 crashes with my asound.conf
Date: Wed, 8 Feb 2006 18:14:53 +0100
Message-ID: <dde38a7d4391d86315f6bc9ebcf29e3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA2451D6
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2006 18:14:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1812> 
======================================================================
Reported By:                AnarSoul
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1812
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2006 15:19 CET
Last Modified:              02-08-2006 18:14 CET
======================================================================
Summary:                    Apps that uses alsa-1.0.11rc3 crashes with my
asound.conf
Description: 
All apps that uses alsa-1.0.11rc3 crashed with my asound.conf with
message:

 conf.c:3144: snd_config_iterator_first: Assertion `node->type ==
SND_CONFIG_TYPE_COMPOUND' failed.

With alsa-1.0.10 everything is OK :)
======================================================================

----------------------------------------------------------------------
 AnarSoul - 02-04-06 17:35 
----------------------------------------------------------------------
2 theli:
without /etc/asound.conf at all I have soft mixing :) but I have no
special device "guitar" (dmix+dsnoop with small buffer size) that I need
:)

----------------------------------------------------------------------
 kareltejnora - 02-08-06 18:14 
----------------------------------------------------------------------
Quick fix is replace row:
pcm "hw:0,0"
with:
pcm {
type hw
card 0
device 0
}

The string not work for dsnoop too.
The problem is that in conf.c:3144 assert checks node->type and waits 1024
SND_CONFIG_TYPE_COMPOUND but node->type==3 (String) with node value hw:0,0
comes.
it means that PCM session is expected to be COMPOUND

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 15:19 AnarSoul       New Issue                                    
02-03-06 15:19 AnarSoul       File Added: asound.conf                      
02-04-06 10:05 theli          Issue Monitored: theli                       
02-04-06 10:10 theli          Note Added: 0007914                          
02-04-06 17:35 AnarSoul       Note Added: 0007917                          
02-04-06 23:54 AnarSoul       Issue Monitored: AnarSoul                    
02-08-06 18:08 kareltejnora   Issue Monitored: kareltejnora                    
02-08-06 18:14 kareltejnora   Note Added: 0007967                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
