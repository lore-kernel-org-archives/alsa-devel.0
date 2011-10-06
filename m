From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/10] ASoC: wm8510: Convert to
	snd_soc_cache_sync
Date: Thu, 6 Oct 2011 14:22:11 +0100
Message-ID: <20111006132211.GB16404@opensource.wolfsonmicro.com>
References: <1317881417.13399.1.camel@phoenix>
	<1317881503.13399.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC297103839
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 15:22:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317881503.13399.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 02:11:43PM +0800, Axel Lin wrote:

> +static int wm8510_volatile_register(struct snd_soc_codec *codec,
> +				    unsigned int reg)
> +{
> +	switch (reg) {
> +	case WM8510_RESET:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +

This is wrong in quite a few of the patches - all the 7, 9 CODECs are
write only, there's no readback support at all (in general if the driver
isn't actully verifying a device ID or otherwise doing a physical read
then it probably doesn't support readback).
