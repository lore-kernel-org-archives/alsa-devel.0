From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001978]: rate_min 8000 - return by snd_pcm_hw_params_get_rate_min ()
Date: Wed, 29 Mar 2006 18:49:02 +0200
Message-ID: <b147c4703cc07f48f96a416badff38d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8EDC0132
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:49:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1978> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1978
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2006 15:53 CEST
Last Modified:              03-29-2006 18:49 CEST
======================================================================
Summary:                    rate_min 8000 - return by
snd_pcm_hw_params_get_rate_min ()
Description: 
rate 8000 is returned by snd_pcm_hw_params_get_rate_min() for "hw" device
of intel8x0.

static struct snd_pcm_hardware snd_intel8x0_stream =
{
	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
				 SNDRV_PCM_INFO_MMAP_VALID |
				 SNDRV_PCM_INFO_PAUSE |
				 SNDRV_PCM_INFO_RESUME),
	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
	.rates =		SNDRV_PCM_RATE_48000,
	.rate_min =		48000,
	.rate_max =		48000,
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 18:49 
----------------------------------------------------------------------
The behavior is correct.  The values are overwritten at open.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 15:53 Raymond        New Issue                                    
03-29-06 18:49 tiwai          Status                   new => resolved     
03-29-06 18:49 tiwai          Resolution               open => not an issue
03-29-06 18:49 tiwai          Assigned To               => tiwai           
03-29-06 18:49 tiwai          Note Added: 0008999                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
