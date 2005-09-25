From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001434]: Java plugin sound not working in OSS emulation
Date: Sun, 25 Sep 2005 12:38:26 +0200
Message-ID: <8984b4ffee480f5c1f048b7d6b8bcc72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2C9018A
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 12:38:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1434> 
======================================================================
Reported By:                xolsonalsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1434
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-18-2005 22:40 CEST
Last Modified:              09-25-2005 12:38 CEST
======================================================================
Summary:                    Java plugin sound not working in OSS emulation
Description: 
Tried 2 different soundblaster 16 cards, and ISA and a pnp isa vibra 16. 
PCM sounds won't play if the Java Sound Audio Engine (software mixer that
opens /dev/dsp) is in use. Tried it with the JavaSoundDemo and also pogo
games. The symptom is it seems to play one sound and then io through
/dev/dsp becomes blocked. The only workaround is to start the web browser
using aoss so that it opens the native alsa pcm device instead of
/dev/dsp.
======================================================================

----------------------------------------------------------------------
 xolsonalsa - 09-25-05 01:07 
----------------------------------------------------------------------
I also noticed the following dmesg errors in the system logs after
experiencing the problem:
-------------------
ALSA pcm_native.c:1455: playback drain error (DMA or IRQ trouble?)
ALSA ../alsa-kernel/core/pcm_lib.c:2126: playback write error (DMA or IRQ
trouble?)

----------------------------------------------------------------------
 xolsonalsa - 09-25-05 12:38 
----------------------------------------------------------------------
Found out that if you set the card into half duplex mode by setting the
snd-sb16 module parameter dma16 = -1, then the problems go away.  When
both dma8 and dma16 are set to normal values the driver creates a sound
card control called "16-bit DMA Allocation" which allows you to specify
whether the 16 bit dma allocation is Auto, Playback, or Capture (0, 1, or
2).  Since this control is similar to a mixer control it's likely that the
Java Sound is changing it and thats what messes up the DMA and causes the
lockups. Suggested fix: change the 16-bit DMA allocation into a module
parameter instead of a sound card control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-18-05 22:40 xolsonalsa     New Issue                                    
09-23-05 14:46 xolsonalsa     Note Added: 0006367                          
09-25-05 01:07 xolsonalsa     Note Added: 0006380                          
09-25-05 12:38 xolsonalsa     Note Added: 0006385                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
