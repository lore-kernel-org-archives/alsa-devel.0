From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RESEND] ASoC: rt5677: Convert to use
	rl6231_get_clk_info
Date: Thu, 12 Jun 2014 08:26:25 +0800
Message-ID: <CAFRkauCDgnGt1HpRQQDY59ASF8=oSYX+NdOgGan2iZEiwry6pg@mail.gmail.com>
References: <1402361856.4636.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E679D26571C
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 02:26:26 +0200 (CEST)
Received: by mail-qc0-f170.google.com with SMTP id l6so865126qcy.29
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 17:26:26 -0700 (PDT)
In-Reply-To: <1402361856.4636.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2014-06-10 8:57 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Tested-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>  sound/soc/codecs/Kconfig  |  2 ++
>  sound/soc/codecs/rt5677.c | 18 ++----------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index cbfa1e1..9d88845 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -445,9 +445,11 @@ config SND_SOC_RL6231
>         default y if SND_SOC_RT5640=y
>         default y if SND_SOC_RT5645=y
>         default y if SND_SOC_RT5651=y
> +       default y if SND_SOC_RT5677=y
>         default m if SND_SOC_RT5640=m
>         default m if SND_SOC_RT5645=m
>         default m if SND_SOC_RT5651=m
> +       default m if SND_SOC_RT5677=m

Hi Mark,
This patch ensures SND_SOC_RL6231 will be built.
This patch is required to fix build error with commit
"ASoC: rt5677: Convert to use rl6231_calc_dmic_clk".

Regards,
Axel
