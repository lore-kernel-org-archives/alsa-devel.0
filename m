From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001620]: snd_hda_intel mixer query
	problem
Date: Sat, 5 Aug 2006 13:17:51 +0200
Message-ID: <6b489050728f6aea24ca5c9f24dd6cc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7EB50C8
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:17:51 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1620> 
======================================================================
Reported By:                dja
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1620
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               RedhatFedore core 4
Kernel Version:             2.6.14-1.1644_FC4.root

Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-05-2005 04:03 CET
Last Modified:              08-05-2006 13:17 CEST
======================================================================
Summary:                    snd_hda_intel mixer query problem
Description: 
I have a system with an Asus board (intel 915 shipset) with the outboard
sound:

00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 05)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8181
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at cddf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Modules load,  cannot load alsamixer or amixer to unmute channels
amixer reports:
amixer: Mixer default load error: Invalid argument

however on further inspection:
# amixer controls
numid=28,iface=MIXER,name='PCM Playback Volume'
numid=5,iface=MIXER,name='Center Playback Switch'
amixer: Control default snd_hctl_elem_info error: Invalid argument

# amixer contents
numid=28,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0
  : values=255,255
numid=5,iface=MIXER,name='Center Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
amixer: Control default snd_hctl_elem_info error: Invalid argument


I'll take a stab that the snd_hctl_elem_info error is being fed back
invalid information from snd_hda_intel ?  

When these commands are run this message comes up in dmesg each time:
hda_codec: num_steps = 0 for NID=0x9

playing audio seems to work though no sound is heard. (I suspect all
channels are muted as default, only I can't unmute them because of this)

the kernel is 2.6.14-1.1644_FC4.root


======================================================================

----------------------------------------------------------------------
 tiwai - 12-06-05 15:56 
----------------------------------------------------------------------
Try the latest ALSA CVS version.  The detection should have been improved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-05 04:03 dja            New Issue                                    
12-05-05 04:03 dja            Distribution              => RedhatFedore core 4
12-05-05 04:03 dja            Kernel Version            =>
2.6.14-1.1644_FC4.root

12-06-05 15:56 tiwai          Note Added: 0006927                          
08-05-06 13:17 Adrian Bunk    Status                   new => resolved     
08-05-06 13:17 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
