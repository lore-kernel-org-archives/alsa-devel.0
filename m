From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/6] ASoC: rsnd: add generic rsnd_flags_xxx() macro
Date: Sat, 30 Sep 2017 13:07:54 +0300
Message-ID: <3459237c-bbf2-99b7-27d6-a922a2d1c5b5@cogentembedded.com>
References: <87tvzmgyqv.wl%kuninori.morimoto.gx@renesas.com>
 <87shf6gypt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shf6gypt.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On 9/29/2017 3:08 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> SSI is using rsnd_ssi_flags_xxx() macro to control flags.
> But it is useful macro not only for SSI. This patch replace it
> to more generic rsnd_flags_xxx().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> ---
>   sound/soc/sh/rcar/rsnd.h |  4 ++++
>   sound/soc/sh/rcar/ssi.c  | 27 ++++++++++++---------------
>   2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
> index c5de71f..558200f 100644
> --- a/sound/soc/sh/rcar/rsnd.h
> +++ b/sound/soc/sh/rcar/rsnd.h
> @@ -601,6 +601,10 @@ struct rsnd_priv {
>   #define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
>   #define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
>   
> +#define rsnd_flags_has(p, f) ((p)->flags & f)
> +#define rsnd_flags_set(p, f) ((p)->flags |= f)
> +#define rsnd_flags_del(p, f) ((p)->flags = ((p)->flags & ~f))

#define rsnd_flags_del(p, f) ((p)->flags &= ~f)

[...]

MBR, Sergei
