From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001842]: high frequency whisteling in one channel
Date: Sun, 12 Feb 2006 14:17:15 +0100
Message-ID: <61972f02469c6960cfd3d45b235a488d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A5901AF
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 14:17:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1842> 
======================================================================
Reported By:                Tolot
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1842
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             02-11-2006 23:17 CET
Last Modified:              02-12-2006 14:17 CET
======================================================================
Summary:                    high frequency whisteling in one channel
Description: 
compilation and loading of module snd-intel-hda works without problem. Also
alsaconf. But when I start xmms or mplayer I can hear something but one
channel has a very high frequency whisteling. I tried it with Windows too
to be sure that there is no hardware error.
lspci gives the information: 
Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition
Audio Controller (rev 03)
tried it with differnet kernels and also with alsa 1.0.9
also tried the kernel modul
======================================================================

----------------------------------------------------------------------
 Tolot - 02-12-06 14:17 
----------------------------------------------------------------------
additional information to the problem:
when I start kde i hear the starting sound together with the very high
frequency whisteling on one channel. The music stops, but whisteling goes
on. when i then change the pcm volume the whisteling stops. I then can use
for example xmms. but i cannot hear anything even when i use alsaconf or
alsamixer and reload the module.

Maybe it has something to do with the pci-express ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 23:17 Tolot          New Issue                                    
02-11-06 23:17 Tolot          Kernel Version            => 2.6.15.4        
02-12-06 14:17 Tolot          Note Added: 0008027                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
