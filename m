From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ALSA: pcm_dmaengine: correct the error
 handler of dmaengine_prep_dma_cyclic
Date: Thu, 25 Dec 2014 17:35:15 +0800
Message-ID: <CAGsJ_4xN+uW8JGTPf4qeHb0rdCTG1arbqE8dSMj=kgAcZZab1Q@mail.gmail.com>
References: <1419482475-4911-1-git-send-email-21cnbao@gmail.com>
 <549BD2A9.505@metafoo.de>
 <CAGsJ_4x_mooOe4Uz6MRDtdKNCJ8RLL7jdvTr7HDbzabov_sLBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 94BE0264F22
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 10:35:37 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id v10so11406285pde.12
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 01:35:36 -0800 (PST)
In-Reply-To: <CAGsJ_4x_mooOe4Uz6MRDtdKNCJ8RLL7jdvTr7HDbzabov_sLBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@linaro.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, peter.ujfalusi@ti.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-12-25 17:08 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> 2014-12-25 17:02 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 12/25/2014 05:41 AM, Barry Song wrote:
>>>
>>> From: Barry Song <Baohua.Song@csr.com>
>>>
>>> preparing cyclic DMA description can fail either due to DMA desc list
>>> is full(-ENOMEM), or due to the coming DMA configuration is illegal or
>>> not supported by the acting DMA hardware(other ERR codes).
>>
>>
>> According to the API definition this returns either NULL or a valid
>> descriptor, so the behavior in pcm_dmaengine is correct. Maybe your
>> particular dmaengine driver as a incorrect implementation.
>
> i think it is something wrong. an functions returns pointer should return one of
> (1) right pointer
> (2) NULL
> (3) a wrong pointer from error CODES
>
> if for 2&3, we both return NULL, it actually means we are taking
> something wrong.
>
> this should be a generic rule as from clk and other subsystems. why
> does DMA want to do something special?

+ Vinod, i need your input for this, we rejected an unsupported DMA
configuration by returning PTR_ERR, and we returned NULL if there is
no free desc.
this is clearly two different scenarios and reasons for failed
dma_prep_cyclic(). i think this should be visible to the API users.
this is a necessary information not a blackbox to the API users.

static struct dma_async_tx_descriptor *
sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
size_t buf_len, size_t period_len,
enum dma_transfer_direction direction, unsigned long flags)
{
struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
struct sirfsoc_dma_desc *sdesc = NULL;
unsigned long iflags;

/*
* we only support cycle transfer with 2 period
* If the X-length is set to 0, it would be the loop mode.
* The DMA address keeps increasing until reaching the end of a loop
* area whose size is defined by (DMA_WIDTH x (Y_LENGTH + 1)). Then
* the DMA address goes back to the beginning of this area.
* In loop mode, the DMA data region is divided into two parts, BUFA
* and BUFB. DMA controller generates interrupts twice in each loop:
* when the DMA address reaches the end of BUFA or the end of the
* BUFB
*/
if (buf_len !=  2 * period_len)
return ERR_PTR(-EINVAL);

/* Get free descriptor */
spin_lock_irqsave(&schan->lock, iflags);
if (!list_empty(&schan->free)) {
sdesc = list_first_entry(&schan->free, struct sirfsoc_dma_desc,
node);
list_del(&sdesc->node);
}
spin_unlock_irqrestore(&schan->lock, iflags);

if (!sdesc)
return NULL;

...

return &sdesc->desc;
}

do you think we need to refine the API definition or do we need to
change the driver?


-barry
