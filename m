From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: Fix build errors in ams-delta
Date: Fri, 19 Aug 2011 01:20:56 +0900
Message-ID: <20110818162053.GD20208@opensource.wolfsonmicro.com>
References: <1313668967-5657-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B424224478
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 18:21:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313668967-5657-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2011 at 03:02:47PM +0300, Jarkko Nikula wrote:
> Fix "error: too few arguments to function 'ams_delta_set_bias_level'"
> build errors in ams-delta.c that were introduced after commit d4c6005 ("ASoC:
> Add context parameter to card DAPM callbacks") by adding dapm context
> to ams_delta_set_bias_level calls.

Applied, thanks.
