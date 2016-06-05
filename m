From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Sun, 5 Jun 2016 09:14:41 +0800
Message-ID: <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
References: <5752A005.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BA6261501
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 03:14:42 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id h68so10784012lfh.3
 for <alsa-devel@alsa-project.org>; Sat, 04 Jun 2016 18:14:42 -0700 (PDT)
In-Reply-To: <5752A005.2050309@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <consult.awy@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2016-06-04 17:31 GMT+08:00 Alan Young <consult.awy@gmail.com>:

> I am looking at ways to get more accurate status timestamp information for
> various SoC drivers. The data that is obtained by snd_pcm_status(). One
> route would be to implement the more accurate timestamp mechanisms that
> currently are only available for HDA and Skylake (which I think is the SoC
> version of HDA).
>
> Looking at the code however, I think that may be unnecessary, at least for
> my purposes. It may not actually be practical in many cases.
>
> A call to snd_pcm_status() result in snd_pcm_update_hw_ptr0() being
> called. This gets the current output position (pos) via
> substream->ops->pointer(substream) and then makes all the other
> calculations based on the result. In theory, the result of
> substream->ops->pointer() could be sample accurate but in practice it is
> very unlikely to be better than period accurate. In fact, if I read it
> right, it will just about always be accurate to the point of the last
> period interrupt. Even when a DMA driver claims support of
> DMA_RESIDUE_GRANULARITY_BURST, it is often the case that the actual
> granularity is a period.
>

the point only increment in DMA brust size , so it is not sample accurate

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/linux/dmaengine.h

* @DMA_RESIDUE_GRANULARITY_BURST: Residue is updated after each transferred

 *  burst. This is typically only supported if the hardware has a
progress *  register of some sort (E.g. a register with the current
read/write address *  or a register with the amount of
bursts/beats/bytes that have been *  transferred or still need to be
transferred).


if the driver point callback does not read from hardware register , it
should use


DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support.
The *  DMA channel is only able to tell whether a descriptor has been
completed or *  not, which means residue reporting is not supported by
this channel. The *  residue field of the dma_tx_state field will
always be 0.




>
> The consequence of all that is that, for most drivers, the accuracy of a
> status report is period time. The result values, tstamp & audio_tstamp, are
> calculated using the current time and the pos estimate from above.
>



>
>
>
>
