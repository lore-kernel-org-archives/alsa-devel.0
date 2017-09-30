From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/6] ASoC: rsnd: DVC kctrl sets once
Date: Sat, 30 Sep 2017 13:02:09 +0300
Message-ID: <dcf8fa7d-a23e-6dbd-3234-73e1aea69363@cogentembedded.com>
References: <87tvzmgyqv.wl%kuninori.morimoto.gx@renesas.com>
 <87poaagynr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87poaagynr.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On 9/29/2017 3:09 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Same DVC might be used few times if system/platform is using MIX.
> For example below case.
> 
> 	DAI0 playback = <&src0 &ctu02 &mix0 &dvc0 &ssi0>;
> 	DAI1 playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;
> 
> This case, ALSA will have DVC,0 and DVC,1 kcontrol interfaces,
> but these are same DVC. This is confusable.

    Confusing.

> This patch adds new flags and avoid such case.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> ---
>   sound/soc/sh/rcar/dvc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
> index 1743ade..b4c4ff2 100644
> --- a/sound/soc/sh/rcar/dvc.c
> +++ b/sound/soc/sh/rcar/dvc.c
> @@ -44,8 +44,11 @@ struct rsnd_dvc {
>   	struct rsnd_kctrl_cfg_s ren;	/* Ramp Enable */
>   	struct rsnd_kctrl_cfg_s rup;	/* Ramp Rate Up */
>   	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
> +	u32 flags;
>   };
>   
> +#define KCTRL_INITIALIZEED	(1 << 0)

    One E is enough. :-)

[...]

MBR, Sergei
