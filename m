From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000782]: Poor digital aidio quality
Date: Wed, 16 Mar 2005 02:11:12 +0100
Message-ID: <dab4e262f2d168cbcc088fbad07ef3d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7D7DB221
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 02:11:12 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=782> 
======================================================================
Reported By:                ddemmer
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   782
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core
Kernel Version:             2.6.9-1.681_FC3.i686
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-03-2005 16:20 CET
Last Modified:              03-16-2005 02:11 CET
======================================================================
Summary:                    Poor digital aidio quality
Description: 
Attempting to play MP3 files with RealPlay or xmms using ALSA output
results in scratchy, erratic, slow (Realplay) or speeded up (xmms) sound.
I can change the xmms configuration to use libOSS.so instead of libALSA
which fixes the problem.

The gnome "Detect Sound Card" utility works fine and plays it's sound
fine.

The gnome volume control does not affect the output level when using
libOSS.

I have by now muted everything in the alsamixer except the Master volume.

Playing a CD works fine.
======================================================================

----------------------------------------------------------------------
 fmoraes - 03-16-05 02:10 
----------------------------------------------------------------------
For RealPlayer, you may have to use aoss to run it. You can get some help
on the dmix configuration but I am closing this as it is no longer a
driver problem.

----------------------------------------------------------------------
 fmoraes - 03-16-05 02:11 
----------------------------------------------------------------------
No longer a driver problem, just a dmix configuration issue now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 16:20 ddemmer        New Issue                                    
01-03-05 16:20 ddemmer        Distribution              => Fedora Core     
01-03-05 16:20 ddemmer        Kernel Version            => 2.6.9-1.681_FC3.i686
01-03-05 16:49 stransky       Issue Monitored: stransky                    
01-04-05 13:43 ddemmer        Issue Monitored: ddemmer                     
01-04-05 13:43 ddemmer        Issue End Monitor: ddemmer                    
01-16-05 14:57 fmoraes        Note Added: 0003217                          
01-16-05 20:43 ddemmer        Note Added: 0003221                          
01-19-05 18:34 ddemmer        Note Added: 0003310                          
01-19-05 20:45 tiwai          Note Added: 0003317                          
01-22-05 23:29 fmoraes        Note Added: 0003383                          
01-23-05 04:52 ddemmer        Note Added: 0003386                          
03-09-05 03:02 fmoraes        Note Added: 0003822                          
03-15-05 01:24 fmoraes        Note Added: 0003912                          
03-15-05 06:02 ddemmer        Note Added: 0003913                          
03-16-05 02:10 fmoraes        Note Added: 0003928                          
03-16-05 02:11 fmoraes        Status                   assigned => closed  
03-16-05 02:11 fmoraes        Note Added: 0003929                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
