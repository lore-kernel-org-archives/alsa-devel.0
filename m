From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PCM buffering ussues ( or probably the lack of
 understanding )
Date: Sat, 20 Apr 2013 09:52:16 +0200
Message-ID: <51724930.3020406@metafoo.de>
References: <5172401E.8020708@quicknet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F87A2650DA
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 09:53:00 +0200 (CEST)
In-Reply-To: <5172401E.8020708@quicknet.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: marcelg <marcelsbox@quicknet.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/20/2013 09:13 AM, marcelg wrote:
> I am working on a PCM driver, have some issues and thing which are unclear
> to me, hopefully somebody here can clarify something for me.
> 
> My PCM driver is straigh forward:

It's always easier to comment on potential issues if you provide the code.


> 
> - Copy callback copies the frames received in the callback into a small
> ringbuffer and starts a DMA transfer to the hardware.

If you have DMA support your probably shouldn't implement the copy
callback, but rather let also write directly to your hardware buffer.

> - DMA interrupt each times take the next chunk from the ringbuffer.
> - In the DMA interrupt the number of frames is counted, if te number >=
> period_size reported in runtime_struct   pcm_period_elapsed() is called.
> - the pointer which is read by the pcm_pointer() callback is updated in each
> DMA interrupt.
> 
> When using mplayer this works without problems, however with other
> applications like mpg123 its causes a lot of problems, for some reaosns I do
> not understand yet.
> It has something to do with buffer handling.
> 
> 
> basically in the cm driver I can influence a few parameters:
> 
> periods_min/periods_max
> period_bytes_min, period_bytes_max
> buffer_size  ( should be sufficient to hold periods_max with
> period_bytes_max I assume )
> 
> As far as I understand periods_min/periods_max is the size (number of buffer
> entries) of the internal ringbuffer Alsa uses.

There is no ALSA internal ringbuffer. The only buffer is the buffer your
driver allocates.

> - Why is there both a min and a max ?  How is chosen what will be used ?

This expresses the hardware limitations. The minimum and maximum number of
periods per buffer supported by the hardware. When starting playback/capture
userspace may choose any number between min and max for the actual number of

> - Currently my period_min is set to 1 and my period_max  set to 4, If I
> increase the period_max value it does not start properly, it seems  that the
> samples are not deliverered in time.
>   Is there any explanation for this,   does the Alsa layer not any
> pre-buffering before the first copy() is called ?

Well that probably means there is a bug in your driver so that it does not
support more than 4 periods.

> - Is there any advice / guidline for period min/max values ?  I checked
> sourecs of severl drivers, some use 1 and some use values like 32 or more
> for period_max.
> 

Yes, set them according to the limitations of your hw.

> The same applies to buffer_bytes min/max, currently my min is set to
> 128bytes , max to 2kB, larger values of max seem to cause more problems.
> 

Same here.

> From the documentation I understand that it does not matter if
> pcm_period_elapsed()  is not always called,  How dows the ALSA layer then
> know how many samples are played.
> the pointer value read the pcm_pointer()  only counts from [0..period_max] 
> so what if 2 or more calls to period_elapsed()  are skipped ?

pcm_pointer goes from 0 to buffer_size. Since you usually have multiple
periods per buffer it is possible to recover from a situation where
pcm_period_elapsed() was skipped.

> 
> Suppose I want to have some buffering inside my pcm driver, how will I be
> able to get some samples in advance before starting playback ? Can I just
> call pcm_period_elapsed() a few times in  a row to get the buffer filled
> before starting the actual playcback, or does this cause side effects ?
> 

Why'd you want to do that?

- Lars
