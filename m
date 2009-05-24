From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200
	audio	DMA code
Date: Sun, 24 May 2009 12:26:49 +0100
Message-ID: <20090524112648.GE4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D366F24363
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 13:26:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090523231305.17919.12239.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 07:13:05PM -0400, Jon Smirl wrote:

This is all basically OK bearing in mind that I know nothing about the
hardware.  A couple of things, though:

> +/* ---------------------------------------------------------------------
> + * Sysfs attributes for debugging
> + */

These look like they may be better placed in debugfs?

> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_create);

> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_destroy);

> +static int __init mpc5200_soc_platform_init(void)
> +{
> +	/* Tell the ASoC OF helpers about it */
> +	return snd_soc_register_platform(&mpc5200_audio_dma_platform);
> +}
> +module_init(mpc5200_soc_platform_init);

> +static void __exit mpc5200_soc_platform_exit(void)
> +{
> +	snd_soc_unregister_platform(&mpc5200_audio_dma_platform);
> +}
> +module_exit(mpc5200_soc_platform_exit);

This all looks a bit odd - I'd expect to see the platform registering
with the core when it is probed rather than on module load.  Looking at
the code it appears that you're automatically instantiating the DMA
driver from the node for the DAI?  If that is the case then you ought
to be calling the platform registration functions from the dma_create()
and dma_destroy() functions instead.
