From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] ASoC: codecs: wm8753: Fix register
 cache incoherency
Date: Fri, 24 Dec 2010 15:50:41 +0000
Message-ID: <20101224155040.GB16614@opensource.wolfsonmicro.com>
References: <1293198484-1902-1-git-send-email-lars@metafoo.de>
	<1293198484-1902-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F156246EC
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 16:50:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293198484-1902-10-git-send-email-lars@metafoo.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 24, 2010 at 02:48:04PM +0100, Lars-Peter Clausen wrote:
> The multi-component patch(commit f0fba2ad1) introduced a generic register cache
> framework. But the wm8753 driver still uses its own register cache for its

So, the actual relevant thing that the multi component patch did was to
introduce a new way of initialising the cache and setting up the pointer
that soc-cache uses to reference it, with some of the drivers being
partially converted.  

Since most of the drivers were already using the soc-cache code they
mostly have some initialisation errors, others (like WM8753) weren't
using soc-cache at all and probably shouldn't have been flipped over.

>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -		voice |= 0x0002;
> +		voice = 0x0002;
>  		break;

This is more than a straight conversion of the driver - since changes
like this aren't simple substitutions they're much harder to review, if
you want to make changes such as this they should be split out into
separate patches.  There's quite a few other bits like this in the
patch, some of which make it pretty confusing.

> -	u16 voice, ioctl;
> +	u16 voice, ioctl = 0;

Please don't mix variable declarations of initialised and uninitialised
variables like this.

> -	wm8753_write(codec, WM8753_PCM, voice);
> -	wm8753_write(codec, WM8753_IOCTL, ioctl);
> +	snd_soc_write(codec, WM8753_PCM, voice);
> +	snd_soc_update_bits(codec, WM8753_IOCTL, 0x00a2, ioctl);

This bit is especially confusing, we've now got a mixture of both
writing the full register and use of update_bits.

> +	for (i = 1; i < ARRAY_SIZE(wm8753_reg); i++) {
> +		if (i == WM8753_RESET)
> +			continue;
> +

If you make the register reset function write the default value of the
reset register you can use the standard cache sync implementation.
