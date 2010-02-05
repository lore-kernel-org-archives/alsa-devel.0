From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
 support
Date: Fri, 5 Feb 2010 17:20:31 +0000
Message-ID: <20100205172031.GA31523@rakim.wolfsonmicro.main>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
	<1265378923.3177.11.camel@odin>
	<6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E414243AA
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 18:20:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 05, 2010 at 04:29:53PM +0200, Grazvydas Ignotas wrote:

> Uh, I meant "no audible improvement". However I've just checked the
> DAC datasheet again and it requires 1ms delay between turning on/off
> the supply and switching /PD pin (connected to
> OMAP3_PANDORA_DAC_POWER_GPIO). Even though I hear no difference,
> adding the delays back just in case. Updated patch attached.

Which step of the powerup is the one that generates the pop?  As Liam
says if you can mute the DAC while powering up might help if that's
possible, though looking I don't think it is.

> From 72cdf36e432a9929baff8841df979f13492dc813 Mon Sep 17 00:00:00 2001
> From: Grazvydas Ignotas <notasas@gmail.com>
> Date: Fri, 5 Feb 2010 12:57:37 +0200
> Subject: [PATCH -next] ASoC: pandora: Add DAC regulator support

Please don't append patches to messages like this, it makes them harder
to apply since the e-mail text ends up as part of the commit message as
does the patch header.

Applied, thanks.
