From: Tim Harvey <tim_harvey@yahoo.com>
Subject: Re: Questions about writing a new ALSA driver for a
	very limitted device
Date: Thu, 26 Apr 2007 15:30:41 -0700 (PDT)
Message-ID: <20131.44734.qm@web35606.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web35606.mail.mud.yahoo.com (web35606.mail.mud.yahoo.com
	[66.163.179.145]) by alsa0.perex.cz (Postfix) with SMTP id 9AB7B24ABB
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 00:30:42 +0200 (CEST)
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

Thanks to the help I've gotten on this list my alsa driver is working great.  I
got a little hung up not realizing that the alsa core basically provides
everything you need to implement your own circular buffer if you need to use an
intermediate buffer.

The only question I still have is that if alsa allocates your DMA buffer for
you based on snd_pcm_hardware_t buffer_bytes_max what exactly does
snd_pcm_lib_preallocate_pages_for_all allocate buffers for?  Does this allocate
the buffers that would be passed to the copy callback?

Thanks,

Tim

--- Tim Harvey <tim_harvey@yahoo.com> wrote:

> Greetings,
> 
> I'm setting out to write an ALSA driver for a very limited device thats
> behind
> a PLD.  The actual codec is a uda1380 and does 16bit MSB stereo
> encode/decode. 
> The way the device is driven the sampling rate is limited to 8KHz and data
> transfer to/from the device I have to handle manually.
> 
> I've read over the 'writing an ALSA driver' tutorial and have started the
> driver but have run into a few questions:
> 
>  - for the specs I've given above: 8000Hz sampling rate, 16bit stereo MSB
> samples does the following snd_pcm_hardware_t look right?:
> 
> static snd_pcm_hardware_t my_playback_hw = {
>         .info = (SNDRV_PCM_INFO_MMAP |
>                  SNDRV_PCM_INFO_INTERLEAVED |
>                  SNDRV_PCM_INFO_BLOCK_TRANSFER |
>                  SNDRV_PCM_INFO_MMAP_VALID),
>         .formats =          SNDRV_PCM_FMTBIT_U16_BE,  // is this 16bit MSB?
>         .rates =            SNDRV_PCM_RATE_8000,      // seems redundant?
>         .rate_min =         8000,
>         .rate_max =         8000,
>         .channels_min =     2,
>         .channels_max =     2,
>         .buffer_bytes_max = 32768,
>         .period_bytes_min = 4096,
>         .period_bytes_max = 32768,
>         .periods_min =      1,
>         .periods_max =      1024,
> };
> 
>  - I'm a little confused at how to deal with copying data from/to the device.
> 
> It looks like I would implement the copy callback and copy the passed buffer
> to
> the device in the device specific manner I need to (playback), but I'm not
> clear where to put data that I receive from the device (capture).  I notice
> that when the hw_params callback is called a dma buffer has been created by
> ALSA in the substream->runtime struct.  I assume this is created based on hte
> buffer_bytes_max field above and I'm to copy data to this buffer?  How do I
> know where to copy it within the buffer and what data ALSA has already
> consumed
> from the buffer?
> 
>  - I might need to create an intermediate buffer between ALSA's rather large
> buffers and my hardware buffer.  Is there any driver that I could look at
> that
> does this?  The tutorial talks about the vxpocket driver but that code looks
> very foriegn from the rest of the ALSA drivers.
> 
>  - I'm not sure I understand what the 'period' is about.  Its clear to me
> that
> I need to call snd_pcm_period_elapsed() periodically from either an IRQ or
> other timed callback, but I'm not clear what the hardware pointer is or how
> that converts to 'frames' and 'periods'.
> 
>  - in general, if my hardware device only allows 16bit MSB 8KHz, does ALSA
> provides a mechanism for converting data from other formats?
> 
> Thanks for any pointers,
> 
> Tim
> 
