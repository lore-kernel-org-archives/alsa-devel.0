From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001870]: Variable Sample Rate Audio (VSR/VRA) feature not implemented for chip AD1981B to allow output at sample rate other than 48000
Date: Fri, 24 Feb 2006 02:10:27 +0100
Message-ID: <2c2558c2ae2e583db8f0758afcbe9da7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25D3A191
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 02:10:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1870> 
======================================================================
Reported By:                bmill
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1870
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-r2
======================================================================
Date Submitted:             02-23-2006 01:08 CET
Last Modified:              02-24-2006 02:10 CET
======================================================================
Summary:                    Variable Sample Rate Audio (VSR/VRA) feature not
implemented for chip AD1981B to allow output at sample rate other than 48000
Description: 
For soundcards using the audio chip Analog Devices AC '97 SoundMAX Codec
AD1981B, the driver intel8x0 is used. These chips have Variable Sample
Rate Audio which gives Full-Duplex Variable Sample Rate Audio from 7040 hz
to 48 khz in 1 hz increments (see datasheet). The software driver,
however, does not have this feature implemented but rather hardcodes 48000
as the default sample rate without the ability to alter it.

Playback at other sample rates is desired to skip the step of resampling
audio material at samples other than 48000, resultin in better sound
quality with less distortion due to resampling artifacts.

Requesting an implementation of altering the output sample rate via VRA.
======================================================================

----------------------------------------------------------------------
 bmill - 02-24-06 01:51 
----------------------------------------------------------------------
PCM front DAC does turn to 44100. I was wrong to conclude that the VRA
problem was from ALSA, I apologize.

However, running xmms or mplayer (even with -srate 441000) does not alter
the sample rate. Why is this?

----------------------------------------------------------------------
 bmill - 02-24-06 02:10 
----------------------------------------------------------------------
Nevermind, specifying the specific hardware device instead of the mixer
plays at the correct rate.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 01:08 bmill          New Issue                                    
02-23-06 01:08 bmill          Distribution              => Gentoo          
02-23-06 01:08 bmill          Kernel Version            => 2.6.14-r2       
02-23-06 01:14 bmill          File Added: ad1981B.pdf                      
02-23-06 11:08 Clemens LadischNote Added: 0008166                          
02-23-06 11:34 bmill          Note Added: 0008167                          
02-23-06 18:23 Clemens LadischNote Added: 0008168                          
02-24-06 01:51 bmill          Note Added: 0008169                          
02-24-06 02:10 bmill          Note Added: 0008170                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
