From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/9] ASoC: Blackfin: AC97 Blackfin CPU DAI
	driver
Date: Thu, 4 Sep 2008 13:49:34 +0100
Message-ID: <20080904124934.GC13735@rakim.wolfsonmicro.main>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-6-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB144243A5
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 14:49:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220516528-20301-6-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 04, 2008 at 04:22:04PM +0800, Bryan Wu wrote:

> +static void bf5xx_ac97_cold_reset(struct snd_ac97 *ac97)
> +{
> +#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
> +	pr_debug("%s enter\n", __func__);
> +
> +	/* It is specified for bf548-ezkit */
> +	gpio_set_value(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 0);
> +	/* Keep reset pin low for 1 ms */
> +	mdelay(1);
> +	gpio_set_value(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 1);
> +	/* Wait for bit clock recover */
> +	mdelay(1);
> +#endif
> +}

Sorry, I did mean to say: shouldn't this print a warning like the warm
reset does if it's not implemented?
