From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 1/2] ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update
Date: Thu, 7 Dec 2017 21:35:16 -0800
Message-ID: <5A2A2494.2080202@mentor.com>
References: <1512634956-17760-1-git-send-email-jiada_wang@mentor.com> <1512634956-17760-2-git-send-email-jiada_wang@mentor.com> <87y3me7uce.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3me7uce.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san

On 12/07/2017 01:45 AM, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> Currently there is race condition between set of byte_pos and wrap
>> it around when new buffer starts. If .pointer is called in-between
>> it will result in inconsistent pointer position be returned
>> from .pointer callback.
>>
>> This patch increments buffer pointer atomically to avoid this issue.
>>
>> Signed-off-by: Jiada Wang<jiada_wang@mentor.com>
>> Reviewed-by: Takashi Sakamoto<takashi.sakamoto@miraclelinux.com>
>> ---
> You using playback with PIO mode ?
> Because this function is no longer used on DMA mode
No, we are using rcar sound in DMA mode,
our original patch resolves the issue in core.c for both PIO & DMA mode.

but with your commit a97a06c ("ASoC: rsnd: cleanup pointer related code"),
DMA mode no longer has the race condition issue,
so I ported our fix patch to only address the issue in PIO mode

Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
