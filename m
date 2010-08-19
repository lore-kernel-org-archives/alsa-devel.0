From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 17:06:54 +0100
Message-ID: <20100819160654.GC9307@sirena.org.uk>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
	<20100819143555.GB29453@opensource.wolfsonmicro.com>
	<AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
	<20100819144841.GC29453@opensource.wolfsonmicro.com>
	<AANLkTimbasVqtJLeg-F+M9Ry9AzLgy8EG213vy_rEbc=@mail.gmail.com>
	<20100819155244.GB9307@sirena.org.uk>
	<AANLkTikMknoV5GDOCw1_B8jwXy6S7zZ7OidcXAjS_FBf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 776D924499
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 18:06:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikMknoV5GDOCw1_B8jwXy6S7zZ7OidcXAjS_FBf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 05:59:24PM +0200, Manuel Lauss wrote:
> On Thu, Aug 19, 2010 at 5:52 PM, Mark Brown

> > This is the only embedded device I've ever seen where anyone wanted to
> > use multiple AC97 controllers so not directly. ?If you look at the SoC
> > core you can see how the various ALSA structures are converted into ASoC
> > specific ones, though.

> I figured out how to access platform data in dai_ops,  however I see absolutely
> no way to get at it from the ac97_ops.

The snd_card has private data...
