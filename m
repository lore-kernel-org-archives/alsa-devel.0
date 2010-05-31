From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] i.MX ssi: MX31ads sound support should
 depend on MACH_MX31ADS
Date: Mon, 31 May 2010 11:12:01 +0100
Message-ID: <20100531101200.GA3489@rakim.wolfsonmicro.main>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
	<1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93965103821
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 12:12:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275295794-3168-2-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2010 at 10:49:53AM +0200, Sascha Hauer wrote:

>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
> -	depends on SND_IMX_SOC && EXPERIMENTAL
> +	depends on SND_IMX_SOC && MACH_MX31ADS && EXPERIMENTAL

This should depend on the 1133-EV1, not the core machine.  The module
has a dependency on the core machine already and is required to use the
drivers.
