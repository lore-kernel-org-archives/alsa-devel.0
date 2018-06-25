From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 07/11] ASoC: qdsp6: q6afe-dai: support dt
 based module loading
Date: Mon, 25 Jun 2018 20:03:08 +0200
Message-ID: <20180625180308.GF10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A03F2673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:03:11 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id o26-v6so6763170ljg.3
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180625143115.8346-8-srinivas.kandagatla@linaro.org>
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

On Mon, Jun 25, 2018 at 03:31:11PM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6afe-dai.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index 5002dd05bf27..7fbf762a45ac 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -1290,9 +1290,17 @@ static int q6afe_dai_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6afe_dai_device_id[]  = {

Double space here.

> +	{ .compatible = "qcom,q6afe-dais" },
> +	{},
> +};
> +

Usually there is no empty line between the table and MODULE_DEVICE_TABLE.

> +MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
> +
>  static struct platform_driver q6afe_dai_platform_driver = {
>  	.driver = {
>  		.name = "q6afe-dai",
> +		.of_match_table = of_match_ptr(q6afe_dai_device_id),
>  	},
>  	.probe = q6afe_dai_dev_probe,
>  	.remove = q6afe_dai_dev_remove,
> -- 
> 2.16.2
> 

I'm not sure if Rob agrees with me or not,
but since this patch is less than 10 lines,
I think that it would be simpler to review
if it was squashed together with the patch
adding the compatible to the DT binding.
