From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Sun, 30 Aug 2015 20:54:33 +0200
Message-ID: <55E35169.3000703@bfs.de>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr> <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 30.08.2015 20:05, schrieb Julia Lawall:
> Apply PTR_ERR to the value that was recently assigned.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,y;
> @@
> 
> if (IS_ERR(x) || ...) {
>   ... when any
>       when != IS_ERR(...)
> (
>    PTR_ERR(x)
> |
> *  PTR_ERR(y)
> )
>   ... when any
> }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/soc/qcom/lpass-cpu.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 23f3d59..94beb99 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -438,7 +438,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>  		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
>  			dev_err(&pdev->dev,
>  				"%s() error getting mi2s-bit-clk: %ld\n",
> -				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
> +				__func__,
> +				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
>  			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
>  		}
>  	}
> 

just a note:
using a shorter name instead of drvdata->mi2s_bit_clk[dai_id] whould help to make the code
more readable (yes, the other code is alike). something like:

struct clk *tmp =  devm_clk_get(&pdev->dev,clk_name);

if (IS_ERR(tmp)) {
	dev_err(&pdev->dev,"%s() error getting mi2s-bit-clk: %ld\n",__func__, PTR_ERR(tmp));
        return PTR_ERR(tmp);
}
drvdata->mi2s_bit_clk[dai_id]=tmp;


just one minor:
the dev_warn() just before says: " error getting mi2s-osr-clk" may be it should be "warnig ..."
That will make it more easy to rep for real error in a log.

re,
 wh
