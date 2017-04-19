From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ASoC: ak4613: use snd_soc_update_bits() to avoid Reserve
 bit on I/O CTRL
Date: Wed, 19 Apr 2017 12:33:48 +0300
Message-ID: <2558d9fa-b719-ac87-7944-3a9fd858a5d7@cogentembedded.com>
References: <877f2hkzcp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <877f2hkzcp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello!

On 4/19/2017 3:40 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/ak4613.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
> index e819dd8..b2dfdde 100644
> --- a/sound/soc/codecs/ak4613.c
> +++ b/sound/soc/codecs/ak4613.c
> @@ -75,6 +75,12 @@
>  #define DFS_DOUBLE_SPEED	(1 << 2)
>  #define DFS_QUAD_SPEED		(2 << 2)
>
> +/* ICTRL */
> +#define ICTRL_MASK	(0x3)
> +
> +/* OCTRL */
> +#define OCTRL_MASK	(0x3F)

    Parens not needed here and above, these are not expressions.

WBR, Sergei
