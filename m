From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000813]: Terratec USB surround broken
Date: Wed, 26 Jan 2005 10:40:58 +0100
Message-ID: <9f97e9108430fb084f1898f67b1ae466@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 92AD11F0
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 10:40:58 +0100 (MET)
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
Last Modified:              01-26-2005 10:40 CET
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
 ilikejam - 01-26-05 09:02 
----------------------------------------------------------------------
Also, when recording, I have to record at 48000Hz, then change the sample
rate in Audacity to 44100Hz (without resampling) in order to get the
correct speed.

----------------------------------------------------------------------
 Clemens Ladisch - 01-26-05 10:40 
----------------------------------------------------------------------
The "surround51" device is used to configure some cards for 5.1 output, but
this special configuration is not possible for USB devices because there
are so many different models.

However, USB devices don't need to be separately configured for 5.1
output, so just use a standard device name (like "default" or "plughw" or
"hw").


As for the sample rate:  what are the contents of
/proc/asound/cardX/stream0 while you are recording?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 19:41 ilikejam       New Issue                                    
01-12-05 19:41 ilikejam       Distribution              => Fedora Core 3   
01-12-05 19:41 ilikejam       Kernel Version            => 2.6.10 (ALSA compiled
in)
01-26-05 09:02 ilikejam       Note Added: 0003413                          
01-26-05 10:40 Clemens LadischNote Added: 0003414                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
