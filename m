From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 1/5] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()
Date: Fri, 16 Nov 2018 09:21:42 +0000
Message-ID: <336ad4dd-6046-7386-4080-d3061d04d8c2@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
 <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
 <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AB7452678E4
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 10:21:44 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so20455143wmc.4
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 01:21:44 -0800 (PST)
In-Reply-To: <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, rohitkr@codeaurora.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for your comments!

On 16/11/18 07:18, Daniel Baluta wrote:
> One minor comment:
> 
> <snip>
> 
>>          struct snd_compr_ops *ops;
>> +       struct snd_dma_buffer *dma_buffer_p;
> I don't think it is necessary to encode the type inside the name variable
> So, dma_buffer would sounds better to me then dma_buffer_p;
> 
>>          void *buffer;
> It is also consistent with this ^
> 
> <snip>
>> +static inline void snd_compr_set_runtime_buffer(
>> +                                       struct snd_compr_stream *substream,
>> +                                       struct snd_dma_buffer *bufp)
> Also buf instead of bufp here.

TBH, I followed what ./include/sound/pcm.h does!

--srini
