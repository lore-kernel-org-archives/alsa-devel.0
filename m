From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000813]: Terratec USB surround broken
Date: Mon, 7 Feb 2005 10:40:31 +0100
Message-ID: <a83cd635c149cacbdf9253e99879deca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CBE5B20B
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 10:40:31 +0100 (MET)
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
Last Modified:              02-07-2005 10:40 CET
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
 ilikejam - 01-31-05 20:52 
----------------------------------------------------------------------
I forgot to mention, I'm recording through the digital (optical) input from
a 44.1kHz source (a MiniDisc deck).

----------------------------------------------------------------------
 Clemens Ladisch - 02-07-05 10:40 
----------------------------------------------------------------------
The contents of the stream0 file indicate that your device doesn't support
any other sample rate than 48 kHz.  So, when recording from a digital
44.1kHz source, the data still gets labeled as "48kHz".

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
