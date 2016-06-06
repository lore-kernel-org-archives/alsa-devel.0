From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Mon, 6 Jun 2016 09:24:20 +0800
Message-ID: <CAN8cciab89x5ZQaBkSAGxEOzQ7FB3ORJAcd47Gu6EjSVDmk2cA@mail.gmail.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f50.google.com (mail-lf0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B56AF26573D
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 03:24:21 +0200 (CEST)
Received: by mail-lf0-f50.google.com with SMTP id b73so85161506lfb.3
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 18:24:21 -0700 (PDT)
In-Reply-To: <5753FFF0.3050200@gmail.com>
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

2016-06-05 18:33 GMT+08:00 Alan Young <consult.awy@gmail.com>:

> On 05/06/16 02:14, Raymond Yau wrote:
>
> the point only increment in DMA brust size , so it is not sample accurate
>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/linux/dmaengine.h
>
> * @DMA_RESIDUE_GRANULARITY_BURST: Residue is updated after each transferred
>
>  *  burst. This is typically only supported if the hardware has a progress *  register of some sort (E.g. a register with the current read/write address *  or a register with the amount of bursts/beats/bytes that have been *  transferred or still need to be transferred).
>
>  if the driver point callback does not read from hardware register , it should use
>
>  DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support. The *  DMA channel is only able to tell whether a descriptor has been completed or *  not, which means residue reporting is not supported by this channel. The *  residue field of the dma_tx_state field will always be 0.
>
>
>
> Yes, I understand that. And that is exactly my point. Because of this a
> pcm_status() result is only accurate to a granularity of period in most
> cases.
>
> In fact, some drivers, for example imx sdma, declare
> DMA_RESIDUE_GRANULARITY_BURST accuracy because sometimes they may have such
> an accuracy but in practice, at least for audio, they only actually achieve
> period accuracy.
>
> Regardless of what value of DMA_RESIDUE_GRANULARITY_xxx that a driver
> claims to support, it is not really defined how fine a burst might be. So
> the end result is, from the point of view of audio, that the resulting
> position obtained by the pointer() call is pretty inaccurate. Hence my
> proposal to attempt to improve the accuracy of the pcm_status() result
> given the above constraints.
>


http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=cf40ea169aad366b222283f431addafea6327149;hp=4bdb09126a32feb4394eaeb1d400d87e7c968770

HDA has hardware specific feature (audio wallclock) for the timestamp and
period wakeup can be disabled


only a few pci drivers which read the residue value from hardware register
(e.g. hda-intel, oxygen , .) you have to measure the granularity since the
unit may be different for usb, pcie and firewire sound card


as the application is based on the pointer for read/write, you still need
to use small period size and CPU power if you want to determine the value
returned by snd_pcm_rewindable is safe or not


>
>
