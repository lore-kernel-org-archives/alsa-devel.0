From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000813]: Terratec USB surround broken
Date: Thu, 24 Feb 2005 16:33:42 +0100
Message-ID: <b81803722ae4cb312b67f6a020a67285@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 50FC2214
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2005 16:33:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=813> 
======================================================================
Reported By:                ilikejam
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   813
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.10 (ALSA compiled in)
======================================================================
Date Submitted:             01-12-2005 19:41 CET
Last Modified:              02-24-2005 16:33 CET
======================================================================
Summary:                    Terratec USB surround broken
Description: 
I'm using a Terratec USB 5.1 card. The 6 channels test correctly using
'./speaker-test -c6', but any attempt to use 5.1 channel in Xine, or using
'aplay -Dsurround51 file.wav' results in errors e.g.
-----
ALSA lib pcm.c:1851:(snd_pcm_open_conf) Invalid type for PCM surround51
definition (id: surround51, value: cards.pcm.surround51)
aplay: main:508: audio open error: Invalid argument
-----
Xine similarly fails saying the sound card is in use. Xine works fine for
stereo audio, even when configured to use 5.1 channel sound.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-24-05 08:55 
----------------------------------------------------------------------
The resampling is done by ALSA (if the device could do it, it would be
indicated in the stream0 file).  Using ALSA device name "default" or
"plughw" enables the "plug" plugin which does automatic resampling and
sample format conversions.

To prevent resampling, use "hw" which goes directly to the hardware.

However, you won't be able to send 44.1 kHz in this way because with
SPDIF, it's always the sending device that determines the speed.

----------------------------------------------------------------------
 ilikejam - 02-24-05 16:33 
----------------------------------------------------------------------
Yup. Right again. (Chipmunks style music with -D hw)

Thanks a lot for your help. I think I'll look for a more capable sound
card...

Dave

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 19:41 ilikejam       New Issue                                    
01-12-05 19:41 ilikejam       Distribution              => Fedora Core 3   
01-12-05 19:41 ilikejam       Kernel Version            => 2.6.10 (ALSA compiled
in)
01-26-05 09:02 ilikejam       Note Added: 0003413                          
01-26-05 10:40 Clemens LadischNote Added: 0003414                          
01-26-05 11:11 ilikejam       Note Added: 0003415                          
01-31-05 20:52 ilikejam       Note Added: 0003458                          
02-07-05 10:40 Clemens LadischNote Added: 0003528                          
02-23-05 22:29 ilikejam       Note Added: 0003716                          
02-24-05 08:55 Clemens LadischNote Added: 0003719                          
02-24-05 16:33 ilikejam       Note Added: 0003722                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
