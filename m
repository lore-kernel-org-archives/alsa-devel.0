From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Sun, 20 Jun 2004 00:06:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087704381.805.20.camel@debian>
References: <1087416890.25102.21.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-b5+Q8LcgH8MXD+7wtbtM"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1087416890.25102.21.camel@debian>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-b5+Q8LcgH8MXD+7wtbtM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-06-16 at 16:14, Lee Revell wrote:
> Hey,
> 
> I am having a problem with the emu10k1 driver where I am unable to set
> the capture period lower than 512.  The result is that the lowest
> achievable input to output latency is in the neighborhood of 40ms.
> 

I think I may have solved this problem.  Here is a patch against
alsa-driver-1.0.5a.

--- alsa-driver-1.0.5a/alsa-kernel/pci/emu10k1/emupcm.c.orig   
2004-06-19 23:21:09.000000000 -0400
+++ alsa-driver-1.0.5a/alsa-kernel/pci/emu10k1/emupcm.c 2004-06-19
23:21:12.000000000 -0400
@@ -932,7 +932,7 @@
        spin_unlock_irqrestore(&emu->reg_lock, flags);
        emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
        emu->pcm_capture_efx_substream = substream;
-       snd_pcm_hw_constraint_list(runtime, 0,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+       // snd_pcm_hw_constraint_list(runtime, 0,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
        return 0;
 }

I do not think that the FX8010 capture device is constrained by the 
period size limitations on the standard emu10k1 capture device.

With this patch I can run JACK in capture only mode with the period size
set as low as 128.  64 gives an error.  This is exactly the expected
behavior: 128 frames is the lowest setting the kX ASIO driver allows.

Now, there is one more issue.  For some reason, in the emu10k1 driver, 
different numbered devices are used for FXBus capture and playback -
capture is hw:0,2 and playback is hw:0,3.  I don't think JACK supports 
full duplex mode if the playback and capture devices are different.  
It seems like these should be part of the same device anyway, they refer
to the exact same registers.

There is no playback device hw:0,2, so I think you can just change the
FX8010 playback device to this.

I think if this is fixed then it will be possible to use the emu10k1 for
low latency/multichannel recording finally.

Lee

--=-b5+Q8LcgH8MXD+7wtbtM
Content-Disposition: attachment; filename=fxbus_capture_fix.patch
Content-Type: text/x-patch; name=fxbus_capture_fix.patch
Content-Transfer-Encoding: 7bit

--- alsa-driver-1.0.3/alsa-kernel/pci/emu10k1/emu10k1_main.c	2004-06-19 17:47:17.000000000 -0400
+++ alsa-driver-1.0.3/alsa-kernel/pci/emu10k1/emu10k1_main.c.orig	2004-05-03 04:43:04.000000000 -0400
@@ -96,10 +96,7 @@
 	int ch, idx, err;
 	unsigned int silent_page;
 
-	if (emu->audigy)
-		emu->fx8010.itram_size = (32 * 1024)/2;
-	else
-		emu->fx8010.itram_size = (16 * 1024)/2;
+	emu->fx8010.itram_size = (16 * 1024)/2;
 	emu->fx8010.etram_pages.area = NULL;
 	emu->fx8010.etram_pages.bytes = 0;
 

--=-b5+Q8LcgH8MXD+7wtbtM--



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
