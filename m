From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002228]: error recovery when the no of
	available src is not enough (FATAL: ResManager: resource type
	1 exhaust)
Date: Fri, 30 Jun 2006 02:51:41 +0200
Message-ID: <a8f0d35adcd788e2af6a74b49260beeb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8D54F2AA
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 02:51:41 +0200 (MEST)
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
Last Modified:              06-30-2006 02:51 CEST
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
 Raymond - 06-30-06 02:32 
----------------------------------------------------------------------
Using AOSS is non fatal

aoss mplayer -ao oss *.wav

[AO OSS] audio_setup: Failed to set audio device to 2 channels.
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video
 
 
Exiting... (End of file)

----------------------------------------------------------------------
 Raymond - 06-30-06 02:51 
----------------------------------------------------------------------
static int __devinit vortex_core_init(vortex_t * vortex)
{
        int i;
	for (i=0; i<VORTEX_RESOURCE_LAST; i++) {
		vortex->avail_res[i]=resnum[i];


static char
vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out, int
restype)
{

...
       if ( out ) {

...
			if ((resinuse & (1 << i)) == 0) {
				if (resmap != NULL)
					resmap[restype] |= (1 << i);
				else
					vortex->dma_adb[i].resources[restype] |= (1 << i);
				//printk("vortex: ResManager: type %d out %d\n", restype, i);
				vortex->avail_res[restype]--;
				return i;
			}
		}
	} else {

...

			if (resmap[restype] & (1 << i)) {
				resmap[restype] &= ~(1 << i);
				//printk("vortex: ResManager: type %d in %d\n",restype, i);
				vortex->avail_res[restype]++;
				return i;
			}
        }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-24-06 05:37 Raymond        New Issue                                    
06-26-06 14:20 Raymond        Note Added: 0010534                          
06-30-06 02:32 Raymond        Note Added: 0010712                          
06-30-06 02:51 Raymond        Note Added: 0010713                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
