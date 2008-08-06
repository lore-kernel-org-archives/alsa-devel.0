From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add WM8580 CODEC driver
Date: Wed, 6 Aug 2008 14:35:48 +0100
Message-ID: <20080806133532.GC26169@sirena.org.uk>
References: <1218025106-1360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h63qeqnxa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 155592443D
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 15:35:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63qeqnxa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 06, 2008 at 03:21:37PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +	switch (reg) {
> > +	default:
> > +		return wm8580_read_reg_cache(codec, reg);
> > +	}

> Any addition in future?  Otherwise let's remove unneeded switch.

There are some non-cachable status registers for functions not yet
supported in the driver.

> > +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

> Could you rewrite the code to follow the recent i2c framework?
> Then you can reduce lots of codes.

This and every other I2C driver in ASoC :/ .  Since the system I'm using
to develop this driver doesn't have a current enough I2C subsystem
available at the moment to use the new framework it's not an ideal
candidate for first conversion.

Doing this conversion is on my todo list but getting at least enough of
v2 merged to allow dynamic codec driver registration should probably be
done first.
