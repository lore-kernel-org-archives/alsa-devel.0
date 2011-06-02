From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc atmel_ssc: Don't try to free ssc if
	request failed
Date: Thu, 2 Jun 2011 19:05:41 +0100
Message-ID: <20110602180540.GA4227@opensource.wolfsonmicro.com>
References: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1CFA1037FC
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jun 2011 20:05:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 01, 2011 at 11:59:10PM +0200, Joachim Eastwood wrote:
> Hello,
> 
> Patch below fixes a segmentation fault in atmel_ssc_dai if ssc_request() fails.
> 
> We should only call ssc_free() when ssc_request() succeeds or bad
> things will happen.

Adding Liam for his review.  Please CC maintainers on patches.

> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 7fbfa05..eda955b 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -848,9 +848,10 @@ int atmel_ssc_set_audio(int ssc_id)
>  	if (IS_ERR(ssc))
>  		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
>  			PTR_ERR(ssc));
> -	else
> +	else {
>  		ssc_pdev->dev.parent = &(ssc->pdev->dev);
> -	ssc_free(ssc);
> +		ssc_free(ssc);
> +	}
> 
>  	ret = platform_device_add(ssc_pdev);
>  	if (ret < 0)
> -- 
> 1.7.5.2
