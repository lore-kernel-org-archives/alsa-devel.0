From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3] ASoC: da7210: Add support for PLL and
 SRM
Date: Thu, 9 Feb 2012 18:12:20 +0530
Message-ID: <1328791340.22077.3.camel@matrix>
References: <1328095529.15257.7.camel@matrix>
	<20120201115035.GC5648@opensource.wolfsonmicro.com>
	<1328621149.26721.18.camel@matrix>
	<20120207191943.GB15929@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 2280D103ED0
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 13:30:29 +0100 (CET)
In-Reply-To: <20120207191943.GB15929@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


> The most common case is things like bluetooth SCO connections where if
> there's a baseband you want to clock from the baseband but if there's no
> baseband (eg, for VoIP calls) you can't do that.  Some devices also need
> to change audio interface configuration depening on things like the
> number of channels.
> 
> Even without any dynamic reconfiguration you also have cases where the
> sequence people use to power things up is to set the clocking and then
> configure the audio interface format - even if the audio interface
> format is always the same you'll still get it being reconfigured the
> first time you start up.

I see.

BTW I am also planning to add SPI support to this driver. Just want to
know if it should be done via reg-map APIs? If yes, then do I need to
convert existing I2C stuff too to use reg-map?

TIA!
