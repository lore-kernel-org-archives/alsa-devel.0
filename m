From: Jack Mitchell <ml@communistcode.co.uk>
Subject: [3.13-rc8] AM335x BeagleBone Buffer XRUN
Date: Tue, 14 Jan 2014 20:31:06 +0000
Message-ID: <52D59E8A.1010400@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D15CE264FB0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 21:31:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

I am currently trying to debug a buffer overrun when capturing with the 
BeagleBone Black and Audio Cape attached on 3.13-rc8, this is pretty 
much the same setup as the am335x-evm. The following is the traceback 
captured using the XRUN_BUFFER_DEBUG kernel config option. I think an 
interrupt is taking too long to return.

Example Traceback 1 (Writing to uSD card)

> [  802.578728] ALSA sound/core/pcm_lib.c:177 XRUN: pcmC0D0c:0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.13.0-rc8-00005-ga6da83f-dirty #12
> [  802.593139] [<c00160e8>] (unwind_backtrace+0x0/0x12c) from [<c0012b08>] (show_stack+0x10/0x14)
> [  802.602174] [<c0012b08>] (show_stack+0x10/0x14) from [<c058c80c>] (dump_stack+0x7c/0x94)
> [  802.610659] [<c058c80c>] (dump_stack+0x7c/0x94) from [<c04862e8>] (xrun+0x80/0xb0)
> [  802.618596] [<c04862e8>] (xrun+0x80/0xb0) from [<c0486e1c>] (snd_pcm_update_state+0xf8/0x100)
> [  802.627531] [<c0486e1c>] (snd_pcm_update_state+0xf8/0x100) from [<c0487048>] (snd_pcm_update_hw_ptr0+0x224/0x82c)
> [  802.638281] [<c0487048>] (snd_pcm_update_hw_ptr0+0x224/0x82c) from [<c0487700>] (snd_pcm_period_elapsed+0xb0/0xf4)
> [  802.649131] [<c0487700>] (snd_pcm_period_elapsed+0xb0/0xf4) from [<c0021458>] (dma_irq_handler+0x130/0x1f4)
> [  802.659345] [<c0021458>] (dma_irq_handler+0x130/0x1f4) from [<c008e504>] (handle_irq_event_percpu+0x5c/0x21c)
> [  802.669735] [<c008e504>] (handle_irq_event_percpu+0x5c/0x21c) from [<c008e700>] (handle_irq_event+0x3c/0x5c)
> [  802.680035] [<c008e700>] (handle_irq_event+0x3c/0x5c) from [<c0091038>] (handle_level_irq+0xac/0x118)
> [  802.689697] [<c0091038>] (handle_level_irq+0xac/0x118) from [<c008dc8c>] (generic_handle_irq+0x28/0x3c)
> [  802.699542] [<c008dc8c>] (generic_handle_irq+0x28/0x3c) from [<c000f968>] (handle_IRQ+0x4c/0xb4)
> [  802.708750] [<c000f968>] (handle_IRQ+0x4c/0xb4) from [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74)
> [  802.718237] [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74) from [<c0592a64>] (__irq_svc+0x44/0x5c)
> [  802.727618] Exception stack(0xc088df58 to 0xc088dfa0)
> [  802.732912] df40:                                                       00000001 00000001
> [  802.741479] df60: 00000000 c0897cb0 c088c000 c088c000 00000000 c0933bd4 c08949a0 c0894880
> [  802.750047] df80: c0894930 c059f4a8 c088c020 c088dfa0 c0082ef8 c000fd00 20070013 ffffffff
> [  802.758620] [<c0592a64>] (__irq_svc+0x44/0x5c) from [<c000fd00>] (arch_cpu_idle+0x20/0x3c)
> [  802.767283] [<c000fd00>] (arch_cpu_idle+0x20/0x3c) from [<c008db84>] (cpu_startup_entry+0x120/0x1f0)
> [  802.776858] [<c008db84>] (cpu_startup_entry+0x120/0x1f0) from [<c0826a9c>] (start_kernel+0x304/0x364)

Example Traceback 2 (Writing to tmpfs)

