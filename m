From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 17:29:30 +0100
Message-ID: <20120510162930.GA17361@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 7375D10BAAF
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 18:29:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120510160601.GC12727@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 05:06:01PM +0100, Russell King - ARM Linux wrote:
> I'm wondering what is causing ALSA to behave as follows - I have a 64KiB
> buffer, which is divided up into 4 16KiB periods.  The log below is from
> my soc-dmaengine.c code which supports audio on the Assabet (as we don't
> have cyclic DMA support there yet.)
> 
> I'm just trying to sort out the DMA engine tx_status residue code, and
> am using this as proof that its working.
> 
> However, it seems that ALSA for whatever reason likes to hammer away at
> the pcm_pointer callback from time to time:
> 
> soc_dmaengine_pointer: index 3 stat 1 residue 0018 cookie 3cfe pos 10000 bytes ffe8
> soc_dmaengine_pointer: index 3 stat 1 residue 0008 cookie 3cfe pos 10000 bytes fff8
> soc_dmaengine_callback: complete
> soc_dmaengine_pointer: index 0 stat 1 residue 3ff0 cookie 3cff pos 4000 bytes 0010
> soc_dmaengine_submit: submitting index 3 size 4000 cookie 3d02
> soc_dmaengine_pointer: index 0 stat 1 residue 3fd0 cookie 3cff pos 4000 bytes 0030
> soc_dmaengine_pointer: index 0 stat 1 residue 17b8 cookie 3cff pos 4000 bytes 2848
> soc_dmaengine_pointer: index 0 stat 1 residue 1770 cookie 3cff pos 4000 bytes 2890
> soc_dmaengine_pointer: index 0 stat 1 residue 1768 cookie 3cff pos 4000 bytes 2898
> soc_dmaengine_pointer: index 0 stat 1 residue 1758 cookie 3cff pos 4000 bytes 28a8
> soc_dmaengine_pointer: index 0 stat 1 residue 1748 cookie 3cff pos 4000 bytes 28b8
> soc_dmaengine_pointer: index 0 stat 1 residue 1740 cookie 3cff pos 4000 bytes 28c0
> soc_dmaengine_pointer: index 0 stat 1 residue 1730 cookie 3cff pos 4000 bytes 28d0
> soc_dmaengine_pointer: index 0 stat 1 residue 1720 cookie 3cff pos 4000 bytes 28e0
> soc_dmaengine_pointer: index 0 stat 1 residue 1718 cookie 3cff pos 4000 bytes 28e8
> ...
> soc_dmaengine_pointer: index 0 stat 1 residue 0018 cookie 3cff pos 4000 bytes 3fe8
> soc_dmaengine_pointer: index 0 stat 1 residue 0008 cookie 3cff pos 4000 bytes 3ff8
> soc_dmaengine_callback: complete
> soc_dmaengine_pointer: index 1 stat 1 residue 3ff0 cookie 3d00 pos 8000 bytes 4010
> soc_dmaengine_submit: submitting index 0 size 4000 cookie 3d03
> soc_dmaengine_pointer: index 1 stat 1 residue 3fd0 cookie 3d00 pos 8000 bytes 4030
> soc_dmaengine_pointer: index 1 stat 1 residue 3b28 cookie 3d00 pos 8000 bytes 44d8
> soc_dmaengine_pointer: index 1 stat 1 residue 3b10 cookie 3d00 pos 8000 bytes 44f0
> soc_dmaengine_pointer: index 1 stat 1 residue 3b00 cookie 3d00 pos 8000 bytes 4500
> 
> 'pos' is the end of the current DMA buffer ((index + 1) * period_byte_size)
> 'residue' is the value returned from tx_status
> 'bytes' is the value passed into bytes_to_frames() to return from my
> pcm_pointer function.
> 
> The question is - what would cause ALSA to hammer away at the buffer
> like that - checking it every 16 or 8 DMA bytes transferred?  I'm also
> seeing around 75% system CPU time, which really isn't good.
> 
> The above was captured while aplay was running, with no apparant audio
> corruption.
> 
> Any ideas?

bash-2.05a# cat /proc/asound/card0/pcm0p/sub0/sw_params 
tstamp_mode: NONE
period_step: 1
avail_min: 4096
start_threshold: 16384
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

I think what's happening is that snd_pcm_lib_write1() is looping, and
each time it updates the hardware position, it finds that it can
transfer 8 or 16 bytes to the buffer.  Once it's transferred that,
it re-updates the hardware position which has now advanced by another
8 or 16 bytes.  Repeat, and you find that snd_pcm_lib_write1() spends
a lot of time inefficiently copying the buffer.

It seems that it will only sleep if the hardware pointer stops making
progress.  That implies that I have to purposely reduce the granularity
that I report the current DMA position which isn't a sane thing to do.
