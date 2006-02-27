From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001766]: jackd : ALSA: cannot set period size to 1024 frames for capture
Date: Mon, 27 Feb 2006 05:14:57 +0100
Message-ID: <d0710ca94eed2139c550f1caa9b40178@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCE8415D
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 05:14:57 +0100 (MET)
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
Last Modified:              02-27-2006 05:14 CET
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
 Raymond - 02-27-06 05:07 
----------------------------------------------------------------------
Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_pcm.c,v
retrieving revision 1.11
diff -u -r1.11 au88x0_pcm.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	17 Nov 2005 14:55:19
-0000	1.11
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	27 Feb 2006 04:02:30
-0000
@@ -43,10 +43,10 @@
 	.rate_min = 5000,
 	.rate_max = 48000,
 	.channels_min = 1,
-#ifdef CHIP_AU8830
-	.channels_max = 4,
-#else
+#ifndef CHIP_AU8820
 	.channels_max = 2,
+#else
+	.channels_max = 4,
 #endif
 	.buffer_bytes_max = 0x10000,
 	.period_bytes_min = 0x1,
@@ -55,6 +55,26 @@
 	.periods_max = 32,
 };
 
+static struct snd_pcm_hardware snd_vortex_capture_hw_adb = {
+	.info =
+	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
+	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
+	     SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =
+	    SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U8 |
+	    SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = 5000,
+	.rate_max = 48000,
+	.channels_min = 1,
+	.channels_max = 2,
+	.buffer_bytes_max = 0x10000,
+	.period_bytes_min = 0x1,
+	.period_bytes_max = 0x1000,
+	.periods_min = 2,
+	.periods_max = 32,
+};
+
 #ifndef CHIP_AU8820
 static struct snd_pcm_hardware snd_vortex_playback_hw_a3d = {
 	.info =
@@ -116,6 +136,17 @@
 	.periods_max = 64,
 };
 #endif
+
+static unsigned int channels4[3] = {
+	1, 2, 4
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_channels4 = {
+	.count = ARRAY_SIZE(channels4),
+	.list = channels4,
+	.mask = 0,
+};
+
 /* open callback */
 static int snd_vortex_pcm_open(struct snd_pcm_substream *substream)
 {
@@ -154,9 +185,21 @@
 				break;
 			}
 		}
-		if (VORTEX_PCM_TYPE(substream->pcm) == VORTEX_PCM_ADB
-		    || VORTEX_PCM_TYPE(substream->pcm) == VORTEX_PCM_I2S)
-			runtime->hw = snd_vortex_playback_hw_adb;
+		if (VORTEX_PCM_TYPE(substream->pcm) == VORTEX_PCM_ADB) {
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+				runtime->hw = snd_vortex_playback_hw_adb;
+				if (VORTEX_IS_QUAD(vortex)) {
+	        	        	runtime->hw.channels_max = 4;
+					snd_pcm_hw_constraint_list(runtime, 0,
+						SNDRV_PCM_HW_PARAM_CHANNELS,
+						&hw_constraints_channels4);
+				}
+				else
+	        	        	runtime->hw.channels_max = 2;
+			}
+			else 
+				runtime->hw = snd_vortex_capture_hw_adb;
+		};
 		substream->runtime->private_data = NULL;
 	}
 #ifndef CHIP_AU8810

----------------------------------------------------------------------
 rlrevell - 02-27-06 05:14 
----------------------------------------------------------------------
This patch fixes the bug?

Can you send all your au88x0 patches for 1.0.11 to tiwai?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
