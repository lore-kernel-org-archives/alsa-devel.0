From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Thu, 5 May 2011 09:22:53 +0100
Message-ID: <20110505082253.GF11744@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51E7D10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:23:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:21:51AM -0500, Ricardo Neri wrote:

> +static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{

> +	if (ovl->manager->device->state != OMAP_DSS_DISPLAY_ACTIVE) {
> +		pr_err("HDMI display is not active!\n");
> +		return -EIO;
> +	}

dev_er().  Also, why are you checking this, and are you checking it too
early?

> +MODULE_AUTHOR("Jorge Candelaria <jorge.candelaria@gmail.com>");
> +MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
> +MODULE_DESCRIPTION("OMAP HDMI SoC Interface");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS().
