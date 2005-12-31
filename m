From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001678]: nForce (10de:026c) left channel squeals, right channel mostly okay
Date: Sat, 31 Dec 2005 10:16:56 +0100
Message-ID: <1d391149820e6bffd06f306c1a0cc642@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC3CD121
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 10:16:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678> 
======================================================================
Reported By:                kees
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1678
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.15-rc6-git4
======================================================================
Date Submitted:             12-25-2005 02:29 CET
Last Modified:              12-31-2005 10:16 CET
======================================================================
Summary:                    nForce (10de:026c) left channel squeals, right
channel mostly okay
Description: 
This is an integrated chipset on an ASUS A8N-VM-UAYGZ mobo.  Marketing info
is this is an "nForce410" board, with "6-channel HD audio".

Both the ALSA in 2.6.15-rc6-git4 and the 1.0.11rc1 ALSA driver for
snd-hda-intel load fine, but during playback, the left channel squeals,
while the right seems to play things okay.

I'm happy to dig around and try whatever needs trying to get this fixed. 
Thanks!
======================================================================

----------------------------------------------------------------------
 morgoth666 - 12-30-05 23:50 
----------------------------------------------------------------------
Hi all

Just for completeness: I have the same problem on ASUS A8N-VM-CSM mobo
(with AD1986A chip), kernel 2.6.15-rc7, alsa CVS downloaded on Dec,30
2005.

my lspci gives the same as in previous note (with more capabilities !):
0000:00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [6c] #08 [a802]

It seems that the problem is related to surround sound: see a quick
workaround here =>
http://www.nabble.com/Intel-HDA-AD1986A-without-surround-t595968.html

Hope this helps !

----------------------------------------------------------------------
 kees - 12-31-05 10:16 
----------------------------------------------------------------------
Confirmed.  My /proc/asound/card0/codec#0 matches:

$ head /proc/asound/card0/codec#0 
Codec: Analog Devices AD1986A
Address: 0
Vendor Id: 0x11d41986
Subsystem Id: 0x104381b3
Revision Id: 0x100400

Applying the patch fixes stereo sound -- I'm not interested in digital
surround yet, so I can wait.  THANK YOU morgoth666!  :)  I had found that
patch earlier, but couldn't re-locate later on.  :):)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-25-05 02:29 kees           New Issue                                    
12-25-05 02:29 kees           Distribution              => Ubuntu Breezy   
12-25-05 02:29 kees           Kernel Version            => 2.6.15-rc6-git4 
12-26-05 11:02 kees           Note Added: 0007149                          
12-30-05 23:43 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:43 morgoth666     Issue End Monitor: morgoth666                    
12-30-05 23:44 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:50 morgoth666     Note Added: 0007300                          
12-31-05 05:47 Dr Hotdog      Issue Monitored: Dr Hotdog                    
12-31-05 10:16 kees           Note Added: 0007355                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
