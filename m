From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000746]: No sound when play
Date: Fri, 24 Dec 2004 19:38:53 +0100
Message-ID: <9a819118a849637e67a3ae5fb0b0b21a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D2445241
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2004 19:38:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=746> 
======================================================================
Reported By:                smuslo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   746
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               fedora core 3
Kernel Version:             2.6.9-1.681_FC3.smp
======================================================================
Date Submitted:             12-24-2004 19:34 CET
Last Modified:              12-24-2004 19:38 CET
======================================================================
Summary:                    No sound when play
Description: 
My system :
aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDA [ICH6 HDA], device 0: CMI9880 [CMI9880]
  Subdevices: 1/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0

lsmod
snd_pcm_oss            51496  0
snd_mixer_oss          21632  2 snd_pcm_oss
snd_azx                19312  1
snd_hda_codec          44544  1 snd_azx
snd_pcm                87044  3 snd_pcm_oss,snd_azx,snd_hda_codec
snd_timer              27524  1 snd_pcm
snd                    56804  6
snd_pcm_oss,snd_mixer_oss,snd_azx,snd_hda_codec,snd_pcm,snd_timer
soundcore              12961  2 snd
snd_page_alloc         14088  2 snd_azx,snd_pcm



======================================================================

----------------------------------------------------------------------
 smuslo - 12-24-04 19:38 
----------------------------------------------------------------------
aplay   /usr/share/sounds/info.wav
Playing WAVE '/usr/share/sounds/info.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave) Slave PCM not usable
aplay: set_params:835: Broken configuration for this PCM: no
configurations available

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-04 19:34 smuslo         New Issue                                    
12-24-04 19:34 smuslo         Distribution              => fedora core 3   
12-24-04 19:34 smuslo         Kernel Version            => 2.6.9-1.681_FC3.smp
12-24-04 19:38 smuslo         Issue Monitored: smuslo                      
12-24-04 19:38 smuslo         Note Added: 0002931                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
