From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001995]: Master and PCM control missing
Date: Mon, 3 Apr 2006 06:17:49 +0200
Message-ID: <14191b47b22c514f5fc43fe0402cea3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0F2C19A
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 06:17:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1995> 
======================================================================
Reported By:                baja
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1995
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-03-2006 06:13 CEST
Last Modified:              04-03-2006 06:17 CEST
======================================================================
Summary:                    Master and PCM control missing
Description: 
1.0.11rc3 had the PCM control but the Master control was missing. rc4 now
has both the PCM and the Master volume control missing. 

Drivers loaded:

$ lsmod | grep snd
snd_seq_dummy           3396  0
snd_seq_oss            34240  0
snd_seq_midi_event      7232  1 snd_seq_oss
snd_seq                54528  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          7952  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            42016  0
snd_mixer_oss          16320  1 snd_pcm_oss
snd_hda_intel          16028  1
snd_hda_codec         166536  1 snd_hda_intel
snd_pcm                88396  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              22600  2 snd_seq,snd_pcm
snd                    59072  12
snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          9360  2 snd_hda_intel,snd_pcm

Controls reported by alsa
$ amixer controls
numid=11,iface=MIXER,name='Headphone Playback Switch'
numid=4,iface=MIXER,name='Surround Playback Switch'
numid=3,iface=MIXER,name='Surround Playback Volume'
numid=7,iface=MIXER,name='Center Playback Switch'
numid=5,iface=MIXER,name='Center Playback Volume'
numid=8,iface=MIXER,name='LFE Playback Switch'
numid=6,iface=MIXER,name='LFE Playback Volume'
numid=17,iface=MIXER,name='Line Playback Switch'
numid=16,iface=MIXER,name='Line Playback Volume'
numid=19,iface=MIXER,name='CD Playback Switch'
numid=18,iface=MIXER,name='CD Playback Volume'
numid=13,iface=MIXER,name='Mic Playback Switch'
numid=12,iface=MIXER,name='Mic Playback Volume'
numid=21,iface=MIXER,name='Capture Switch'
numid=23,iface=MIXER,name='Capture Switch',index=1
numid=25,iface=MIXER,name='Capture Switch',index=2
numid=20,iface=MIXER,name='Capture Volume'
numid=22,iface=MIXER,name='Capture Volume',index=1
numid=24,iface=MIXER,name='Capture Volume',index=2
numid=29,iface=MIXER,name='IEC958 Playback Con Mask'
numid=30,iface=MIXER,name='IEC958 Playback Pro Mask'
numid=31,iface=MIXER,name='IEC958 Playback Default'
numid=32,iface=MIXER,name='IEC958 Playback Switch'
numid=34,iface=MIXER,name='IEC958 Capture Default'
numid=33,iface=MIXER,name='IEC958 Capture Switch'
numid=15,iface=MIXER,name='Front Mic Playback Switch'
numid=14,iface=MIXER,name='Front Mic Playback Volume'
numid=2,iface=MIXER,name='Front Playback Switch'
numid=1,iface=MIXER,name='Front Playback Volume'
numid=26,iface=MIXER,name='Input Source'
numid=27,iface=MIXER,name='Input Source',index=1
numid=28,iface=MIXER,name='Input Source',index=2
numid=10,iface=MIXER,name='Side Playback Switch'
numid=9,iface=MIXER,name='Side Playback Volume'

Assuming that that this is an issue since applications look for this
"generic" volume controls.

Thanks

Baja



======================================================================

----------------------------------------------------------------------
 baja - 04-03-06 06:17 
----------------------------------------------------------------------
By the way... I am using a MSi mother board:

MSI K8NGM2-FID Socket 939 NVIDIA GeForce 6150

ls pci reports:

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev
a2)

with snd_hda_intel...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 06:13 baja           New Issue                                    
04-03-06 06:17 baja           Note Added: 0009084                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
