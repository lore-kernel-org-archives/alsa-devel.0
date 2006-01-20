From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001732]: Support for Intel D945Pvs Board
Date: Fri, 20 Jan 2006 22:47:42 +0100
Message-ID: <7477e83d8937f072254144fcf6c78914@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFE7C17B
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 22:47:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1732> 
======================================================================
Reported By:                timtt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1732
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               FC4
Kernel Version:             2.6.14-1656
======================================================================
Date Submitted:             01-11-2006 04:53 CET
Last Modified:              01-20-2006 22:47 CET
======================================================================
Summary:                    Support for Intel D945Pvs Board
Description: 
Alsa is only able to output regular 2-channel audio via the headphone jack
at the back of this motherboard. This motherboard has an SPDIF connection
available that is currently not supported, but should be.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-11-06 18:36 
----------------------------------------------------------------------
Just unload the module:

  rmmod snd-hda-intel

and reload it like:

  modprobe snd-hda-intel model="5stack-digout"

Repeat as necessary.  If you find one that seems to work, let us know. 
Also include the contents of /proc/asound/cards.

----------------------------------------------------------------------
 timtt - 01-20-06 22:47 
----------------------------------------------------------------------
So I finally got around to trying this. Sorry for the delay. I looked at
the back of the chassis again and it's a 6-stack digital out. I had
initially filed this bug from work, so I wasn't sure. There are 5 analog
jacks and 1 SPDIF.

After trying the model options, I still can't get sound out, so I have
some basic questions:

1) I assume if all is working correctly, I should be able to see a red
light at the other end of the optical cable (the receiver side), right?
2) Should I see a separate volume control in alsamixer for the digital
out? I currently have PCM, Front and Input.
3) I keep my FC4 system up to date with yum, but for some reason the
alsamixer app still says 1.0.10rc3 at the top. Should I be worried about
this?

Here is the /proc/asound/cards output:
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0x59200000 irq 9

Please let me know if you need anything else. I'll be quite available
tonight and over the weekend.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 04:53 timtt          New Issue                                    
01-11-06 04:53 timtt          Distribution              => FC4             
01-11-06 04:53 timtt          Kernel Version            => 2.6.14-1656     
01-11-06 05:04 rlrevell       Note Added: 0007558                          
01-11-06 18:30 timtt          Note Added: 0007563                          
01-11-06 18:36 rlrevell       Note Added: 0007564                          
01-20-06 22:47 timtt          Note Added: 0007728                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
