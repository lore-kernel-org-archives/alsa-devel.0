From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ASoC: Davinci: Replace use of IO_ADDRESS with ioremap()
Date: Thu, 16 Dec 2010 14:12:57 +0300
Message-ID: <4D09F439.9010404@mvista.com>
References: <1292491018-24491-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1292491018-24491-1-git-send-email-vaibhav.bedia-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vaibhav Bedia <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 16-12-2010 12:16, Vaibhav Bedia wrote:

> This patch modifies the Davinci i2s and mcasp drivers to use ioremap()
> instead of IO_ADDRESS

> Signed-off-by: Vaibhav Bedia<vaibhav.bedia-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
> index 9e0e565..5395fad 100644
> --- a/sound/soc/davinci/davinci-i2s.c
> +++ b/sound/soc/davinci/davinci-i2s.c
> @@ -694,7 +694,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
>   	}
>   	clk_enable(dev->clk);
>
> -	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
> +	dev->base = ioremap(mem->start, resource_size(mem));
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENOMEM;
> +		goto err_ioremap;

    Why iounmap() what you've just failed to ioremap()?

> @@ -724,10 +729,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
[...]
> +err_ioremap:
> +	iounmap(dev->base);
>   err_free_mem:

    Don't you forget to call clk_disable()/clk_put()?

>   	kfree(dev);
>   err_release_region:
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index fb55d2c..de61b41 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -885,7 +885,13 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>   	clk_enable(dev->clk);
>   	dev->clk_active = 1;
>
> -	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
> +	dev->base = ioremap(mem->start, resource_size(mem));
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENOMEM;
> +		goto err_ioremap;

    Why iounmap() what you've just failed to ioremap()?

> @@ -929,9 +935,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
[...]
> +err_ioremap:
> +	iounmap(dev->base);
>   err_release_region:

    Don't you forget to call clk_disable()/clk_put()?

>   	release_mem_region(mem->start, (mem->end - mem->start) + 1);
>   err_release_data:

WBR, Sergei
