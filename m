From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001842]: high frequency whisteling in
	one channel
Date: Sat, 22 Jul 2006 22:44:22 +0200
Message-ID: <85cf7080ea2d21e7bedc53d7468f9603@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 107A6167
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 22:44:22 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.16
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2006 23:17 CET
Last Modified:              07-22-2006 22:44 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001596 No sound or High pitched noise, dissape...
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

----------------------------------------------------------------------
 tiwai - 03-15-06 15:27 
----------------------------------------------------------------------
Try CVS version, and provide the information requested in #1596 if it works
with a proper model option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 23:17 Tolot          New Issue                                    
02-11-06 23:17 Tolot          Kernel Version            => 2.6.15.4        
02-12-06 14:17 Tolot          Note Added: 0008027                          
02-12-06 14:19 Tolot          Issue Monitored: Tolot                       
03-15-06 15:27 tiwai          Relationship added       duplicate of 0001596
03-15-06 15:27 tiwai          Duplicate ID             0 => 1596           
03-15-06 15:27 tiwai          Status                   assigned => resolved
03-15-06 15:27 tiwai          Resolution               open => duplicate   
03-15-06 15:27 tiwai          Note Added: 0008549                          
03-27-06 23:37 Tolot          Distribution              => Gentoo          
03-27-06 23:37 Tolot          Kernel Version           2.6.15.4 => 2.6.16  
03-27-06 23:37 Tolot          Status                   resolved => feedback
03-27-06 23:37 Tolot          Resolution               duplicate => reopened
07-22-06 22:44 Adrian Bunk    Status                   feedback => closed  
07-22-06 22:44 Adrian Bunk    Resolution               reopened => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
