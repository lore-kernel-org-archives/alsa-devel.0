From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] ASoC: Blackfin: I2S CPU DAI driver
Date: Thu, 4 Sep 2008 15:43:43 +0100
Message-ID: <20080904144343.GB32531@rakim.wolfsonmicro.main>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-8-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF95424350
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 16:43:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220516528-20301-8-git-send-email-cooloney@kernel.org>
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

On Thu, Sep 04, 2008 at 04:22:06PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Please fix the minor issues below as incremental patches for ease of
review.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		ret = -EINVAL;
> +		break;
> +	}

The SND_SOC_DAFIMT_LEFT_J: ought to be default: instead - there's more
DAI formats than just that.

> +	if (!bf5xx_i2s.master) {
> +	/*
> +	 * TX and RX are not independent,they are enabled at the same time,
> +	 * even if only one side is running.So,we need to configure both of
> +	 * them in advance.
> +	 *
> +	 * CPU DAI format:I2S, slave mode.
> +	 */

The indentation here is odd.  Also, is the expecation that this
configuration be done only once ever - nothing seems to clear the flag?
