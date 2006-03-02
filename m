From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Thu, 2 Mar 2006 18:21:58 +0100
Message-ID: <278a0dfd86fb795b412a3e7949de9661@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FB1D1B4
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 18:21:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1887> 
======================================================================
Reported By:                grattemedi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1887
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.2
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             03-01-2006 22:35 CET
Last Modified:              03-02-2006 18:21 CET
======================================================================
Summary:                    Can't record anything from MIC with Acer 1641
(ALC260)
Description: 
With the new hda drivers in CVS, the speakers and jack output works very
good.
But I can't record anything from the external mic or from the mic input.
I followed jwoithe advises : To record from the internal mic or the
external mic jack, you need to:

 * select the "mic" as the input source (displayed in "Playback" view)
 * in the "Mic Jack Mode" control, select "Mic bias 80pc"
 * in "Capture" view, unmute "Capture" channel (NOT "Capture 1") and
   turn its volume up.
Even after doing that, I can't record sound.
Nevertheless, when I unmute the "mic" channel in the alsamixer "playback",
i can hear sound from the mic but i cannot record it.
======================================================================

----------------------------------------------------------------------
 grattemedi - 03-02-06 17:13 
----------------------------------------------------------------------
Hello, thank you for helping me !
So... of course i turned up the "Capture" volume; i've tried with
"Capture" and "Capture1" unmuted and even with "Capture" only. It has the
same effect.
Here is the result of the hexdump :
>hexdump test.wav   
0000000 4952 4646 4424 0000 4157 4556 6d66 2074
0000010 0010 0000 0001 0001 1f40 0000 1f40 0000
0000020 0001 0008 6164 6174 4400 0000 7f7f 7f7f
0000030 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f
*
0000420 7f7f 7f7f 7f7f 7f7f 7f7f 807f 7f7f 7f7f
0000430 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f
*
0004420 7f7f 7f7f 7f7f 7f7f 7f7f 7f7f          
000442c

In all case when i play the recorded file, i hear nothing, no hiss, no
noise...

I added the file test.wav created by the commande: 
> rec test.wav 
and stopped after ~2s by ctrl+c.



----------------------------------------------------------------------
 grattemedi - 03-02-06 18:21 
----------------------------------------------------------------------
I noted something odd : when i use the command amixer i get this :
>amixer
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 35 [100%] [off]
  Front Right: Capture 35 [100%] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 35 [100%] [off]
  Front Right: Capture 35 [100%] [off]

The status is [off] is it normal ?
i didn't succeed in turning this on.
But in alsamixer, i cannot see if the "Capture" is on or off, and the m
key does nothing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 22:35 grattemedi     New Issue                                    
03-01-06 22:35 grattemedi     Distribution              => Slackware 10.2  
03-01-06 22:35 grattemedi     Kernel Version            => 2.6.15.4        
03-01-06 22:36 grattemedi     Issue Monitored: grattemedi                    
03-01-06 22:37 grattemedi     Issue End Monitor: grattemedi                    
03-02-06 00:53 jwoithe        Note Added: 0008289                          
03-02-06 01:19 grattemedi     Note Added: 0008290                          
03-02-06 01:38 jwoithe        Note Added: 0008291                          
03-02-06 08:30 er-ku          Note Added: 0008294                          
03-02-06 11:25 cartman        Issue Monitored: cartman                     
03-02-06 17:10 grattemedi     Note Added: 0008321                          
03-02-06 17:11 grattemedi     File Added: test.wav                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 18:21 grattemedi     Note Added: 0008325                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
