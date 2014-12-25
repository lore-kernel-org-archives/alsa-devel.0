From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ALSA: pcm_dmaengine: correct the error
 handler of dmaengine_prep_dma_cyclic
Date: Thu, 25 Dec 2014 17:53:27 +0800
Message-ID: <CAGsJ_4wCz6rTdwea5gJ9051SgGHfASRR_M_ooemoRBThCG9=FQ@mail.gmail.com>
References: <1419482475-4911-1-git-send-email-21cnbao@gmail.com>
 <549BD2A9.505@metafoo.de>
 <CAGsJ_4x_mooOe4Uz6MRDtdKNCJ8RLL7jdvTr7HDbzabov_sLBA@mail.gmail.com>
 <549BDCD0.1040001@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C965264F32
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 10:53:49 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id rd3so11569044pab.14
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 01:53:47 -0800 (PST)
In-Reply-To: <549BDCD0.1040001@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@linaro.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, peter.ujfalusi@ti.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-12-25 17:45 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 12/25/2014 10:08 AM, Barry Song wrote:
>>
>> 2014-12-25 17:02 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>>>
>>> On 12/25/2014 05:41 AM, Barry Song wrote:
>>>>
>>>>
>>>> From: Barry Song <Baohua.Song@csr.com>
>>>>
>>>> preparing cyclic DMA description can fail either due to DMA desc list
>>>> is full(-ENOMEM), or due to the coming DMA configuration is illegal or
>>>> not supported by the acting DMA hardware(other ERR codes).
>>>
>>>
>>>
>>> According to the API definition this returns either NULL or a valid
>>> descriptor, so the behavior in pcm_dmaengine is correct. Maybe your
>>> particular dmaengine driver as a incorrect implementation.
>>
>>
>> i think it is something wrong. an functions returns pointer should return
>> one of
>> (1) right pointer
>> (2) NULL
>> (3) a wrong pointer from error CODES
>>
>> if for 2&3, we both return NULL, it actually means we are taking
>> something wrong.
>>
>> this should be a generic rule as from clk and other subsystems. why
>> does DMA want to do something special?
>
>
> I think the dmaengine API simply predates the widespread use of ERR_PTR.
>
> And it probably makes sense to update it to use ERR_PTR to have more
> meaningful error codes. But this needs to be done in a way that makes sure
> that all providers and all consumers agree on the same semantics. E.g. first
> update all consumers to handle ERR_PTR or NULL, then update all providers to
> return a ERR_PTR instead of NULL, then update all consumers to just handle
> ERR_PTR.

i agree. API should be small but can't be smaller.
but for this case, this api has been too small and has not reported
enough information to users.
this lost information is preparing_dma can fill due to all kinds of
hardware or software reasons.
users should not be kept in the dark for these .

>
>
> - Lars

-barry
