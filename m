From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: soc-io: Fix
 CONFIG_REGMAP_I2C/SPI guards to support regmap modules
Date: Fri, 12 Aug 2011 11:55:58 +0900
Message-ID: <20110812025556.GD10218@opensource.wolfsonmicro.com>
References: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
	<1313085551-26125-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29F48103967
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 04:56:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313085551-26125-2-git-send-email-swarren@nvidia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 11:59:11AM -0600, Stephen Warren wrote:
> When CONFIG_REGMAP_I2C/SPI are m, CONFIG_REGMAP_I2C_MODULE is set in the
> pre-processor instead of CONFIG_REGMAP_I2C. This removes SND_SOC_I2C as a
> valid option for snd_soc_codec_set_cache_io()'s control parameter, and
> causes any ASoC regmap-using codec built as a module to fail to initialize.

Applied, thanks.
