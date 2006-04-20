From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001835]: Patch to add volume control per voice for au88x0
Date: Thu, 20 Apr 2006 06:04:41 +0200
Message-ID: <e237ab088d94d01fee72f39b242cc1de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 79B92187
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 06:04:41 +0200 (MEST)
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
Last Modified:              04-20-2006 06:04 CEST
======================================================================
Summary:                    Patch to add volume control per voice for au88x0
Description: 
As the proposed API "PCM volume control per snd_pcm_open()" have not been
finalised, I upload the program ( a workaround tool instead of demo ) to
test the new feature "Volume control per voice" for au88x0 using
SNDRV_CTL_ELEM_IFACE_PCM
======================================================================

----------------------------------------------------------------------
 Raymond - 04-11-06 07:32 
----------------------------------------------------------------------
Please note that there is a bug in this patch to handle the flash
browser-plugin using oss emulation

vortex: pcm_open Playback
vortex: pcm_hwparams Playback channels = 1 format =1 rate = 8000
vortex: pcm_hwparams Playback channels = 1 format =2 rate = 8000
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 8000
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 22050
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 22050
vortex: pcm_hw_free Playback
vortex: pcm_close Playback
vortex: pcm_open Playback
vortex: pcm_open Capture
vortex: pcm_hwparams Playback channels = 1 format =1 rate = 8000
vortex: pcm_hwparams Capture  channels = 1 format =1 rate = 8000
vortex: pcm_hwparams Playback channels = 1 format =2 rate = 8000
vortex: pcm_hwparams Capture  channels = 1 format =2 rate = 8000
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 8000
vortex: pcm_hwparams Capture  channels = 2 format =2 rate = 8000
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 22050
vortex: pcm_hwparams Capture  channels = 2 format =2 rate = 22050
vortex: pcm_hwparams Playback channels = 2 format =2 rate = 22050
vortex: start 0
vortex: IRQ fifo error
vortex: stop 0
vortex: start 0
vortex: stop 0
vortex: pcm_hwparams Capture  channels = 2 format =2 rate = 22050
vortex: pcm_hw_free Playback
vortex: pcm_close Playback
vortex: pcm_hw_free Capture
vortex: pcm_close Capture


The disable of kcontrol should be done in vortex_adb_allocroute() before
the resources are checked out instead of snd_vortex_pcm_close()

vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type, int subdev)
{
	stream_t *stream;
	int i, en;
	
	if ((nr_ch == 3)
	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
		return -EBUSY;

	if (dma >= 0) {
	    	if ( dir == SNDRV_PCM_STREAM_PLAYBACK ) {
			if (type == VORTEX_PCM_ADB) {
				snd_vortex_notify_pcm_change(vortex->card, 
                               		vortex->ctl_adb_vol, subdev, 0);
			};
		};
		en = 0;
		vortex_adb_checkinout(vortex,
				      vortex->dma_adb[dma].resources, en,
				      VORTEX_RESOURCE_DMA);
	} else {

The default gain in hardware mixer depend on the route of the equalizer

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1971

Route either the front or rear channels to equalizer seem OK. 

However it's still unstable (system hang) if the capture channels are
routed to the equalizer. 

This allow us to have same default gain of hardware mixer in both front
and rear chanels.(4 speakers mode)

----------------------------------------------------------------------
 Raymond - 04-20-06 06:04 
----------------------------------------------------------------------
Need to move "snd_vortex_mixer(chip)" before snd_vortex_new_pcm(chip,
VORTEX_PCM_ADB, NR_ADB) to ensure vortex->isquad is initialised before
create the kcontrol in snd_vortex_new_pcm() in
au88x0_pcm_vol_using_index_control.patch

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
04-07-06 03:21 ponchick       Note Added: 0009132                          
04-07-06 03:57 Raymond        Note Added: 0009133                          
04-11-06 07:32 Raymond        Note Added: 0009228                          
04-20-06 06:04 Raymond        Note Added: 0009365                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
