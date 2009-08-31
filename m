From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to support multiple audio codecs on
	a	single?board
Date: Mon, 31 Aug 2009 21:10:40 +0100
Message-ID: <20090831201040.GA4079@opensource.wolfsonmicro.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309F5A565@dbde02.ent.ti.com>
	<20090831131605.GA16998@sirena.org.uk>
	<2562dcd3427ea040da0cb1365c7f5184@colcan.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04845244B7
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 22:10:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2562dcd3427ea040da0cb1365c7f5184@colcan.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pedro I. Sanchez" <psanchez@colcan.ca>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 31, 2009 at 01:25:39PM -0400, Pedro I. Sanchez wrote:
> On Mon, 31 Aug 2009 14:16:06 +0100, Mark Brown

> > For now you'll need to write three machine drivers only one of which is
> > permitted to be loaded at once; once the core has this support added
> > you'll then be able to load all three at once and have the three appear
> > as separate sound cards.  If you'd like to contribute the core support
> > that'd be excellent :)

> What if the codecs are different? My board has a playback-only device
> (TAS5709) and a capture-only device (PCM1800). Would it be OK to implement
> a single machine driver with num_dai=2? Or would you suggest to implement
> two different sound cards?

It only depends on what's idiomatic for your system - if your system
makes most sense with them both as part of the same sound card then do
that, if it makes more sense with them split into two cards then that
would be better.  When ASoC supports this properly it should be happy
with either configuration.
