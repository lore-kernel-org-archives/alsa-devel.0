From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001615]: No digital passthrough for Creative Audigy 2 NX
Date: Fri, 23 Dec 2005 12:40:08 +0100
Message-ID: <12f26dcb3beb56210dc807ca7e6ba797@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0528016E
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2005 12:40:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1615> 
======================================================================
Reported By:                rev_jazz
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1615
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5-10
Kernel Version:             Linux 2.6.12-9-3
======================================================================
Date Submitted:             12-03-2005 17:06 CET
Last Modified:              12-23-2005 12:40 CET
======================================================================
Summary:                    No digital passthrough for Creative Audigy 2 NX
Description: 
I tried with alsa1.0.9a (on an ubuntu) to wake work the ac3 passthrough
(with an extarnal decoder) usiing the coaxial digital out. It didn't work
fine at all neither using mplayer with -ao alsa:device=default -ac hwac3
nor with xine. mplayer issues in two ways:
1- says :
alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x0 0 AES3 0x02}
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM iec958:{CARD
0 AES0  0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: iec958, value:
cards.pcm.ie c958)


or

2- sends to extarnal amplifier lots of crack and gap noise

It seems to be no configuration way to make the ac3/dts digital out
passthrough work

regards,

jazz
======================================================================

----------------------------------------------------------------------
 rev_jazz - 12-03-05 17:10 
----------------------------------------------------------------------
PS: alsa default is set to PCM

----------------------------------------------------------------------
 Faber - 12-23-05 12:40 
----------------------------------------------------------------------
The problem seems to be that the usb-audio driver doesn't expose an iec958
device.

I have AC3 passthrough working on my system (also using Audigy 2 NX) by
manually patching mplayer to use "hw:0,0" instead of "iec958:AES0=..." and
setting "audio.device.alsa_passthrough_device:hw:0,0" in .xine/config .

You also need to manually turn on Digital Out, set Digital Out Source to
PCM and set all volume controls to 100%.

It would be really nice, however, if the usb-audio driver could expose an
iec958 device and automatically route input to this device around the
mixer and directly to direct out (like it happens with other drivers).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-03-05 17:06 rev_jazz       New Issue                                    
12-03-05 17:06 rev_jazz       Distribution              => Ubuntu 5-10     
12-03-05 17:06 rev_jazz       Kernel Version            => Linux 2.6.12-9-3
12-03-05 17:06 rev_jazz       Issue Monitored: rev_jazz                    
12-03-05 17:10 rev_jazz       Note Added: 0006901                          
12-23-05 12:28 Faber          Issue Monitored: Faber                       
12-23-05 12:40 Faber          Note Added: 0007133                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
