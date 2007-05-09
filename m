From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC PATCH] ASoC AC97/I2S for SH7760
Date: Wed, 9 May 2007 09:52:55 +0900
Message-ID: <20070509005255.GB19043@linux-sh.org>
References: <20070508174027.GB28884@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070508174027.GB28884@roarinelk.homelinux.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 08, 2007 at 07:40:27PM +0200, Manuel Lauss wrote:
> diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
> new file mode 100644
> index 0000000..157268c
> --- /dev/null
> +++ b/sound/soc/sh/hac.c
[snip]
> + * dont forget to set IPSEL/OMSEL register bits (in your board code) to
> + * enable HAC output pins!
> + */
Yuck.. I suppose this is a good argument for a demux API..

> +struct hac_priv {
> +	unsigned long mmio;	/* HAC base address */
> +} hac_cpu_data[] = {
> +#if defined(CONFIG_CPU_SUBTYPE_SH7760)
> +	{
> +		.mmio	= 0xFE240000,
> +	},
> +	{
> +		.mmio	= 0xFE250000,
> +	},
> +#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
> +	{
> +		.mmio	= 0xFFE40000,
> +	},
> +#else
> +#error "Unsupported SuperH SoC"
> +#endif
> +};

Platform device resources, please.

> diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
> new file mode 100644
> index 0000000..79642e0
> --- /dev/null
> +#ifdef SSI_DEBUG
> +#define MSG(x...)	printk(KERN_INFO "sh4-i2s: " x)
> +#else
> +#define MSG(x...)	do {} while (0)
> +#endif
> +
pr_debug()?

> +struct ssi_priv {
> +	unsigned long mmio;
> +	unsigned long sysclk;
> +	int inuse;
> +} ssi_cpu_data[] = {
> +#if defined(CONFIG_CPU_SUBTYPE_SH7760)
> +	{
> +		.mmio	= 0xFE680000,
> +	},
> +	{
> +		.mmio	= 0xFE690000,
> +	},
> +#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
> +	{
> +		.mmio	= 0xFFE70000,
> +	},
> +#else
> +#error "Unsupported SuperH SoC"
> +#endif
> +};
> +
This can also go in to a platform device resource. You'll want the
private data there anyways in case you decide to do something more
interesting with the clock.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
