From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: cs35l35: Allow user to configure IMON SCALE
Date: Wed, 19 Apr 2017 17:32:58 -0500
Message-ID: <20170419223258.qwliz3onwry2p4dl@rob-hp-laptop>
References: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492098729-30491-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 13, 2017 at 04:52:09PM +0100, Charles Keepax wrote:
> On the chip the IMON signal is a full 24-bits however normally only
> some of the bits will be sent over the bus. The chip provides a field
> to select which bits of the IMON will be sent back, this is the only
> feedback signal that has this feature.
> 
> Add an additional entry to the cirrus,imon device tree property to
> allow the IMON scale parameter to be passed.
> 
> Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
> 
> I realise this is changing the binding slightly, but thought
> we might be able to sneak it before cs35l35 ships as it hasn't
> shipped in a kernel yet.  However, it would be relatively simple
> (although makes the code a little messier) to support both the 3
> and 4 entry versions of the binding if people prefer?

Given it is new, I'm okay with the change if you are.

> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/sound/cs35l35.txt          |  4 ++--

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  include/sound/cs35l35.h                            |  1 +
>  sound/soc/codecs/cs35l35.c                         | 22 +++++++++++++++-------
>  sound/soc/codecs/cs35l35.h                         |  3 +++
>  4 files changed, 21 insertions(+), 9 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
