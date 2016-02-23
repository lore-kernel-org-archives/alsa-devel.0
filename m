From: Giacomo Comes <comes@naic.edu>
Subject: Re: Compute Stick baytrail audio problem
Date: Tue, 23 Feb 2016 10:34:43 -0400
Message-ID: <20160223143443.GA22458@monopoli.naic.edu>
References: <20160219203900.GA5202@monopoli.naic.edu>
 <56C8826A.3030303@linux.intel.com> <56CBCB86.8040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.naic.edu (mailserver.naic.edu [192.65.176.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CB23260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 15:34:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56CBCB86.8040601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Toyo Abe <toyo.abe@gmail.com>
Cc: Giacomo Comes <comes@naic.edu>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2016 at 12:32:23PM +0900, Toyo Abe wrote:
> 
> Hi,
> 
> I'd struggled a similar underrun problem on my baytrail device. The dmesg showed
> the following warnings.
> 
> [15356.757938] had: Driver detected 2 missed buffer done interrupt(s)!!!!
> [15356.761594] had: Driver detected 1 missed buffer done interrupt(s)!!!!
> [15356.774775] had: Unable to clear UNDERRUN bits
> [15356.791312] had: Driver detected 1 missed buffer done interrupt(s)!!!!
> [15356.808148] had: Unable to clear UNDERRUN bits
> [15356.824692] had: Driver detected 2 missed buffer done interrupt(s)!!!!
> 
> After some investigation, I found some problems on the driver and fixed a few of
> them. I pushed the fix to my github. I hope it might help you.
>   https://raw.githubusercontent.com/toyoabe/baytrailaudio/fix-underrun/hdmi_audio_20150319.patch
> 
> Best Regards,
> -toyo

Hi,
that was it!. I added your changes and now the audio works. I'm happy. 
I got finally every subsystem of the Compute Stick working.
I have a minor question tought. Alsamixer says:
  This sound device does not have any controls.
Is there a way to change the volume without enabling pulseaudio?

Just for documentation, here is the small change that Toyo did to make the 
underrun disappear:

diff -Nraub a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
--- a/drivers/gpu/drm/i915/i915_irq.c	2016-02-23 08:03:42.406016576 -0400
+++ b/drivers/gpu/drm/i915/i915_irq.c	2016-02-23 08:03:58.714016576 -0400
@@ -2717,11 +2717,14 @@
 	int pipe = 1;
 
 	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	i915_enable_lpe_pipestat(dev_priv, pipe);
+
 	imr = I915_READ(VLV_IMR);
 	/* Audio is on Stream A */
 	imr &= ~I915_LPE_PIPE_A_INTERRUPT;
 	I915_WRITE(VLV_IMR, imr);
-	i915_enable_lpe_pipestat(dev_priv, pipe);
+	I915_WRITE(VLV_IER, ~imr);
+	POSTING_READ(VLV_IER);
 	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
 	return 0;
@@ -2769,7 +2772,10 @@
 	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	imr = I915_READ(VLV_IMR);
 	imr |= I915_LPE_PIPE_A_INTERRUPT;
+	I915_WRITE(VLV_IER, ~imr);
 	I915_WRITE(VLV_IMR, imr);
+	POSTING_READ(VLV_IMR);
+
 	i915_disable_lpe_pipestat(dev_priv, pipe);
 	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
diff -Nraub a/sound/hdmi_audio/intel_mid_hdmi_audio.c b/sound/hdmi_audio/intel_mid_hdmi_audio.c
--- a/sound/hdmi_audio/intel_mid_hdmi_audio.c	2016-02-23 08:03:42.414016576 -0400
+++ b/sound/hdmi_audio/intel_mid_hdmi_audio.c	2016-02-23 08:03:58.722016576 -0400
@@ -1128,7 +1128,6 @@
 		pr_debug("HDMI status =0x%x\n", hdmi_status);
 		if (hdmi_status & AUD_CONFIG_MASK_UNDERRUN) {
 			i++;
-			hdmi_status &= ~AUD_CONFIG_MASK_UNDERRUN;
 			had_write_register(AUD_HDMI_STATUS_v2, hdmi_status);
 		} else
 			break;

Thanks again.
Giacomo

> 
> Pierre-Louis Bossart wrote:
> > On 02/19/2016 02:39 PM, Giacomo Comes wrote:
> >> Hi,
> >> I have recently bought a Intel Compute Stick and I am having trouble with=
> >   the audio.
> >> Intel provides a custom Ubuntu release that support audio, but I want to =
> > run the
> >> linux distribution of my choice on it (openSUSE 13.2 for the moment).
> >>
> >> In order to have HDMI audio support it is necessary to compile a kernel w=
> > ith this patch
> >> (https://raw.githubusercontent.com/01org/baytrailaudio/master/hdmi_audio_=
> > 20150319.patch)
> >> provided by Intel for kernel 3.16.7 (https://01.org/ubuntu-hdmi)
> >>
> >> I compiled the openSUSE kernel using the default openSUSE .config plus th=
> > e following:
> >> CONFIG_SUPPORT_HDMI=3Dy
> >> CONFIG_SND_SOC=3Dm
> >> CONFIG_SND_SOC_INTEL_SST=3Dm
> >> CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH=3Dm
> >>
> >> I booted the new kernel and aplay -l gives this output:
> >> **** List of PLAYBACK Hardware Devices ****
> >> card 0: IntelHDMI [IntelHDMI], device 0: IntelHDMI [IntelHDMI]
> >>    Subdevices: 0/1
> >>    Subdevice #0: subdevice #0
> >>
> >> but when I run:
> >>    aplay /usr/share/sounds/alsa/test.wav
> >> the audio plays for .2 seconds and then nothing more.
> >> Sometime it will play later a little bit more and stop again.
> >> At some point these messages appears:
> >> underrun!!! (at least 29325.946 ms long)
> >> underrun!!! (at least 1535.889 ms long)
> >> underrun!!! (at least 3196.213 ms long)
> >>
> >>
> >> I have looked around on google for a hint on how to fix this issue but I =
> > found nothing.
> >> Any idea where to look for a solution?
> >>
> >> Attached there are the dmesg and lsmod output for ubuntu
> >> with the working audio and openSUSE 13.2 plus patch
> >> without the working audio.
> >> I can provide any other information you need.
> > 
> > There are enough messages that make me believe something is very wrong
> > from the start
> > 
> > 19.664486] had: ******** HAD DRIVER loading.. Ver: 0.01.003
> > [   19.664549] hdmi_audio_probe dma_mask: 0
> > [   19.664937] card->dev is NULL!!!!! Should not be this case
> > [   19.668176] [drm] mid_hdmi_audio_register: Scheduling HDMI audio work qu=
> > eue
> > [   19.670745] [drm:i915_had_wq] *ERROR* Checking for HDMI connection at bo=
> > ot
> > 
> > Some of us at Intel are trying to clean this up but it'll take time.
> > 
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
