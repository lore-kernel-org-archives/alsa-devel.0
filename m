From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001620]: snd_hda_intel mixer query problem
Date: Mon, 5 Dec 2005 04:03:33 +0100
Message-ID: <fb7c916acde5e95e4f857571b88f405c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D1C916C
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 04:03:33 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Status:                     new
Distribution:               RedhatFedore core 4
Kernel Version:             2.6.14-1.1644_FC4.root

======================================================================
Date Submitted:             12-05-2005 04:03 CET
Last Modified:              12-05-2005 04:03 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-05 04:03 dja            New Issue                                    
12-05-05 04:03 dja            Distribution              => RedhatFedore core 4
12-05-05 04:03 dja            Kernel Version            =>
2.6.14-1.1644_FC4.root

======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
