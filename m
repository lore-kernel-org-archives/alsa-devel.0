From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: getting dynamic state from ac97 bus ops
Date: Mon, 28 Mar 2011 11:33:15 +0100
Message-ID: <20110328103314.GD4781@opensource.wolfsonmicro.com>
References: <AANLkTinwMBTRkNyPWx+0=9ZY3+iWvadAevPe9J6BvNv2@mail.gmail.com>
	<20110328100610.GA23381@sirena.org.uk>
	<AANLkTinFhaKBjwgbMr8BH5JhCzX-apBRZiHdveNg1+q9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADB1D10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 12:33:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinFhaKBjwgbMr8BH5JhCzX-apBRZiHdveNg1+q9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 28, 2011 at 06:20:23AM -0400, Mike Frysinger wrote:

> this is state specific to the ac97 bus connection (snd_ac97_bus_ops),
> not the specific machine driver which links the codec to the
> transport, and currently all of these guys do it globally.  which
> means only 1 AC97 codec can be in play in the system.

These drivers all predate multi-component and in many cases they only
physically support a single device.

> the Blackfin has multiple SPORTs and could do one AC97 codec per
> SPORT.  but atm, there is only one global soc_ac97_ops structure, and
> i cant see how the functions in that structure could get at the
> link-specific state so that the bus driver would work with multiple
> AC97 codecs.

> granted, no customer that i know of has asked for this (more than AC97
> codec), it's just a limitation i noticed when working on an AC97
> driver, and i figured i might as well do it right while i'm cleaning
> so atm i have:

I wouldn't worry about it unless someone actually comes up with a
multi-CODEC embedded AC'97 system.  New designs tend to be I2S based
rather than AC'97 based as the PC market moved away from AC'97 so
there's less benefit to designing with it - it's likely that any effort
spent here wouldn't actually benefit anyone.
