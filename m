From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
 attached to AC97 bus
Date: Tue, 21 Jul 2009 15:53:23 +0100
Message-ID: <20090721145323.GA8991@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<s5hhbx62iq5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E913A2414B
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 16:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhbx62iq5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2009 at 04:50:26PM +0200, Takashi Iwai wrote:
> Marek Vasut wrote:

> >  	int ret;
> > +	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;

> Use the get function.

There's no such function in mainline right now.  However, apropos of
something else I submitted a patch adding that to the driver core - it's
been merged for 2.6.32 but won't be available in ALSA until after the
next merge window.  The function is dev_get_platdata().

> Also, at the next time, add Russell or linux-arm to Cc so that he
> knows at least that a file in arch/arm will be changed.

Ideally split things into two separate patches.
