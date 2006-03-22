From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001438]: AC3 playback not working with Terratec Aureon 5.1 USB MK-II
Date: Wed, 22 Mar 2006 10:11:56 +0100
Message-ID: <293c616fb5eb578ce4ce7958053e9387@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 871FF18D
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 10:11:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1438> 
======================================================================
Reported By:                mitch_f
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1438
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.4.28-gentoo-r9
======================================================================
Date Submitted:             09-21-2005 21:26 CEST
Last Modified:              03-22-2006 10:11 CET
======================================================================
Summary:                    AC3 playback not working with Terratec Aureon 5.1
USB MK-II
Description: 
If I try to playback a file containing AC3 audio data with mplayer, it
complains with:

alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x00 AES3 0x02}
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM iec958:{CARD
0 AES0 0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: iec958, value:
cards.pcm.iec958)
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.

2-channel audio works fine (analog and SPDIF) and AC3 playback also worked
on the cmipci-based card I used before.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:38 
----------------------------------------------------------------------
Does this device have an AC3 implementation that can be supported?

----------------------------------------------------------------------
 Clemens Ladisch - 03-22-06 10:11 
----------------------------------------------------------------------
The output interface of this device accepts just standard PCM data with
either two or six channels.  There is no visible means of setting the
non-audio bit that would be required for AC3.  I can only guess that it
uses some unknown vendor-specific command for this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-05 21:26 mitch_f        New Issue                                    
09-21-05 21:26 mitch_f        Distribution              => Gentoo          
09-21-05 21:26 mitch_f        Kernel Version            => 2.4.28-gentoo-r9
09-22-05 17:21 Clemens LadischNote Added: 0006354                          
09-22-05 19:32 mitch_f        Note Added: 0006356                          
03-22-06 03:38 rlrevell       Note Added: 0008826                          
03-22-06 10:11 Clemens LadischNote Added: 0008851                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
