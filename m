From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001868]: Audigy4 lacks line-in
Date: Tue, 18 Jul 2006 14:39:56 +0200
Message-ID: <d0176ee40ab51d114c0a8bbde07b7fe5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B8DF176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:39:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1868> 
======================================================================
Reported By:                wwp
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1868
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.5
======================================================================
Date Submitted:             02-22-2006 19:12 CET
Last Modified:              07-18-2006 14:39 CEST
======================================================================
Summary:                    Audigy4 lacks line-in
Description: 
I'm not able to get line-in support (un-mute is OK), but PCM out is fine.
Is that because the emu10k1 sources don't include the card IDs for my
model?
Don't know if this would be enough or even right, but here's a patch
proposal for this card's chip detail (attached to this report)
======================================================================

----------------------------------------------------------------------
 wwp - 02-22-06 20:26 
----------------------------------------------------------------------
Ahum, sorry it's kernel 2.6.15.

----------------------------------------------------------------------
 pzad - 02-22-06 20:30 
----------------------------------------------------------------------
Make sure, you have set "Analog Mix", "Line In", "Front", "Master" volume.

----------------------------------------------------------------------
 wwp - 02-26-06 12:06 
----------------------------------------------------------------------
Okay, line-in is working fine now (issue is [FIXED]).. sorry about that,
the cable was faulty.

For the record, here is what `cat /proc/asound/cards` shows:

0 [Audigy2        ]: Audigy2 - Audigy 2 Value [Unknown]
                     Audigy 2 Value [Unknown] (rev.0, serial:0x10211102)
at 0xd400, irq 12
1 [UART           ]: MPU-401 UART - MPU-401 UART
                     MPU-401 UART at 0x330, irq 5

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-06 19:12 wwp            New Issue                                    
02-22-06 19:12 wwp            File Added:
alsa-driver-1.0.11rc3-audigy4-sb0400.diff                    
02-22-06 19:12 wwp            Distribution              => Debian unstable 
02-22-06 19:12 wwp            Kernel Version            => 2.6.5           
02-22-06 19:21 wwp            Issue Monitored: wwp                         
02-22-06 20:26 wwp            Note Added: 0008162                          
02-22-06 20:30 pzad           Note Added: 0008163                          
02-26-06 12:06 wwp            Note Added: 0008199                          
07-18-06 14:39 jcdutton       Status                   new => assigned     
07-18-06 14:39 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
