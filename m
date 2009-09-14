From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] use set_channel_map api to reorder
 channels for AD1938 and AD1836
Date: Mon, 14 Sep 2009 11:24:30 +0100
Message-ID: <20090914102429.GA1260@rakim.wolfsonmicro.main>
References: <1252908787-32078-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03CDB10380C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 12:24:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252908787-32078-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <Barry.Song@analog.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 14, 2009 at 02:13:07PM +0800, Barry Song wrote:

> +	unsigned int channel_map[8] = {0, 4, 1, 5, 2, 6, 3, 7};

As a coding style thing it would be better to use [] here and let the
arrray size be figured out by the compiler and also...

> +	/* set cpu DAI channel mapping */
> +	ret = snd_soc_dai_set_channel_map(cpu_dai, 8, channel_map,
> +			8, channel_map);

...use ARRAY_SIZE() here.

> +	if ((tx_num > MAX_TDM_SLOTS) || (rx_num > MAX_TDM_SLOTS))
> +		return -EINVAL;
> +
> +	for (i = 0; i < tx_num; i++)
> +		bf5xx_tdm.tx_map[i] = tx_slot[i];

It'd be good if the function also recorded the number of slots that were
mapped to provide some error checking in case someone tries to use more
channels than were mapped.

> +#define MAX_TDM_SLOTS 8

This define needs to be namespaced - it's visible outside the driver and
is very likely to collide with something a CODEC driver wants to set up.
