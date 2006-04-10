From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002014]: no sound on my asus u5a
Date: Mon, 10 Apr 2006 19:08:45 +0200
Message-ID: <0830125b8590d921046dfa3947b9fa08@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1FE76186
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 19:08:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2014> 
======================================================================
Reported By:                diegor
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2014
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               debian
Kernel Version:             2.6.16.2
======================================================================
Date Submitted:             04-10-2006 16:29 CEST
Last Modified:              04-10-2006 19:08 CEST
======================================================================
Summary:                    no sound on my asus u5a
Description: 
After i loaded the sound driver (snd-hda-intel) with chipset ad1986a, i set
the volume about 80%. The main channel (Vol) il blocked at 100% with
aumix. if i try to launch esd (or play an mp3) the speakers are mute.
After that i've loaded the driver (snd-hda-intel) the pcskeaker (beep) is
mute.
======================================================================

----------------------------------------------------------------------
 diegor - 04-10-06 19:05 
----------------------------------------------------------------------
i'm trying but nothing...
i changed the file patch_analog.c at the line 801.
i changed the ".pci_subdevice = 0x1213" with my number, thus "0x11f7".
now the soundcard play the audio but i see only 4 channel with aumix:
*Master
*Pcm
*Mic
*Igain
The pcspeaker (beep) don't working.

----------------------------------------------------------------------
 tiwai - 04-10-06 19:08 
----------------------------------------------------------------------
Please elaborate what you did, what worked and what didn't work.

The "PC speaker" element is reduced intentionally because it never worked
on others.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-10-06 16:29 diegor         New Issue                                    
04-10-06 16:29 diegor         Distribution              => debian          
04-10-06 16:29 diegor         Kernel Version            => 2.6.16.2        
04-10-06 16:30 diegor         Issue Monitored: diegor                      
04-10-06 16:38 tiwai          Status                   assigned => resolved
04-10-06 16:38 tiwai          Resolution               open => fixed       
04-10-06 16:38 tiwai          Note Added: 0009191                          
04-10-06 17:40 diegor         Status                   resolved => feedback
04-10-06 17:40 diegor         Resolution               fixed => reopened   
04-10-06 17:40 diegor         Note Added: 0009206                          
04-10-06 18:03 diegor         Note Added: 0009207                          
04-10-06 18:10 tiwai          Note Added: 0009208                          
04-10-06 19:05 diegor         Note Added: 0009217                          
04-10-06 19:08 tiwai          Note Added: 0009218                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
