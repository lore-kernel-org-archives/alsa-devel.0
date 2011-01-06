From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 14:24:11 -0600
Message-ID: <4D2624EB.6060704@freescale.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id CFBAF2450D
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 21:24:33 +0100 (CET)
In-Reply-To: <20110106201511.GA8018@opensource.wolfsonmicro.com>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > +	u8 reg_cache[CS4270_NUMREGS];
>> > +	struct snd_soc_codec_driver codec_drv;
> Having a driver per device is pretty icky and off the top of my head I'd
> expect it to cause problems if there are two cs4270 in the system.  It
> would be much nicer and more maintainable to avoid bodging around the
> API like this.

The problem is that I need a distinct default register cache for each CS4270 in
the system, so I don't know how to reconcile the idea that there is supposed to
be only one snd_soc_codec_driver for all devices.

What do I do if there are two CS4270s in a system, and they each have different
power-on default values for the registers?  Granted, it's a contrived example,
but this could happen if the first CS4270 is a rev1 chip, and the second is a
rev2 chip.

And even if this example is contrived, it's conceivable that there can be codecs
where the power-on defaults are set by pin configuration.  Perhaps codec #1 is
muted by default and codec #2 isn't.

-- 
Timur Tabi
Linux kernel developer at Freescale
