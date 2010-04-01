From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: enable wm8753 in aspenite
Date: Thu, 1 Apr 2010 19:21:24 +0100
Message-ID: <20100401182124.GB26650@opensource.wolfsonmicro.com>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98F7B1038BD
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 20:21:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 31, 2010 at 08:48:58AM -0400, Haojian Zhuang wrote:

> +/* Seek the index of MCLK configuration table */
> +static int pxa168_seek_mclk_conf(int rate, int format, int channel)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
> +		if ((mclk_conf[i].rate == rate)
> +			&& (mclk_conf[i].format == format)
> +			&& (mclk_conf[i].channel == channel))
> +			return i;
> +	}
> +	return -EINVAL;
> +}

> +/* Get the MCLK frequency */
> +static int pxa168_get_mclk(int i)
> +{
> +	if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
> +		return -EINVAL;
> +	return mclk_conf[i].mclk;
> +}

This stuff probably shouldn't be in the machine driver since pretty much
all machine drivers are going to want exactly the same code - it should
be in the library code.  Probably best to have them take hw_params
rather than require the machine driver to decode the format, rate and
channel since that'll save a bit of per driver boiler plate if they
don't otherwise need that information.

As I said last time ideally machine drivers shouldn't have to see this
at all, of course.

Otherwise this series all looks basically OK.  Liam is travelling at the
minute so it'll probably be the weekend at the earliest (more likely
early next week) before he has a chance to look at it.
