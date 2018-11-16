From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/5] ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
Date: Fri, 16 Nov 2018 09:18:34 +0200
Message-ID: <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org> <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Brown <broonie@kernel.org>, vkoul@kernel.org, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, rohitkr@codeaurora.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Srinivas,

One minor comment:

<snip>

>         struct snd_compr_ops *ops;
> +       struct snd_dma_buffer *dma_buffer_p;

I don't think it is necessary to encode the type inside the name variable
So, dma_buffer would sounds better to me then dma_buffer_p;

>         void *buffer;

It is also consistent with this ^

<snip>
> +static inline void snd_compr_set_runtime_buffer(
> +                                       struct snd_compr_stream *substream,
> +                                       struct snd_dma_buffer *bufp)

Also buf instead of bufp here.

thanks,
Daniel.
