From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v4 2/5] ASoC: dwc: Switch to managed clock
	resource
Date: Wed, 24 Dec 2014 06:54:25 +0000
Message-ID: <549A6321.3000703@arm.com>
References: <cover.1419342218.git.Andrew.Jackson@arm.com>
 <9af8128918e2da97801f1122ae06336b1bd1012f.1419342218.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id D88BC2606D6
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 07:54:28 +0100 (CET)
In-Reply-To: <9af8128918e2da97801f1122ae06336b1bd1012f.1419342218.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <Pawel.Moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/23/14 13:56, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> Simplify error handling during probe by using managed clock
> resources.

In my haste to get to the Christmas turkey I missed a clk_put elsewhere.  Will fix and resubmit.

     Andrew

> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> ---
>  sound/soc/dwc/designware_i2s.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> index 9573ec7..b3dc535 100644
> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
> @@ -407,13 +407,13 @@ static int dw_i2s_probe(struct platform_device *pdev)
>  
>  	dev->capability = pdata->cap;
>  	dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return  PTR_ERR(dev->clk);
>  
>  	ret = clk_prepare_enable(dev->clk);
>  	if (ret < 0)
> -		goto err_clk_put;
> +		return ret;
>  
>  	dev_set_drvdata(&pdev->dev, dev);
>  	ret = snd_soc_register_component(&pdev->dev, &dw_i2s_component,
> @@ -427,8 +427,6 @@ static int dw_i2s_probe(struct platform_device *pdev)
>  
>  err_clk_disable:
>  	clk_disable(dev->clk);
> -err_clk_put:
> -	clk_put(dev->clk);
>  	return ret;
>  }
>  
> 
