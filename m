From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 10/11] ASoC: qcom: apq8096: remove
 redundant owner assignment
Date: Mon, 25 Jun 2018 20:03:42 +0200
Message-ID: <20180625180342.GH10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 310B22673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:03:45 +0200 (CEST)
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so6758886ljj.10
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:03:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180625143115.8346-11-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Mon, Jun 25, 2018 at 03:31:14PM +0100, Srinivas Kandagatla wrote:
> module owner is already set in platform_driver_register(), so remove this
> redundant assignment.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/apq8096.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
> index 561cd429e6f2..6e79fec7e789 100644
> --- a/sound/soc/qcom/apq8096.c
> +++ b/sound/soc/qcom/apq8096.c
> @@ -245,7 +245,6 @@ static struct platform_driver msm_snd_apq8096_driver = {
>  	.remove = apq8096_platform_remove,
>  	.driver = {
>  		.name = "msm-snd-apq8096",
> -		.owner = THIS_MODULE,
>  		.of_match_table = msm_snd_apq8096_dt_match,
>  	},
>  };
> -- 
> 2.16.2
> 
