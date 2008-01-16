From: Timur Tabi <timur@freescale.com>
Subject: Re: SNDRV_PCM_INFO_MMAP - what do I need for it?
Date: Wed, 16 Jan 2008 13:06:00 -0600
Message-ID: <478E5598.9060306@freescale.com>
References: <478E2025.8010509@freescale.com> <s5hy7apr7s0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 28BB42450C
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 20:06:06 +0100 (CET)
In-Reply-To: <s5hy7apr7s0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 16 Jan 2008 09:17:57 -0600,
> Timur Tabi wrote:
>> My 8610 ASoC driver has this:
>>
>> static const struct snd_pcm_hardware fsl_dma_hardware = {
>>
>> 	.info   		= SNDRV_PCM_INFO_INTERLEAVED,
>>
>> This means that MMAP is not enabled.
>>
>> I understand what MMAP is, but not from an ALSA driver perspective.  If I change 
>> the above line to this:
>>
>> 	.info   		= SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP | 
>> SNDRV_PCM_INFO_MMAP_VALID,
>>
>> what does ALSA do differently?  Do I need to define any new functions?  From an 
>> application perspective, what is different?
> 
> It means that the driver supports mmap access to the PCM buffer.
> 
> In some cases, you need to implement a proper mmap callback.  For
> example, when the coheret (dma) pages are allocated via
> dma_alloc_coherent and used for the PCM buffer, you need mmap callback
> for ARM, at least because the default mmap handler in the PCM core
> doesn't work for ARM.  In this case, prepare your own mmap callback
> and pass it to pcm ops.  It should call simply dma_mmap_coherent()
> appropriately.

The default mmap handler in the PCM core is snd_pcm_default_mmap()?

How can I know whether this function works?  Can I just add those two flags to 
my .info line, and then .... ?  Is there an ALSA mmap test utility?

>> Also, does DMIX need MMAP support?
> 
> Yes, mandatory.

So just to be clear: the fact that I do *not* have "SNDRV_PCM_INFO_MMAP | 
SNDRV_PCM_INFO_MMAP_VALID" defined in snd_pcm_hardware.info is the reason why I 
get this error message:

root@MPC8610HPCD:/home/demo_files/mp3# alsaplayer -o alsa -q -F 48000
-d plug:dmix ./527182737.mp3 &
[1] 3224
root@MPC8610HPCD:/home/demo_files/mp3# ALSA lib
pcm_direct.c:874:(snd_pcm_direct_initialize_slave) slave plugin does not
support mmap interleaved or mmap noninterleaved access
ALSA lib pcm_dmix.c:878:(snd_pcm_dmix_open) unable to initialize slave
snd_pcm_open: Invalid argument (plug:dmix)
Failed to initialize plugin!
...

-- 
Timur Tabi
Linux kernel developer at Freescale
