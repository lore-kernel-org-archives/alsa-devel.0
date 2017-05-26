From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 5/5] drm: dw-hdmi-i2s: add .get_dai_id callback for ALSA
 SoC
Date: Fri, 26 May 2017 09:54:22 +0530
Message-ID: <d5e23d29-44e1-ea0f-af15-953f1e1f85d0@codeaurora.org>
References: <87efvnosnb.wl%kuninori.morimoto.gx@renesas.com>
 <877f1fosji.wl%kuninori.morimoto.gx@renesas.com>
 <20170524173849.h7jkmkrwk47pn6kd@sirena.org.uk>
 <877f1525qq.wl%kuninori.morimoto.gx@renesas.com>
 <55fd9644-2a71-866c-af51-260abb38c50a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <55fd9644-2a71-866c-af51-260abb38c50a@codeaurora.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org



On 05/26/2017 09:46 AM, Archit Taneja wrote:
> Hi,
>
> On 05/25/2017 05:04 AM, Kuninori Morimoto wrote:
>>
>> Hi Mark
>> Cc: DRM maintainer
>>
>>>> ALSA SoC needs to know connected DAI ID for probing.
>>>> It is not a big problem if device/driver was only for sound,
>>>> but getting DAI ID will be difficult if device includes both
>>>> Video/Sound, like HDMI.
>>>
>>> As far as I understand what's going on with the graph code this seems to
>>> make sense to me.  How do we want to go about handling the patch?
>>
>> This is comment to me ? or DRM maintainer ?
>>
>> If to me, any case (pickup by Mark, or by DRM maintainer) is OK for me
>
> I'll pick it up for drm-misc-next.

Ah, I just saw the dependence on the previous patches.

Mark,

Please feel free to pull this to the asoc tree. You can add my Ack:

Acked-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

>
> Thanks,
> Archit
>
>>
>> Best regards
>> ---
>> Kuninori Morimoto
>>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
