From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: atmel_ssc_dai, duplex audio support?
Date: Wed, 3 Aug 2016 17:11:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1608031701110.12443@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Christoph Huber <c.huber@bct-electronic.com>
List-Id: alsa-devel@alsa-project.org

Hello,

it appears that atmel_ssc_dai does not support duplex audio, i.e. when
first starting a playback stream and then starting a record stream, the 
playback stops

problem seems to be in atmel_ssc_startup():

/* Reset the SSC to keep it at a clean status */
ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));

which is performed unconditionally when a stream starts

code was introduced with 
ASoC: atmel_ssc_dai: refactor the startup and shutdown, commit cbaadf0f90d6

tested with the 4.1 branch of linux-at91 git

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
