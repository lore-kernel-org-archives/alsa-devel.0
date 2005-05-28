From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001118]: es1868 - mono recording not working properly
Date: Sat, 28 May 2005 22:18:29 +0200
Message-ID: <5057c6d438cf9c35b4f29aab43ad55d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 211D7139
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 22:18:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1118> 
======================================================================
Reported By:                MStrecke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1118
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.10
======================================================================
Date Submitted:             05-19-2005 23:36 CEST
Last Modified:              05-28-2005 22:18 CEST
======================================================================
Summary:                    es1868 - mono recording not working properly
Description: 
I'm using an old Fujitsu Lifebook E-6570. The on-board sound card is
recognized as "ESS Technology ES1978 Maestro 2E (rev 10)", ID: 125d:1978.

I'm having problems recording mono audio (mic input, line input, etc.).
Only a medium pitched tone is recorded (not a sine waveform, no feed
back).  Stereo recording works without problems (using audacity).

======================================================================

----------------------------------------------------------------------
 tiwai - 05-27-05 12:29 
----------------------------------------------------------------------
Check whether it's a general bug of OSS emulation.  For example, try "rec"
included in sox.

----------------------------------------------------------------------
 MStrecke - 05-28-05 22:18 
----------------------------------------------------------------------
I installed sox and run a few tests using rec.

I can record in stereo (--channels=2) using the following sample sizes
(--size=): b, w, l

Mono only works with --size=b

The other sample sizes did not work with mono, e.g.

  rec --channels=1 --size=w test1.wav

simply returned to the prompt without recording anything. No error
message, no entry in /var/log/messages.

I then returned to audacity to try an 8 bit mono recording, only to
discover that audacity don't support 8 bit recording. All other sample
sizes in audacity (32, 24, 16) produce the above mentioned tone in mono
mode.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-05 23:36 MStrecke       New Issue                                    
05-19-05 23:36 MStrecke       Distribution              => Ubuntu          
05-19-05 23:36 MStrecke       Kernel Version            => 2.6.10          
05-23-05 11:39 tiwai          Note Added: 0004702                          
05-23-05 13:44 MStrecke       File Added: asound.state                     
05-24-05 11:53 tiwai          Note Added: 0004709                          
05-27-05 01:15 MStrecke       Note Added: 0004741                          
05-27-05 12:29 tiwai          Note Added: 0004748                          
05-28-05 22:18 MStrecke       Note Added: 0004776                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
