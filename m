From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001835]: Patch to add volume control per voice for au88x0
Date: Wed, 29 Mar 2006 17:44:48 +0200
Message-ID: <051324ea476bc2716658af3de94e9d19@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34970181
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 17:44:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1835
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-10-2006 03:28 CET
Last Modified:              03-29-2006 17:44 CEST
======================================================================
Summary:                    Patch to add volume control per voice for au88x0
Description: 
As the proposed API "PCM volume control per snd_pcm_open()" have not been
finalised, I upload the program ( a workaround tool instead of demo ) to
test the new feature "Volume control per voice" for au88x0 using
SNDRV_CTL_ELEM_IFACE_PCM
======================================================================

----------------------------------------------------------------------
 Raymond - 02-22-06 09:57 
----------------------------------------------------------------------
You can change the volume calculation of two/four speakers routine in the
patched aplay for testing the volume per voice feature.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726

----------------------------------------------------------------------
 Raymond - 03-29-06 17:44 
----------------------------------------------------------------------
au88x0_pcm_vol_using_index_control.patch

Using the new feature "Subdevice Playback Volume" with a hooked ctl in
au88x0.conf to implement a "rear" device for au8830 with 4-channels codec
to mute the front channels.


<confdir:pcm/rear.conf>

AU8830.pcm.rear.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				interface PCM
				device 0
				name "Subdevice Playback Volume"
				index { @func private_pcm_subdevice }
				value [ -64 -64 8 8 ]
			}
		]
	}
}	


The outstanding issue is the fifo error when playing stereo/4 channels
sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 03:28 Raymond        New Issue                                    
02-10-06 03:30 Raymond        File Added: iface_pcm.c                      
02-11-06 11:19 Raymond        Note Added: 0008014                          
02-13-06 16:07 Raymond        Note Added: 0008053                          
02-22-06 08:59 Raymond        File Added:
vol_ctrl_per_voice_testing_using_aplay.patch                    
02-22-06 09:57 Raymond        Note Added: 0008156                          
03-29-06 16:15 Raymond        File Added:
au88x0_pcm_vol_using_index_control.patch                    
03-29-06 17:44 Raymond        Note Added: 0008994                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
