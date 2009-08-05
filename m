From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
	selection
Date: Wed, 5 Aug 2009 10:39:00 +0300
Message-ID: <20090805103900.5ad89efe.jhnikula__3725.26290962032$1249457888$gmane$org@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Jul 2009 15:49:34 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> It adds a new sysfs file, where the user can configure the mcbsp mode to use.
> If the mcbsp channel is in use, it does not allow the change.
> Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
> store it, than use it to implement the different modes.
> 
...
> +/********************** McBSP DMA operating modes **************************/
> +#define MCBSP_DMA_MODE_ELEMENT		0
> +#define MCBSP_DMA_MODE_THRESHOLD	1
> +#define MCBSP_DMA_MODE_FRAME		2
...
> +static ssize_t dma_op_mode_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> +	int dma_op_mode;
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	dma_op_mode = mcbsp->dma_op_mode;
> +	spin_unlock_irq(&mcbsp->lock);
> +
> +	return sprintf(buf, "%d\n", dma_op_mode);

It would be good to handle this as an ascii like e.g /sys/power/state
does. "element", "threshold" or "frame". A number value doesn't tell
much (for me when testing).

> @@ -1195,12 +1266,14 @@ static int __devinit omap_mcbsp_probe
(struct platform_device *pdev)
>  	if (cpu_is_omap34xx()) {
>  		mcbsp->max_tx_thres = max_thres(mcbsp);
>  		mcbsp->max_rx_thres = max_thres(mcbsp);
> +		mcbsp->dma_op_mode = MCBSP_DMA_MODE_THRESHOLD;
>  		if (omap_additional_add(pdev))
>  			dev_warn(&pdev->dev,
>  				"Unable to create threshold controls\n");
>  	} else {
>  		mcbsp->max_tx_thres = -EINVAL;
>  		mcbsp->max_rx_thres = -EINVAL;
> +		mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
>  	}

I would say the default mode for the omap34xx should be also element as
it keeps the omap_pcm_pointer behavior the same than currently and
avoids possible regression.


-- 
Jarkko
