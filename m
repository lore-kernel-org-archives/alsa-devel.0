From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002228]: error recovery when the no of
	available src is not enough (FATAL: ResManager: resource type
	1 exhaust)
Date: Sat, 1 Jul 2006 03:22:14 +0200
Message-ID: <4fb31ece19e38441838746efe69a2615@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4186517B
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 03:22:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2228> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   2228
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-24-2006 05:37 CEST
Last Modified:              07-01-2006 03:22 CEST
======================================================================
Summary:                    error recovery when the no of available src is not
enough (FATAL: ResManager: resource type 1 exhaust)
Description: 
This is simulated by reducing the no of available SRC to 3.

static int __devinit vortex_core_init(vortex_t * vortex)
{
+        vortex->fixed_res[VORTEX_RESOURCE_SRC] = 0x0000fff8;


aplay out1lq.wav   
Playing WAVE 'out1lq.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Channels 4
aplay: set_params:962: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 64
CHANNELS: 4
RATE: 22050
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 512
PERIOD_BYTES: 4096
PERIODS: 16
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 8192
BUFFER_BYTES: 65536
TICK_TIME: 10000

dmesg
vortex: FATAL: ResManager: resource type 1 exhausted.

aplay outls.wav
Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

dmesg
vortex_adb_delroutes: route not found! 0x2060
vortex_adb_delroutes: route not found! 0x2161

It seem that the driver need to check the no of available SRC is enough
before the SRC are checked out one by one from ResManager, the driver seem
unable to perform error recovery           

 
======================================================================

----------------------------------------------------------------------
 Raymond - 06-30-06 03:14 
----------------------------------------------------------------------
We still need to reject OSS application (e.g. flash plugin of web browser)
at snd_vortex_pcm_open() to prevent fatal condition (e.g.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047 and
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=343 ) when resources is
not enough


static int
vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type)
{
	
...

	/* PLAYBACK ROUTES. */
	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {

...

		/* Get SRC and MIXER hardware resources. */
		if (stream->type != VORTEX_PCM_SPDIF) {
			if ( en ) {
	                        if (( vortex->avail_res[VORTEX_RESOURCE_SRC] <
nr_ch ) ||
				    ( vortex->avail_res[VORTEX_RESOURCE_MIXIN] < nr_ch )) {
					printk(KERN_INFO "vortex : not enough resources\n");	
					return -EBUSY;
				}
			}

...

	/* CAPTURE ROUTES. */
	} else {
		int src[2], mix[2];
		if ( en ) {
                        if (( vortex->avail_res[VORTEX_RESOURCE_SRC] <
nr_ch ) ||
			    ( vortex->avail_res[VORTEX_RESOURCE_MIXOUT] < nr_ch )) {
				printk(KERN_INFO "vortex : not enough resources\n");	
				return -EBUSY;
			}
		}

----------------------------------------------------------------------
 Raymond - 07-01-06 03:22 
----------------------------------------------------------------------
Since resource DMA is still leaked, this seem better but need to perform
stress test to see if there is any side efffect on
snd_pcm_vortex_hw_free() 


static int
vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type)
{
	stream_t *stream;
	int i, en;
	
	if ((nr_ch == 3)
	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
		return -EBUSY;

	if (dma >= 0) {
		en = 0;
		vortex_adb_checkinout(vortex,
				      vortex->dma_adb[dma].resources, en,
				      VORTEX_RESOURCE_DMA);
	} else {
		en = 1;
		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
			if (type != VORTEX_PCM_SPDIF) {
	                        if (( vortex->avail_res[VORTEX_RESOURCE_SRC] <
nr_ch ) ||
				    ( vortex->avail_res[VORTEX_RESOURCE_MIXIN] < nr_ch )) {
					printk(KERN_INFO "vortex : not enough resources\n");	
					return -EBUSY;
				}
			}
		}
		else {
                        if (( vortex->avail_res[VORTEX_RESOURCE_SRC] <
nr_ch ) ||
			    ( vortex->avail_res[VORTEX_RESOURCE_MIXOUT] < nr_ch )) {
				printk(KERN_INFO "vortex : not enough resources\n");	
				return -EBUSY;
			}
		}
		if ((dma =
		     vortex_adb_checkinout(vortex, NULL, en,
					   VORTEX_RESOURCE_DMA)) < 0)
			return -EBUSY;
	}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-24-06 05:37 Raymond        New Issue                                    
06-26-06 14:20 Raymond        Note Added: 0010534                          
06-30-06 02:32 Raymond        Note Added: 0010712                          
06-30-06 02:51 Raymond        Note Added: 0010713                          
06-30-06 03:14 Raymond        Note Added: 0010714                          
07-01-06 03:22 Raymond        Note Added: 0010754                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
