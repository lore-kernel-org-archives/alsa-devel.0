From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001434]: Java plugin sound not working in OSS emulation
Date: Tue, 27 Sep 2005 03:54:12 +0200
Message-ID: <c5a964838ec86612954c92d808ef156b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A2FFD18A
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2005 03:54:12 +0200 (MEST)
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
Last Modified:              09-27-2005 03:54 CEST
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

----------------------------------------------------------------------
 xolsonalsa - 09-27-05 03:54 
----------------------------------------------------------------------
Well i was wrong about the 16-bit dma allocation control being changed by
Java Sound. I tried disabling the creation of that control and it still
had the problem.  There is still the bug when both dma8 and dma16 are set
normally and it seems to be related to full duplex operation. In
sb16_main.c, commenting out the control this way fixes the problem:

/*	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
	else */
		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;

commenting out the control this way does not:
/*	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
	else 
		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
*/

-------
So it looks like if pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX; the
problem appears, and if pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX; it
works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-18-05 22:40 xolsonalsa     New Issue                                    
09-23-05 14:46 xolsonalsa     Note Added: 0006367                          
09-25-05 01:07 xolsonalsa     Note Added: 0006380                          
09-25-05 12:38 xolsonalsa     Note Added: 0006385                          
09-27-05 03:54 xolsonalsa     Note Added: 0006402                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
