From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001118]: es1868 - mono recording not working properly
Date: Wed, 22 Mar 2006 00:38:41 +0100
Message-ID: <f36c0b900c9465071954a7b4dae9e1cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 541DA1DE
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 00:38:41 +0100 (MET)
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
Last Modified:              03-22-2006 00:38 CET
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

----------------------------------------------------------------------
 rlrevell - 03-22-06 00:38 
----------------------------------------------------------------------
Do you still consider this a bug?

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
09-26-05 10:28 LawrenceG      Issue Monitored: LawrenceG                    
03-22-06 00:38 rlrevell       Note Added: 0008764                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
