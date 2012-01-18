From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: always enable
	dividers
Date: Wed, 18 Jan 2012 10:50:54 +0000
Message-ID: <20120118105054.GE8732@opensource.wolfsonmicro.com>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A01B103AA5
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:50:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 11:48:58AM +0100, Wolfram Sang wrote:

> +		/* Switch on PLL */
> +		snd_soc_update_bits(codec, AIC32X4_PLLPR,
> +				    AIC32X4_PLLEN, AIC32X4_PLLEN);

Looking at this code it looks a lot like these ought to be supplies, not
that that needs to be fixed right now.
