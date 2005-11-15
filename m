From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001558]: snd_pcm_hw_params fails with snd_intel8x0 on fl32, 96kHz streams
Date: Tue, 15 Nov 2005 17:38:57 +0100
Message-ID: <a2f9d6ac6c4f6acfa06187c08cfb7c07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E08919A
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2005 17:38:58 +0100 (MET)
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


The following issue has been CONFIRMED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1558> 
======================================================================
Reported By:                bigben
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1558
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     confirmed
======================================================================
Date Submitted:             11-14-2005 18:30 CET
Last Modified:              11-15-2005 17:38 CET
======================================================================
Summary:                    snd_pcm_hw_params fails with snd_intel8x0 on fl32,
96kHz streams
Description: 
It seems you cannot play fl32, 96kHz streams on a device using the
snd_intel8x0 driver module (tested on a nforce2 as well as other intel
chipsets, alsa 1.0.9 and 1.0.10rc2,
2.6.13 and 2.6.14 kernels). s16l or rates until 95999 Hz work well. Other
drivers
(snd_emu10k1 and snd_powermac) seem to work well. Software resampling is
enabled on the devices (snd_pcm_hw_params_set_rate_resample).

The error occurs on snd_pcm_hw_params (alsa doesn't complain on
snd_pcm_hw_params_set_rate_near or snd_pcm_hw_params_set_format). The
error code is -22 (invalid argument).
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-15-05 17:38 
----------------------------------------------------------------------
Reproducible with "aplay -D plughw:0 -t raw -f FLOAT_LE -c 2 -r 96001 -v
/dev/zero".

This seems to be a problem in the plug plugin which tries to create a rate
plugin for a non-linear sample format.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-05 18:30 bigben         New Issue                                    
11-15-05 17:38 Clemens LadischNote Added: 0006732                          
11-15-05 17:38 Clemens LadischStatus                   new => confirmed    
11-15-05 17:38 Clemens LadischCategory                 hw specific configuration
=> 1_pcm - digital audio
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
