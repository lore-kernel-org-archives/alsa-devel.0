From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 11:54:02 -0500
Message-ID: <4E737F2A.9040804@freescale.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de> <4E736F9B.6080206@freescale.com>
	<20110916162630.GB23727@opensource.wolfsonmicro.com>
	<4E737A62.5080501@freescale.com>
	<20110916164753.GE23727@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id B64A2243C2
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:55:04 +0200 (CEST)
In-Reply-To: <20110916164753.GE23727@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > But how is the machine driver supposed to know what those sample rates
>> > are?  It would need to know how which dividers that codec uses.  That
>> > would mean that the machine driver has to be hard-codec with
>> > information on the internals of the codec.

> You'd have to look at the CODEC datasheet and figure out what it's
> capable of given the clocks you're able to give it.  Depending on the
> flexibility you've got and power you're willing to spend there may be no
> need to do anything as you may be able to generate any clocks the device
> may need (for example with devices that have FLLs).

Well, my point was that this introduces a lot of information that's specific to
the internals of the codec into the machine driver.  Today, the only thing the
machine driver needs to know is the name of the DAIs:

	mdata->dai[0].codec_dai_name = "wm8776-hifi-playback";
	mdata->dai[1].codec_dai_name = "wm8776-hifi-capture";

and it might even be possible to avoid this.

-- 
Timur Tabi
Linux kernel developer at Freescale
