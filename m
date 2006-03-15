From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001914]: playing 2-channel sound on surround device uses rear speakers
Date: Wed, 15 Mar 2006 11:59:19 +0100
Message-ID: <36ecb998e0804cde01a6be4e90ecbf24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2A521F8
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 11:59:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1914> 
======================================================================
Reported By:                mru
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1914
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             03-11-2006 21:25 CET
Last Modified:              03-15-2006 11:59 CET
======================================================================
Summary:                    playing 2-channel sound on surround device uses rear
speakers
Description: 
If I play regular 2-channel stereo sound specifying device "surround51" or
"surround40" (or either of those with a "plug:" prefix) the sound is
output on the rear speakers.  6-channel playback is correct.
======================================================================

----------------------------------------------------------------------
 mru - 03-14-06 23:53 
----------------------------------------------------------------------
Yes, 6-channel playback is fine, as is 2-channel on the "default" device.
I installed alsa-lib 1.0.11-rc3; no change.

----------------------------------------------------------------------
 tiwai - 03-15-06 11:59 
----------------------------------------------------------------------
I understand slowly what's going on there.

The 4.0/5.1 surround outputs use the second DAC.  The behavior of this DAC
is somewhat strange.  If only 2-channel is used, it's routed to rear.  If
4 or more channels are used, it works as 4.0/5.1.

And, in surround40 and surround51 definitions, there is no restriction of
channels.  That is, if the PCM is opened with 2 channels, it is regarded
as the rear output.

Maybe we need a route plugin wrapping surround40/51 to fix the channel
numbers...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 21:25 mru            New Issue                                    
03-11-06 21:25 mru            Distribution              => Gentoo          
03-11-06 21:25 mru            Kernel Version            => 2.6.15-gentoo-r1
03-14-06 15:04 tiwai          Note Added: 0008477                          
03-14-06 15:15 mru            Note Added: 0008478                          
03-14-06 15:22 tiwai          Note Added: 0008481                          
03-14-06 23:53 mru            Note Added: 0008524                          
03-15-06 11:59 tiwai          Note Added: 0008536                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
