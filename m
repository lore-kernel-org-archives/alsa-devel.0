From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001766]: jackd : ALSA: cannot set period size to 1024 frames for capture
Date: Mon, 23 Jan 2006 10:36:35 +0100
Message-ID: <dec8b474de8c50404cb6be2833c9e922@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BBCA514B
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 10:36:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1766> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1766
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-21-2006 05:02 CET
Last Modified:              01-23-2006 10:36 CET
======================================================================
Summary:                    jackd : ALSA: cannot set period size to 1024 frames
for capture
Description: 
snd_pcm_hw_params_get_channels_max() return 4 for capture stream

static struct snd_pcm_hardware snd_vortex_playback_hw_adb = {
	.info =
	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
	     SNDRV_PCM_INFO_MMAP_VALID),
	.formats =
	    SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U8 |
	    SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
	.rates = SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min = 5000,
	.rate_max = 48000,
	.channels_min = 1,
#ifdef CHIP_AU8830
	.channels_max = 4,
#else
	.channels_max = 2,
#endif
	.buffer_bytes_max = 0x10000,
	.period_bytes_min = 0x1,
	.period_bytes_max = 0x1000,
	.periods_min = 2,
	.periods_max = 32,
};

static int
vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type)
{
	stream_t *stream;
	int i, en;
	
	if ((nr_ch == 3)
	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
		return -EBUSY;

therefore jackd fail with "ALSA: cannot set period size to 1024 frames for
capture"

jackd -d alsa hw:0 -S
jackd 0.100.9

...
 
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
ALSA: cannot set period size to 1024 frames for capture
ALSA: cannot configure capture channel
cannot load driver module alsa
no message buffer overruns

======================================================================

----------------------------------------------------------------------
 rlrevell - 01-21-06 07:59 
----------------------------------------------------------------------
Yeah I saw that, which is why I deleted my comment ;-)

----------------------------------------------------------------------
 Raymond - 01-23-06 10:36 
----------------------------------------------------------------------
snd_pcm_hw_params_set_period_size() fail with 4 channels playback with
err=-22


jackd -d alsa hw:0 -S -i 2 
jackd 0.100.0

...
 
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|2|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
nperiods = 2 for capture
ALSA: cannot set period size to 1024 frames for playback
ALSA: cannot configure playback channel
cannot load driver module alsa
no message buffer overruns



----------------------------------------------------------------------
jackd -d alsa hw:0 -S -i 2 -o 2
jackd 0.100.0
 
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|2|2|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
 
 
**** alsa_pcm: xrun of at least 0.050 msecs
 
 
 
**** alsa_pcm: xrun of at least 0.045 msecs
 
 
 
**** alsa_pcm: xrun of at least 0.059 msecs
 
 
 
**** alsa_pcm: xrun of at least 0.051 msecs


----------------------------------------------------------------------
jackd -d alsa hw:0 -S -i 2 -o 2 -n 4
jackd 0.100.0

...
 
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|4|48000|2|2|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 4 periods
nperiods = 4 for capture
nperiods = 4 for playback

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-06 05:02 Raymond        New Issue                                    
01-21-06 05:25 rlrevell       Note Added: 0007735                          
01-21-06 05:36 rlrevell       Note Deleted: 0007735                        
01-21-06 07:36 Raymond        Note Added: 0007736                          
01-21-06 07:41 Raymond        Note Edited: 0007736                         
01-21-06 07:59 rlrevell       Note Added: 0007737                          
01-23-06 10:36 Raymond        Note Added: 0007761                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
