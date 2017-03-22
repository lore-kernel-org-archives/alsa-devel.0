From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ASoC: rcar: ssi: don't set SSICR.CKDV =
 000 with SSIWSR.CONT
Date: Wed, 22 Mar 2017 11:48:50 +0300
Message-ID: <4764a887-edbc-efa3-881b-3edfb1175d01@cogentembedded.com>
References: <87zigenerc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A47326696B
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 09:48:52 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id n11so30886173wma.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 01:48:52 -0700 (PDT)
In-Reply-To: <87zigenerc.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On 3/22/2017 7:02 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> R-Car Datasheet is indicating "SSICR.CKDV = 000 is invalid when
> SSIWSR.WS_MODE = 1 or SSIWSR.CONT = 1".
> Current driver will set CONT, thus, we shouldn't use CKDV = 000.
> This patch fixup it.
>
> Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> ---
>  sound/soc/sh/rcar/ssi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
> index 9594d44..d0602c1 100644
> --- a/sound/soc/sh/rcar/ssi.c
> +++ b/sound/soc/sh/rcar/ssi.c
> @@ -245,6 +245,15 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
>  	for (j = 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
>
>  		/*
> +		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
> +		 * with it is not allowed. (SSIWSR.WS_MODE with
> +		 * SSICR.CKDV = 000 is not allowed either).
> +		 * Skip it. See SSICR.CKDV
> +		 */
> +		if (j == 0)
> +			continue;

    Why not change the *for* statement itself to start with j = 1?

[...]

MBR, Sergei
