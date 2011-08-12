From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regmap: Specify a module license
Date: Fri, 12 Aug 2011 10:43:34 +0900
Message-ID: <20110812014331.GA9928@opensource.wolfsonmicro.com>
References: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20464103969
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 03:43:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
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

On Thu, Aug 11, 2011 at 11:59:10AM -0600, Stephen Warren wrote:
> CONFIG_REGMAP_I2C/SPI are set to m when selected by a tristate config
> option that's set to m. The regmap modules don't specify a license, so
> fail to link to regmap_init at load time, since that is EXPORT_SYMBOL_GPL.
> Fix this by specifying a license for the regmap modules.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.

Please do remember to send your patches to the right lists (this should
have gone to lkml, it's nothing to do with ASoC - or the following patch
really).
