From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: my ALS drv gives DMA underrun
Date: Wed, 28 May 2008 17:17:57 +0200
Message-ID: <483D77A5.5020203@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr11.xs4all.nl (smtp-vbr11.xs4all.nl [194.109.24.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AD102468A
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 17:18:07 +0200 (CEST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m4SFI195012256
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 17:18:06 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

probably this question is asked many times.

Anyway, I hope the experts are willing to help me here.
I simply don't know how to avoid the DMA overrun that I'm facing
when playing a tone.

Here's the thing.

I wrote a (new) ALSA driver (for AD1938 CODEC).

I test it with the ALSA-LIB pcm.c example program and it always
results in a DMA underrun.
I really wonder whether this is due to the driver (me doing something
stupid) or a CPU shortage or something else beyond my control.
(I cannot really imagine it's due to CPU shortage or anything).

I put may printk's in the kernel (in my driver and PCM middle layer).
Here's the full test output/log.

root:/> /mnt/tprogs/pcm -c 2 -r 48000 -o S32_LE -v
Playback device is hw:0,0
Stream parameters are 48000Hz, S32_LE, 2 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
setting start_threshold to (buffer_size=8192 / period_size=1024) * period_size=1024 = 8192
setting avail_min to 1024
Hardware PCM card 0 'ADI ad1938' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S32_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 32
   buffer_size  : 8192
   period_size  : 1024
   period_time  : 21333
   tick_time    : 4000
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 1024
   xfer_align   : 1024
   start_threshold  : 8192
   stop_threshold   : 8192
   silence_threshold: 0
   silence_size : 0
   boundary     : 1073741824


root:/proc/asound/card0>
root:/proc/asound/card0> snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=0) = 8192
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=0, appl_ofs=0
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=1024) = 7168
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=1024) = 7168
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=1024, appl_ofs=1024
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=2048) = 6144
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=2048) = 6144
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=2048, appl_ofs=2048
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=3072) = 5120
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=3072) = 5120
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=3072, appl_ofs=3072
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=4096) = 4096
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=4096) = 4096
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=4096, appl_ofs=4096
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=5120) = 3072
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=5120) = 3072
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=5120, appl_ofs=5120
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=6144) = 2048
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=6144) = 2048
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=6144, appl_ofs=6144
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=7168) = 1024
snd_pcm_lib_write1: (still) to write 1024 frames
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=0 + bz=8192) - apptr=7168) = 1024
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=7168, appl_ofs=7168
snd_pcm_playback_avail(nr=0x0100): avail = (hwptr=0 + bz=8192) - apptr=8192) = 0
snd_pcm_playback_avail(nr=0x0300): avail = (hwptr=0 + bz=8192) - apptr=8192) = 0
snd_pcm_lib_write1: (still) to write 1024 frames
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=24352, frames=761, dma_offset=0x0, dma_last_pos=0x0, dma_pos_base=0x0
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=761 + bz=8192) - apptr=8192) = 761
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=761 + bz=8192) - apptr=8192) = 761
snd_pcm_lib_write1: WAIT
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=45840, frames=1432, dma_offset=0x0, dma_last_pos=0x2f9, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=1432, new_hw_ptr=(hwpb=0 + pos)=1432, hwpi=1024, pz=1024, delta=-408, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=1432 + bz=8192) - apptr=8192) = 1432
snd_pcm_playback_avail(nr=0x0001): avail = (hwptr=1432 + bz=8192) - apptr=8192) = 1432
snd_pcm_lib_write1: WAKE-UP
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=8192, appl_ofs=0
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=81920, frames=2560, dma_offset=0x0, dma_last_pos=0x598, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=2560, new_hw_ptr=(hwpb=0 + pos)=2560, hwpi=2048, pz=1024, delta=-512, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=2560 + bz=8192) - apptr=9216) = 1536
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=114688, frames=3584, dma_offset=0x0, dma_last_pos=0xa00, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=3584, new_hw_ptr=(hwpb=0 + pos)=3584, hwpi=3072, pz=1024, delta=-512, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=3584 + bz=8192) - apptr=9216) = 2560
snd_pcm_lib_write1: (still) to write 1024 frames
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=150368, frames=4699, dma_offset=0x0, dma_last_pos=0xe00, dma_pos_base=0x0
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=4699 + bz=8192) - apptr=9216) = 3675
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=4699 + bz=8192) - apptr=9216) = 3675
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=170664, frames=5333, dma_offset=0x0, dma_last_pos=0x125b, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=5333, new_hw_ptr=(hwpb=0 + pos)=5333, hwpi=4096, pz=1024, delta=-1237, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=5333 + bz=8192) - apptr=9216) = 4309
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=9216, appl_ofs=1024
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=199248, frames=6226, dma_offset=0x0, dma_last_pos=0x14d5, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=6226, new_hw_ptr=(hwpb=0 + pos)=6226, hwpi=6144, pz=1024, delta=-82, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=6226 + bz=8192) - apptr=9216) = 5202
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=229376, frames=7168, dma_offset=0x0, dma_last_pos=0x1852, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=7168, new_hw_ptr=(hwpb=0 + pos)=7168, hwpi=7168, pz=1024, delta=0, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=7168 + bz=8192) - apptr=10240) = 5120
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=262144, frames=8192, dma_offset=0x0, dma_last_pos=0x1c00, dma_pos_base=0x0
snd_pcm_update_hw_ptr_interrupt: pos=0, new_hw_ptr=(hwpb=0 + pos)=0, hwpi=8192, pz=1024, delta=8192, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=8192 + bz=8192) - apptr=10240) = 6144
snd_pcm_lib_write1: (still) to write 1024 frames
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=27384, frames=855, dma_offset=0x0, dma_last_pos=0x0, dma_pos_base=0x2000
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=9047 + bz=8192) - apptr=10240) = 6999
snd_pcm_playback_avail(nr=0x0000): avail = (hwptr=9047 + bz=8192) - apptr=10240) = 6999
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=47744, frames=1492, dma_offset=0x0, dma_last_pos=0x357, dma_pos_base=0x2000
snd_pcm_update_hw_ptr_interrupt: pos=1492, new_hw_ptr=(hwpb=8192 + pos)=9684, hwpi=9216, pz=1024, delta=-468, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=9684 + bz=8192) - apptr=10240) = 7636
snd_pcm_lib_write1: actually wrote 0 frames, err=1024, offset=0, appl_ptr=10240, appl_ofs=2048
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=81920, frames=2560, dma_offset=0x0, dma_last_pos=0x5d4, dma_pos_base=0x2000
snd_pcm_update_hw_ptr_interrupt: pos=2560, new_hw_ptr=(hwpb=8192 + pos)=10752, hwpi=10240, pz=1024, delta=-512, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=10752 + bz=8192) - apptr=11264) = 7680
snd_ad1938_playback_pointer: bytes_per_frame=32, diff=114688, frames=3584, dma_offset=0x0, dma_last_pos=0xa00, dma_pos_base=0x2000
snd_pcm_update_hw_ptr_interrupt: pos=3584, new_hw_ptr=(hwpb=8192 + pos)=11776, hwpi=11264, pz=1024, delta=-512, bz=8192
snd_pcm_playback_avail(nr=0x0010): avail = (hwptr=11776 + bz=8192) - apptr=11264) = 8704
snd_pcm_stop: stopping stream, state=4
snd_pcm_do_stop: SNDRV_PCM_TRIGGER_STOP
snd_pcm_lib_write1: (still) to write 1024 frames


