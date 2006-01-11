From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001739]: Hardware mixing with OSS and SiS SI7012 with ALC203 not working
Date: Wed, 11 Jan 2006 19:54:48 +0100
Message-ID: <db273d6cadbf810c766f0cd201c32743@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50A10160
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 19:54:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1739> 
======================================================================
Reported By:                rg3
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1739
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware Linux ("current" branch)
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 19:43 CET
Last Modified:              01-11-2006 19:54 CET
======================================================================
Summary:                    Hardware mixing with OSS and SiS SI7012 with ALC203
not working
Description: 
Hello,

First off, sorry if this is too vague and not attached to the right
component. It's my first bug report.

I have an Acer Aspire 3003WLMi laptop with a SiS SI7012 sound card
according to /proc/asound/oss/sndstat. This is the corresponding entry to
the device in lspci:

00:02.7 Class 0401: 1039:7012 (rev a0)
        Subsystem: 1025:0083
        Flags: bus master, medium devsel, latency 173, IRQ 18
        I/O ports at 1400 [size=256]
        I/O ports at 1c80 [size=128]
        Capabilities: [48] Power Management version 2

This card uses the snd_intel8x0 ALSA driver and works pretty well,
allowing hardware mixing AFAIK. Running two instances of aplay at the same
time works and plays the two sounds simultaneously. However, hardware
mixing doesn't seem to work with OSS emulation. With the snd_pcm_oss
module loaded, running two instances of the "play" program doesn't work.
The second one fails with the error:

sox: Can't open output file '/dev/dsp': Device or resource busy

I don't know if this is supposed to happen, is a bug or is my fault. If I
use the "aoss" command to launch the "play" command, it works, like aplay.
I recall having a card that allowed hardware mixing under ALSA, and being
able to play several sounds at the same time under OSS too. That's why I
find this strange. 

I don't have an ~/.asoundrc file. Thanks for your time and don't hesitate
to ask for any missing piece of information relevant to the report, as I'm
not sure what is exactly needed.

Best regards and thanks again,

-Ricardo García
======================================================================

----------------------------------------------------------------------
 pzad - 01-11-06 19:54 
----------------------------------------------------------------------
If you are using snd-intel8x0 driver, than your card doesn't have hw
mixing. You are user of dmix. OSS emulation doesn't use dmix. You have to
use alsa applications only or you can try to use aoss program with oss
apps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 19:43 rg3            New Issue                                    
01-11-06 19:43 rg3            Distribution              => Slackware Linux
("current" branch)
01-11-06 19:43 rg3            Kernel Version            => 2.6.15          
01-11-06 19:45 rg3            Issue Monitored: rg3                         
01-11-06 19:54 pzad           Note Added: 0007566                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
