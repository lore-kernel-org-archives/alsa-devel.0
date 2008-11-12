From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [topic/asoc][PATCH] ASoC: OMAP: Add more supported
	sample	rates into McBSP DAI driver
Date: Wed, 12 Nov 2008 08:41:42 -0800
Message-ID: <1226508102.3914.59.camel@tera.sakoman.net>
References: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
Reply-To: steve@sakoman.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx11.roch.ny.frontiernet.net (mx11.roch.ny.frontiernet.net
	[66.133.183.238])
	by alsa0.perex.cz (Postfix) with ESMTP id EAE80244B3
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 17:41:43 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-11-12 at 17:05 +0200, Jarkko Nikula wrote:
> Originally it was put too tight limits to support only 44.1 kHz and 48 kHz
> sample rates in McBSP DAI driver. Extend it now to 8 kHz - 96 kHz. With
> 96 kHz and 2*16 bits, bit clock is 3.072 MHz < 3.125 MHz (I2S max?).
> 
> Tested on Nokia N810 with TVL320AIC33 from rates 8 - 96 kHz and on Texas
> Instruments Beagle with TWL4030 from rates 8 - 48 kHz.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Steve Sakoman <steve@sakoman.com>

Acked-by: Steve Sakoman <steve@sakoman.com>
