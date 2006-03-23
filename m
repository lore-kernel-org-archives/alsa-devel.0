From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001936]: wont give output and some features not present (i.e. alsamixer)
Date: Thu, 23 Mar 2006 17:40:48 +0100
Message-ID: <a28dcc8e99a69d685c73ad602fe20a40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADB691BB
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 17:40:48 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1936> 
======================================================================
Reported By:                nielsd
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1936
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.16 (vanilla - different rc)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-17-2006 16:33 CET
Last Modified:              03-23-2006 17:40 CET
======================================================================
Summary:                    wont give output and some features not present (i.e.
alsamixer)
Description: 
There comes no audio out. Alsamixer settings unmuted and every
constellation tried. Every model parameter tried. Every DMA setting tried
(fixed position).

Different kernels (build with gcc 3.4 and 4.0) from 2.6.13 up to
2.6.16-rc6 (vanilla) didn't work. Tried to compile the kernel bundeled
alsa and the stable plus unstable actual alsa-driver. Under some
constellations the console hangs during alsa loads.

Under Knoppix Linux (debian fork with own kernel) is no output too - but
alsaconf seems to hang or crash every 2nd time.

Tried two times with earplugs and micro - no work.

The same model only seems to work partly and sometimes under a older
ubuntu kernel 2.6.12-6-386 gcc 3.4.

Can't find any info about the new DELL HDA in google or news...

I "only" like to get the sound running on my notebook - best and nicest
would be with micro... Hope there comes some help in the next for me.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-17-06 16:54 
----------------------------------------------------------------------
Sounds like a same issue with
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1843.

----------------------------------------------------------------------
 tiwai - 03-23-06 17:40 
----------------------------------------------------------------------
Should have been fixed with 1.0.11rc4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 16:33 nielsd         New Issue                                    
03-17-06 16:33 nielsd         Distribution              => Gentoo          
03-17-06 16:33 nielsd         Kernel Version            => 2.6.16 (vanilla -
different rc)
03-17-06 16:54 tiwai          Note Added: 0008648                          
03-23-06 17:40 tiwai          Status                   assigned => resolved
03-23-06 17:40 tiwai          Resolution               open => fixed       
03-23-06 17:40 tiwai          Note Added: 0008894                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
