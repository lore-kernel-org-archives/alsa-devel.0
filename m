From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000813]: Terratec USB surround broken
Date: Wed, 23 Feb 2005 22:29:04 +0100
Message-ID: <3453a79e71da2b1da338ad7f5d682358@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E950F204
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 22:29:04 +0100 (MET)
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
Last Modified:              02-23-2005 22:29 CET
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
 Clemens Ladisch - 02-07-05 10:40 
----------------------------------------------------------------------
The contents of the stream0 file indicate that your device doesn't support
any other sample rate than 48 kHz.  So, when recording from a digital
44.1kHz source, the data still gets labeled as "48kHz".

----------------------------------------------------------------------
 ilikejam - 02-23-05 22:29 
----------------------------------------------------------------------
OK. Sounds fair enough.

Having looked at the stream0 output again I noticed that the only playback
rate is  48000. Where is the resampling done if I'm playing a 44100
source? Is it done by ALSA, or the soundcard? Also, is it possible to tell
ALSA not to resample (I'd imagine if I can record 44100 audio without
resampling through the digital connection, I could also play it back in
the same manner, without resampling).

Cheers.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
