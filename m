From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: Samsung: neo1973_gta02: Fix
 bluetooth DAI registration
Date: Mon, 7 Feb 2011 11:59:06 +0000
Message-ID: <20110207115906.GD10564@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<1297033463-14577-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6249710381A
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 12:59:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297033463-14577-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 12:04:22AM +0100, Lars-Peter Clausen wrote:
> This patch fixes two issues with the bluethooth DAI registration:
> * The DAI has to be registered only after the sound device has been added.

This isn't a problem, components in the system can be registered in any
order.

> * Currently the DAI is registered with snd_soc_register_dai which causes it to
>   be named after the device it was registered for. Which is in this case the
>   "soc-audio" device. (Ab)use snd_soc_register_dais which causes the DAI to be
>   named after the DAI driver, which is what we want in this case.

This doesn't tie up with your change which...

> -	/* register bluetooth DAI here */
> -	ret = snd_soc_register_dai(&neo1973_gta02_snd_device->dev, &bt_dai);
> -	if (ret)
> -		goto err_put_device;

> +	/* register bluetooth DAI here */
> +	ret = snd_soc_register_dais(&neo1973_gta02_snd_device->dev, &bt_dai, 1);
>  	if (ret)
> -		goto err_unregister_dai;
> +		goto err_unregister_device;

...uses the same device in both cases and looking briefly at the code
both register functions just use the dev that was passed in.  In any
case, we clearly shouldn't be applying patches which bodge around the
core.