snd_pcm_playback_avail(nr=0x0000) = snd_pcm_lib_write1 calling snd_pcm_playback_avail (1st time)
snd_pcm_playback_avail(nr=0x0001) = snd_pcm_lib_write1 calling snd_pcm_playback_avail (2nd time)
snd_pcm_playback_avail(nr=0x0010) = snd_pcm_update_hw_ptr_post calling snd_pcm_playback_avail
snd_pcm_playback_avail(nr=0x0100) = snd_pcm_playback_hw_avail calling snd_pcm_playback_avail
snd_pcm_playback_avail(nr=0x0300) = snd_pcm_playback_data calling snd_pcm_playback_avail

I hope you're still with me.
so the APP fills the DMA TX buf with 8192 frames.
Then DMA starts.

DMA stops because there's more available in the DMA buffer then stop_threshold.
stop_threshold is max = 8192 frames.
somehow DMA is running faster than the APP.
Probably this is a classic example of a playback underrun.

Most of the times the underrun happens sooner, the APP then not even gets
a chance of writing more frames (than 8192).

so I understand why DMA stops but I don't want it to stop.

Is my driver doing something wrong ?
What can I do to avoid having this underrun ?

Btw. what exactly is the purpose of boundary ?

thanks for any advice,
N. van Bolhuis
--------------

-- 
This message has been scanned for viruses and is believed to be clean
