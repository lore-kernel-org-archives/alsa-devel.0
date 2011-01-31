From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/7] ASoC: Tegra: Harmony: Support the
	internal speaker
Date: Mon, 31 Jan 2011 13:14:30 +0000
Message-ID: <20110131131430.GF5123@opensource.wolfsonmicro.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
	<1296250001-6348-3-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67D5D103888
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 14:14:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296250001-6348-3-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 02:26:37PM -0700, Stephen Warren wrote:

> +	gpio_set_value_cansleep(pdata->gpio_spkr_en,
> +				!!SND_SOC_DAPM_EVENT_ON(event));

GPIOs should accept C logical values - if you need the !! there's a bug
in the GPIO driver.
