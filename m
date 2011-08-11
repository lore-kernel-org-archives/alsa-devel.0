From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sgtl5000: fix module device table
	type for sgtl5000_dt_ids
Date: Thu, 11 Aug 2011 15:49:58 +0100
Message-ID: <4E43EC16.8090903@ti.com>
References: <1313072356.9215.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8048624466
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 16:50:04 +0200 (CEST)
In-Reply-To: <1313072356.9215.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 11/08/11 15:19, Axel Lin wrote:
> The module device table for of_device_id should use "of" type.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/sgtl5000.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 666fae6..91130fb 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -1441,7 +1441,7 @@ static const struct of_device_id sgtl5000_dt_ids[] = {
>  	{ .compatible = "fsl,sgtl5000", },
>  	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(i2c, sgtl5000_dt_ids);
> +MODULE_DEVICE_TABLE(of, sgtl5000_dt_ids);
>  
>  static struct i2c_driver sgtl5000_i2c_driver = {
>  	.driver = {

Acked-by: Liam Girdwood <lrg@ti.com>