> [ 1310.025256] ALSA sound/core/pcm_lib.c:177 XRUN: pcmC0D0c:0
> [ 1310.031046] CPU: 0 PID: 998 Comm: avconv Not tainted 3.13.0-rc8-00005-ga6da83f-dirty #12
> [ 1310.039580] [<c00160e8>] (unwind_backtrace+0x0/0x12c) from [<c0012b08>] (show_stack+0x10/0x14)
> [ 1310.048615] [<c0012b08>] (show_stack+0x10/0x14) from [<c058c80c>] (dump_stack+0x7c/0x94)
> [ 1310.057102] [<c058c80c>] (dump_stack+0x7c/0x94) from [<c04862e8>] (xrun+0x80/0xb0)
> 1310.065039] [<c04862e8>] (xrun+0x80/0xb0) from [<c0486e1c>] (snd_pcm_update_state+0xf8/0x100)
> [ 1310.073974] [<c0486e1c>] (snd_pcm_update_state+0xf8/0x100) from [<c0487048>] (snd_pcm_update_hw_ptr0+0x224/0x82c)
> [ 1310.084724] [<c0487048>] (snd_pcm_update_hw_ptr0+0x224/0x82c) from [<c0487700>] (snd_pcm_period_elapsed+0xb0/0xf4)
> [ 1310.095574] [<c0487700>] (snd_pcm_period_elapsed+0xb0/0xf4) from [<c0021458>] (dma_irq_handler+0x130/0x1f4)
> [ 1310.105788] [<c0021458>] (dma_irq_handler+0x130/0x1f4) from [<c008e504>] (handle_irq_event_percpu+0x5c/0x21c)
> [ 1310.116178] [<c008e504>] (handle_irq_event_percpu+0x5c/0x21c) from [<c008e700>] (handle_irq_event+0x3c/0x5c)
> [ 1310.126477] [<c008e700>] (handle_irq_event+0x3c/0x5c) from [<c0091038>] (handle_level_irq+0xac/0x118)
> [ 1310.136138] [<c0091038>] (handle_level_irq+0xac/0x118) from [<c008dc8c>] (generic_handle_irq+0x28/0x3c)
> [ 1310.145982] [<c008dc8c>] (generic_handle_irq+0x28/0x3c) from [<c000f968>] (handle_IRQ+0x4c/0xb4)
> [ 1310.155190] [<c000f968>] (handle_IRQ+0x4c/0xb4) from [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74)
> [ 1310.164677] [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74) from [<c0592a64>] (__irq_svc+0x44/0x5c)
> [ 1310.174056] Exception stack(0xde0f7ee0 to 0xde0f7f28)
> [ 1310.179354] 7ee0: 00000001 00000000 00000000 de3f8a80 00000000 00000002 c0047968 00000054
> [ 1310.187920] 7f00: 00000000 b5440c64 c0933670 beb92fb8 de0f6028 de0f7f28 c0082eb0 c0047348
> [ 1310.196480] 7f20: 60000113 ffffffff
> [ 1310.200153] [<c0592a64>] (__irq_svc+0x44/0x5c) from [<c0047348>] (__do_softirq+0xa8/0x2f4)
> [ 1310.208817] [<c0047348>] (__do_softirq+0xa8/0x2f4) from [<c0047968>] (irq_exit+0xac/0x104)
> [ 1310.217479] [<c0047968>] (irq_exit+0xac/0x104) from [<c000f970>] (handle_IRQ+0x54/0xb4)
> [ 1310.225868] [<c000f970>] (handle_IRQ+0x54/0xb4) from [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74)
> [ 1310.235347] [<c00085b4>] (omap3_intc_handle_irq+0x60/0x74) from [<c0592c3c>] (__irq_usr+0x3c/0x60)
> [ 1310.244724] Exception stack(0xde0f7fb0 to 0xde0f7ff8)
> [ 1310.250019] 7fa0:                                     beb94588 beb92ab8 beb9301c beb93038
> [ 1310.258586] 7fc0: 00088ca0 00000140 00000160 b5440f18 00000080 b5440c64 beb92ab8 beb92fb8
> [ 1310.267150] 7fe0: 4b000001 beb9267c b5f4d6a0 b5f4c8c8 80000010 ffffffff

I have done some tests and capturing to a uSD card is the easiest way to 
trigger XRUNS, where they occur often. Capturing to the eMMC is a little 
bit better. Capturing directly to tmpfs is nearly perfect, apart from 
very rare XRUN occurrences (10 minutes average maybe). This makes sense 
as EDMA is used to perform writes to the uSD and eMMC devices, so if 
they're being hogged with writes, then there is no time to transfer out 
the sound buffer and we get an overrun.

So, does anybody have ideas where to start debugging this further? I 
have tried to increase the buffer size from 32K up to the supposed max 
of 128K but I can't find where to do it... if anyone could shed any 
light I would most grateful, do you think increasing the buffer would 
solve this, as it would give more time to trigger the irq and get the 
data out before overrun?

I have tried multiple userspace programs to do the capture and the best 
so far is arecord initialized like this:

nice -n -20 arecord -D hw:0,0 -f cd -v jack-test.wav

> root@beaglebone:~# nice -n -20 arecord -D hw:0,0 -f dat -v jack-test.wav
> Recording WAVE 'jack-test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> DEBUG: buffer_time = 682667
> DEBUG: max_buffer_size = 32768
> Hardware PCM card 0 'AM335x-EVM' device 0 subdevice 0
> Its setup is:
>   stream       : CAPTURE
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 32768
>   period_size  : 2048
>   period_time  : 42666
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 2048
>   period_event : 0
>   start_threshold  : 1
>   stop_threshold   : 32768
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1073741824
>   appl_ptr     : 0
>   hw_ptr       : 0
> overrun!!! (at least 221.598 ms long)
> Status:
>   state       : XRUN
>   trigger_time: 1389534120.970142840
>   tstamp      : 1389534121.191651631
>   delay       : 0
>   avail       : 32768
>   avail_max   : 32768


If you need any more information or debugging output please let me know.

Regards,

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

-- 
