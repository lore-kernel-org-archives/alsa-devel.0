From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000884]: Griffin iMic detected but doesnt appear in /proc/asound/cards
Date: Sat, 5 Feb 2005 20:13:45 +0100
Message-ID: <c15da492a1a839252975b2fbe895bba5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F33431BD
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2005 20:13:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=884> 
======================================================================
Reported By:                ostampflee
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   884
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Yellow Dog Linux 4.0.1 RC1
Kernel Version:             2.6.10-1.ydl.1
======================================================================
Date Submitted:             02-05-2005 20:13 CET
Last Modified:              02-05-2005 20:13 CET
======================================================================
Summary:                    Griffin iMic detected but doesnt appear in
/proc/asound/cards
Description: 
dmesg | grep audio says the following:

usbaudio: device 2 audiocontrol interface 0 has 1 input and 1 output
AudioStreaming interfaces
usbaudio: valid input sample rate 6400
usbaudio: valid input sample rate 48000
usbaudio: device 2 interface 2 altsetting 1: format 0x00000040 sratelo
6400 sratehi 48000 attributes 0x01
usbaudio: valid input sample rate 6400
usbaudio: valid input sample rate 48000
usbaudio: device 2 interface 2 altsetting 2: format 0x00000010 sratelo
6400 sratehi 48000 attributes 0x01
usbaudio: valid input sample rate 6400
usbaudio: valid input sample rate 48000
usbaudio: device 2 interface 2 altsetting 3: format 0x80000010 sratelo
6400 sratehi 48000 attributes 0x01
usbaudio: valid output sample rate 6400
usbaudio: valid output sample rate 48000
usbaudio: device 2 interface 1 altsetting 1: format 0x00000010 sratelo
6400 sratehi 48000 attributes 0x01
usbaudio: valid output sample rate 6400
usbaudio: valid output sample rate 48000
usbaudio: device 2 interface 1 altsetting 2: format 0x80000010 sratelo
6400 sratehi 48000 attributes 0x01
usbaudio: registered dsp 14,3
usbaudio: constructing mixer for Terminal 14 type 0x0301
usbaudio: registered mixer 14,0
usbaudio: constructing mixer for Terminal 13 type 0x0101
usbaudio: registered mixer 14,16
usb_audio_parsecontrol: usb_audio_state at c1bf2c00
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
usbcore: registered new driver snd-usb-audio

/proc/asound/cards says the following:
--- no soundcards ---

Of course, alsamixer/aplay doesnt work. The snd-powermac driver works
fine. Both 1.0.8 and the drivers in 2.6.10 have the problem.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-05 20:13 ostampflee     New Issue                                    
02-05-05 20:13 ostampflee     Distribution              => Yellow Dog Linux
4.0.1 RC1
02-05-05 20:13 ostampflee     Kernel Version            => 2.6.10-1.ydl.1  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
