From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][PATCH] ASoC: OMAP: Add more supported
	sample rates into McBSP DAI driver
Date: Wed, 12 Nov 2008 15:20:52 +0000
Message-ID: <20081112152050.GG8767@sirena.org.uk>
References: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E6EE24493
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:20:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 05:05:51PM +0200, Jarkko Nikula wrote:
> Originally it was put too tight limits to support only 44.1 kHz and 48 kHz
> sample rates in McBSP DAI driver. Extend it now to 8 kHz - 96 kHz. With
> 96 kHz and 2*16 bits, bit clock is 3.072 MHz < 3.125 MHz (I2S max?).
> 
> Tested on Nokia N810 with TVL320AIC33 from rates 8 - 96 kHz and on Texas
> Instruments Beagle with TWL4030 from rates 8 - 48 kHz.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Steve Sakoman <steve@sakoman.com>
> Cc: Arun KS <arunks@mistralsolutions.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
