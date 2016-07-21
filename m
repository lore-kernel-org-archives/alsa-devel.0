From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] ASoC: samsung: Specify DMA channels through struct snd_dmaengine_pcm_config
Date: Thu, 21 Jul 2016 20:32:15 +0200
Message-ID: <CAJKOXPdM4nHO_-uT3SWq8dLSJFZGRD730qj=4aPGygjUPkA84Q@mail.gmail.com>
References: <1469124230-8583-1-git-send-email-s.nawrocki@samsung.com> <1469124230-8583-3-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1469124230-8583-3-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2016 at 8:03 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The DMA channel names are specified through struct snd_dmaengine_pcm_config
> rather than using SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag when
> booting with devicetree in order to properly support deferred probing.
> Without this change the sound machine driver initialization can complete
> successfully with unavailable DMA resources.
>

Is this the fix for the issue I reported recently
(http://www.spinics.net/lists/linux-clk/msg10805.html)? It looks like
it, so a credit? :)

BR,
Krzysztof
