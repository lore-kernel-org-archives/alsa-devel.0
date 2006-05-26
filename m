From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001766]: jackd : ALSA: cannot set
	period size to 1024 frames for capture
Date: Fri, 26 May 2006 08:22:45 +0200
Message-ID: <b3893ed31e4d32ba82eb0424737b93e6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B7E2162
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 08:22:46 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              05-26-2006 08:22 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001724 au88x0 PCM configuration problem - buff...
======================================================================

----------------------------------------------------------------------
 Raymond - 05-24-06 13:38 
----------------------------------------------------------------------
There is difference between 

"jackd -d alsa hw:0 -S" 

and 

"jackd -d oss -i4" 

snd_vortex_hw_params() reject 4 channels capture 

snd_vortex_pcm_hw_free()

For ALSA, the parameter stream is NULL, vortex_adb_allocroute() is not
called

For ALSA OSS emulation,
1) the parameter stream is not null
2) stream->dma >=0 
3) stream->nr_ch is equal 1 

the above condition cause the fuction vortex_adb_allocroute() to release
resources which has not been allocated

vortex: FATAL: ResManager: resource type 0 exhausted.
vortex: FATAL: ResManager: resource type 3 exhausted.

The driver should rejct 4 channels capture when
snd_pcm_hw_param_set_channels() is called (i.e. add the correct rule for
channel by snd_vortex_pcm_open()

----------------------------------------------------------------------
 Raymond - 05-26-06 08:22 
----------------------------------------------------------------------
vortex: FATAL: ResManager: resource type 0 exhausted.
vortex: FATAL: ResManager: resource type 3 exhausted.

Those fatal error messages in the system log seem only occur with "jackd
-d oss -i4" , there is no fatal error message in the system log when using
"aoss jackd -d oss -i4"

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
01-23-06 10:42 Raymond        Note Edited: 0007761                         
01-24-06 11:25 Raymond        Note Added: 0007773                          
01-28-06 02:23 Raymond        Note Added: 0007816                          
01-31-06 13:49 perex          Relationship added       related to 0001724  
02-04-06 05:49 Raymond        File Added: au88x0_pcm_channels.patch             
      
02-04-06 06:14 Raymond        Note Added: 0007911                          
02-18-06 08:34 Raymond        Note Added: 0008117                          
02-20-06 15:32 Raymond        Note Edited: 0007773                         
02-27-06 05:07 Raymond        Note Added: 0008213                          
02-27-06 05:14 rlrevell       Note Added: 0008214                          
02-27-06 05:55 Raymond        Note Added: 0008215                          
02-27-06 09:30 Raymond        Note Added: 0008220                          
02-27-06 09:32 Raymond        Note Edited: 0008220                         
02-27-06 19:15 rlrevell       Note Added: 0008228                          
02-28-06 02:44 Raymond        Note Edited: 0008215                         
02-28-06 07:08 Raymond        Note Added: 0008241                          
03-01-06 07:55 Raymond        Note Added: 0008274                          
03-03-06 08:12 Raymond        Note Added: 0008335                          
03-03-06 08:41 mjander        Note Added: 0008337                          
03-03-06 09:02 Raymond        Note Added: 0008338                          
03-03-06 10:49 Raymond        Note Added: 0008340                          
03-03-06 22:36 mjander        Note Added: 0008343                          
03-04-06 04:47 Raymond        Note Edited: 0008241                         
04-06-06 08:41 Raymond        Note Edited: 0008215                         
04-06-06 08:42 Raymond        Note Edited: 0008215                         
05-14-06 13:39 Raymond        Note Deleted: 0007816                        
05-14-06 13:40 Raymond        Note Deleted: 0007773                        
05-14-06 13:41 Raymond        Note Deleted: 0008335                        
05-23-06 03:31 Raymond        Issue Monitored: ponchick                    
05-23-06 03:31 Raymond        Note Added: 0009924                          
05-23-06 03:33 Raymond        Note Edited: 0009924                         
05-23-06 03:39 Raymond        Note Edited: 0009924                         
05-23-06 03:40 Raymond        Note Edited: 0009924                         
05-23-06 03:44 Raymond        Note Edited: 0009924                         
05-24-06 13:38 Raymond        Note Added: 0009955                          
05-24-06 13:48 fuman          Issue Monitored: fuman                       
05-26-06 08:22 Raymond        Note Added: 0009973                          
======================================================================
