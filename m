From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH 2/4] Add Wolfson Microelectronics WM8766
	codec ALSA driver
Date: Tue, 17 Apr 2012 18:35:32 +0200
Message-ID: <201204171835.38252.linux@rainbow-software.org>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<1334611118-10301-3-git-send-email-linux@rainbow-software.org>
	<20120417145929.GA22575@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AE42104359
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:36:00 +0200 (CEST)
In-Reply-To: <20120417145929.GA22575@sirena.org.uk>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 April 2012 16:59:29 Mark Brown wrote:
> On Mon, Apr 16, 2012 at 11:18:36PM +0200, Ondrej Zary wrote:
> > Needed by Philips PSC724 subdriver. The code does not contain any
> > card-specific bits so it can be used by any other ALSA driver.
> >
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>
> Please CC me (and ideally all of patches@opensource.wolfsonmicro.com)
> on any drivers for Wolfson devices.  It's not like we're secretive!
>
> > ---
> >  include/sound/wm8766.h   |  160 ++++++++++++++++++++
> >  sound/i2c/other/Makefile |    3 +-
> >  sound/i2c/other/wm8766.c |  374
> > ++++++++++++++++++++++++++++++++++++++++++++++
>
> No, this should be supported in ASoC - anything adding new code in
> sound/i2c is *deeply* suspicious.

I agree that sound/i2c is wrong. I worked on tea575x-tuner before which lives 
in this directory too - but it's neither an I2C device nor a sound chip...
There should probably be something like sound/codecs instead that could be 
used by any sound card drivers.

> > +struct snd_wm8766_ops {
> > +	void (*write)(struct snd_wm8766 *wm, u16 addr, u16 data);
> > +};
>
> You should in general use regmap rather than open coding register I/O
> for I2C devices.

regmap seems like an overkill here. It requires the i2c bus to be registered 
in the kernel i2c subsystem (which is not in the case of ice1712).

> > +void snd_wm8766_init(struct snd_wm8766 *wm);
> > +void snd_wm8766_set_if(struct snd_wm8766 *wm, u16 dac);
> > +void snd_wm8766_set_master_mode(struct snd_wm8766 *wm, u16 mode);
> > +void snd_wm8766_set_power(struct snd_wm8766 *wm, u16 power);
> > +void snd_wm8766_volume_restore(struct snd_wm8766 *wm);
> > +int snd_wm8766_build_controls(struct snd_wm8766 *wm);
>
> I've not yet looked at the rest of the code but this looks awfully like
> you've just invented a minimal version of the ASoC interfaces...

The _set functions are just simple register writes - the caller needs to know 
what to write there (only _set_if is used by psc724).

-- 
Ondrej Zary
