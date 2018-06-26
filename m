From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 08/12] ASoC: qdsp6: q6asm-dai: support
 dt based module loading
Date: Tue, 26 Jun 2018 11:35:20 +0200
Message-ID: <20180626093520.GE25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-9-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D702675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:35:23 +0200 (CEST)
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so8260554ljj.10
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-9-srinivas.kandagatla@linaro.org>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:12AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 349c6a883c63..1196dc7483d2 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -611,9 +611,16 @@ static int q6asm_dai_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6asm_dai_device_id[] = {
> +	{ .compatible = "qcom,q6asm-dais" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6asm_dai_device_id);
> +
>  static struct platform_driver q6asm_dai_platform_driver = {
>  	.driver = {
>  		.name = "q6asm-dai",
> +		.of_match_table = of_match_ptr(q6asm_dai_device_id),
>  	},
>  	.probe = q6asm_dai_probe,
>  	.remove = q6asm_dai_dev_remove,
> -- 
> 2.16.2
> 
