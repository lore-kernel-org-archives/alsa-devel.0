From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Compute Stick baytrail audio problem
Date: Sat, 20 Feb 2016 09:12:42 -0600
Message-ID: <56C8826A.3030303@linux.intel.com>
References: <20160219203900.GA5202@monopoli.naic.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B2C26145B
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 16:12:45 +0100 (CET)
In-Reply-To: <20160219203900.GA5202@monopoli.naic.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Giacomo Comes <comes@naic.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/19/2016 02:39 PM, Giacomo Comes wrote:
> Hi,
> I have recently bought a Intel Compute Stick and I am having trouble with the audio.
> Intel provides a custom Ubuntu release that support audio, but I want to run the 
> linux distribution of my choice on it (openSUSE 13.2 for the moment).
> 
> In order to have HDMI audio support it is necessary to compile a kernel with this patch
> (https://raw.githubusercontent.com/01org/baytrailaudio/master/hdmi_audio_20150319.patch)
> provided by Intel for kernel 3.16.7 (https://01.org/ubuntu-hdmi)
> 
> I compiled the openSUSE kernel using the default openSUSE .config plus the following:
> CONFIG_SUPPORT_HDMI=y
> CONFIG_SND_SOC=m
> CONFIG_SND_SOC_INTEL_SST=m
> CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH=m
> 
> I booted the new kernel and aplay -l gives this output:
> **** List of PLAYBACK Hardware Devices ****
> card 0: IntelHDMI [IntelHDMI], device 0: IntelHDMI [IntelHDMI]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
> 
> but when I run:
>   aplay /usr/share/sounds/alsa/test.wav
> the audio plays for .2 seconds and then nothing more.
> Sometime it will play later a little bit more and stop again.
> At some point these messages appears:
> underrun!!! (at least 29325.946 ms long)
> underrun!!! (at least 1535.889 ms long)
> underrun!!! (at least 3196.213 ms long)
> 
> 
> I have looked around on google for a hint on how to fix this issue but I found nothing.
> Any idea where to look for a solution?
> 
> Attached there are the dmesg and lsmod output for ubuntu
> with the working audio and openSUSE 13.2 plus patch
> without the working audio.
> I can provide any other information you need.

There are enough messages that make me believe something is very wrong from the start

19.664486] had: ******** HAD DRIVER loading.. Ver: 0.01.003
[   19.664549] hdmi_audio_probe dma_mask: 0
[   19.664937] card->dev is NULL!!!!! Should not be this case
[   19.668176] [drm] mid_hdmi_audio_register: Scheduling HDMI audio work queue
[   19.670745] [drm:i915_had_wq] *ERROR* Checking for HDMI connection at boot

Some of us at Intel are trying to clean this up but it'll take time. 
