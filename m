From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001739]: Hardware mixing with OSS and SiS SI7012 with ALC203 not working
Date: Wed, 11 Jan 2006 20:07:06 +0100
Message-ID: <1b3af825f8cf771153458f0cccfb626e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAADE160
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 20:07:06 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Slackware Linux ("current" branch)
Kernel Version:             2.6.15
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-11-2006 19:43 CET
Last Modified:              01-11-2006 20:07 CET
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
 rg3 - 01-11-06 20:04 
----------------------------------------------------------------------
Thanks a lot for the quick and informative response. I didn't know that.
I'll try to use aoss whenever possible. I suppose it's not going to be a
problem because I only use this computer to listen to music and play
movies, in the sound department.

Thanks again and greetings,

-Ricardo García

----------------------------------------------------------------------
 rlrevell - 01-11-06 20:07 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 19:43 rg3            New Issue                                    
01-11-06 19:43 rg3            Distribution              => Slackware Linux
("current" branch)
01-11-06 19:43 rg3            Kernel Version            => 2.6.15          
01-11-06 19:45 rg3            Issue Monitored: rg3                         
01-11-06 19:54 pzad           Note Added: 0007566                          
01-11-06 20:04 rg3            Note Added: 0007567                          
01-11-06 20:07 rlrevell       Status                   new => closed       
01-11-06 20:07 rlrevell       Note Added: 0007568                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
