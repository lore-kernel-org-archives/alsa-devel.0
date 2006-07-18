From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001709]: 5.1 doesn't work
Date: Tue, 18 Jul 2006 14:40:50 +0200
Message-ID: <69001df1b6ce45984d27a6a91dc3f96e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 243FD176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:40:51 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1709> 
======================================================================
Reported By:                piezo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1709
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369
======================================================================
Date Submitted:             01-04-2006 13:50 CET
Last Modified:              07-18-2006 14:40 CEST
======================================================================
Summary:                    5.1 doesn't work
Description: 
I'm new to linux.  I've been googling for a awnser to this problem for a
week now.  found a few with the same sort of problems but no awnsers.

I can get sterio sound but not 5.1 surround.  This is very irritating as I
bought a Audity2 soundcard for the purpose of using it's 5.1 sound
capability.

initially xine kept telling me that another process was using the PCM
device.  found how to fix this.  using
======================================================================

----------------------------------------------------------------------
 piezo - 01-05-06 00:23 
----------------------------------------------------------------------
"Sound Blaster Audigy 2 value" pci card
followed the Alsa setup instructions.
detected correctly (SB0400)

can only seem to use it in sterio or (with fixes) fake 5.1 (which is
really sterio duplicated).

----------------------------------------------------------------------
 rlrevell - 01-05-06 22:02 
----------------------------------------------------------------------
2.6.11 is way too old for such a new device.  Try a newer kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 13:50 piezo          New Issue                                    
01-04-06 13:50 piezo          Distribution              => Fedora Core 4   
01-04-06 13:50 piezo          Kernel Version            => 2.6.11-1.1369   
01-05-06 00:23 piezo          Note Added: 0007461                          
01-05-06 22:02 rlrevell       Note Added: 0007483                          
07-18-06 14:40 jcdutton       Status                   new => assigned     
07-18-06 14:40 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
