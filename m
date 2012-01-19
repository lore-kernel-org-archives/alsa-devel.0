From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Thu, 19 Jan 2012 17:51:47 +0000
Message-ID: <20120119175147.GJ3178@opensource.wolfsonmicro.com>
References: <1326989163-5187-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E49D32436C
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 18:51:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326989163-5187-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2012 at 05:06:03PM +0100, Peter Ujfalusi wrote:

> Let's try this way.
> I think this implementation is quete clear for the first look to understand what
> it is doing.

>  	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
> +		if (sample_sizes[i] > bits) {
> +			ret = snd_pcm_hw_constraint_msbits(substream->runtime,
> +						      0, sample_sizes[i], bits);
> +			if (ret != 0)
> +				dev_warn(dai->dev,
> +					 "Failed to set MSB %d/%d: %d\n",
> +					 bits, sample_sizes[i], ret);
> +		} else {
> +			/*
> +			 * The remaining sample sizes are smaller than the
> +			 * requested msbits, we can bail out from the loop.
> +			 */
> +			break;
> +		}

*sigh*  I think from the tone of the above you know that's not really
addressing the issue.

My yak is getting pretty bald now and I'm running out of razors.
