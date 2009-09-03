From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: <alsa-dev> RFC for OMAP4 audio driver
Date: Thu, 3 Sep 2009 15:06:27 +0100
Message-ID: <20090903140627.GC1406@rakim.wolfsonmicro.main>
References: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
	<20090902120120.GB4012@sirena.org.uk>
	<67059DBF19D7214F9C66BB0EA91BA90E80FDEDAA@dlee04.ent.ti.com>
	<20090903091011.GA10313@rakim.wolfsonmicro.main>
	<6160a5130909030656j89cad98x1821f135d526621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5A7D24555
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 16:06:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6160a5130909030656j89cad98x1821f135d526621@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, hari n <hnagalla@gmail.com>, "Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 03, 2009 at 08:56:30AM -0500, pl bossart wrote:

> My 2 cents: I find the notion of codec confusing.
> In most products from Wolfson and others, you have a digital/mixing
> part, and a second one for digital/analog conversions. OMAP4 and
> others have a digital part on the application processor, but the
> partition is still the same, only implemented on two chips instead of
> one. It shouldn't really matter software-wise where the digital part
> is done, as long as you can express the connection between these two
> parts. A logical split would avoid having a description of a codec

In this case "codec" is just what ASoC (for historical reasons) calls
any block that isn't a DAI or DMA controller on the CPU.  It doesn't
actually need to be a CODEC.  There are many cases even the ADCs and
DACs are integrated with the CPU which means that package boundaries
aren't always that helpful either.
