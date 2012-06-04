From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: dapm: Use devm_clk_get()
Date: Mon, 04 Jun 2012 10:36:41 +0100
Message-ID: <1338802601.15595.0.camel@odin>
References: <1338794360-28558-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog138.obsmtp.com (na3sys009aog138.obsmtp.com
	[74.125.149.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E5D5103FCF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 11:36:46 +0200 (CEST)
Received: by wgbdt14 with SMTP id dt14so3269095wgb.2
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 02:36:43 -0700 (PDT)
In-Reply-To: <1338794360-28558-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-04 at 08:19 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 3bb7a6f..a66379a 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2902,7 +2902,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
>  		}
>  		break;
>  	case snd_soc_dapm_clock_supply:
> -		w->clk = clk_get(dapm->dev, w->name);
> +		w->clk = devm_clk_get(dapm->dev, w->name);
>  		if (IS_ERR(w->clk)) {
>  			ret = PTR_ERR(w->clk);
>  			dev_err(dapm->dev, "Failed to request %s: %d\n",

Both 

Acked-by: Liam Girdwood <lrg@ti.com>
