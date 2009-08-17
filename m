From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH 1/3] ARM: OMAP: DMA: Add support for DMA channel
 self linking on OMAP1510
Date: Mon, 17 Aug 2009 12:16:01 +0300
Message-ID: <20090817121601.2fdb0c0f.jhnikula@gmail.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <200908101050.02530.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Aug 2009 10:50:00 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Implement DMA channel self linking on OMAP1510 using AUTO_INIT and REPEAT
> flags of the DMA CCR register.
> 
> Created against linux-2.6.31-rc5.
> 
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
Tony, I'm fine with this patch. Although the autoinitialization !=
channel linking, in SW point of view autoinitialization and channel
linking with itself looks the same so it's better to re-utilize
existing omap_dma_link_lch also for 1510 DMA autoinitialization than
inventing own API for it.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
