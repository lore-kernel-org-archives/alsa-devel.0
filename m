From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 5/5] drm: dw-hdmi-i2s: add .get_dai_id
 callback for ALSA SoC
Date: Fri, 26 May 2017 09:46:31 +0530
Message-ID: <55fd9644-2a71-866c-af51-260abb38c50a@codeaurora.org>
References: <87efvnosnb.wl%kuninori.morimoto.gx@renesas.com>
 <877f1fosji.wl%kuninori.morimoto.gx@renesas.com>
 <20170524173849.h7jkmkrwk47pn6kd@sirena.org.uk>
 <877f1525qq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F67D267428
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 06:16:38 +0200 (CEST)
In-Reply-To: <877f1525qq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Hi,

On 05/25/2017 05:04 AM, Kuninori Morimoto wrote:
>
> Hi Mark
> Cc: DRM maintainer
>
>>> ALSA SoC needs to know connected DAI ID for probing.
>>> It is not a big problem if device/driver was only for sound,
>>> but getting DAI ID will be difficult if device includes both
>>> Video/Sound, like HDMI.
>>
>> As far as I understand what's going on with the graph code this seems to
>> make sense to me.  How do we want to go about handling the patch?
>
> This is comment to me ? or DRM maintainer ?
>
> If to me, any case (pickup by Mark, or by DRM maintainer) is OK for me

I'll pick it up for drm-misc-next.

Thanks,
Archit

>
> Best regards
> ---
> Kuninori Morimoto
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
