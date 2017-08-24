From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 20:16:11 +0300
Message-ID: <1503594971.25945.93.camel@linux.intel.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
         <1503498573.25945.69.camel@linux.intel.com>
         <20170823173912.GN17193@bill-the-cat> <20170824000525.GY17193@bill-the-cat>
         <s5hk21tjb02.wl-tiwai@suse.de> <s5hinhdjav6.wl-tiwai@suse.de>
         <20170824144152.GC17193@bill-the-cat> <s5h60ddj7l8.wl-tiwai@suse.de>
         <20170824155235.2nrqjiwlo3afk4ei@sirena.org.uk>
         <20170824155437.GF17193@bill-the-cat> <s5h1so1j6gz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1so1j6gz.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Tom Rini <trini@konsulko.com>
Cc: Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-08-24 at 18:06 +0200, Takashi Iwai wrote:
> On Thu, 24 Aug 2017 17:54:37 +0200,
> Tom Rini wrote:
> > 
> > On Thu, Aug 24, 2017 at 04:52:35PM +0100, Mark Brown wrote:
> > > On Thu, Aug 24, 2017 at 05:42:11PM +0200, Takashi Iwai wrote:
> > > 
> > > > OK, so the fix for 4.13 would be either to cherry-pick this
> > > > commit, or
> > > > just to re-add "RT5677CE:00" to i2c_id temporarily as a quick
> > > > band-aid
> > > > fix (and remove again in 4.14).
> > > > The former is cleaner, but it's bigger, while the latter is a
> > > > safer
> > > > oneliner at the late RC stage.
> > > > I leave the decision to Mark.
> > > 
> > > I'm happier with the oneline change TBH, like you say it's pretty
> > > late
> > > in the release cycle.  Can you just apply the patch directly and
> > > send it
> > > to Linus with my ack or should I put together a pull request?
> > 
> > FWIW, I'd be happy to give the change a quick spin and Tested-by it.
> 
> Well, it's your patch, after all :)
> Below is the patch I'm going to queue.
> 
> 
> Takashi
> 
> -- 8< --
> From: Tom Rini <trini@konsulko.com>
> Subject: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
> 
> Not all devices with ACPI and this combination of sound devices will
> have the required information provided via ACPI.  Reintroduce the I2C
> device ID to restore sound functionality on on the Chromebook 'Samus'
> model.
> 
> [ More background note:
>  the commit a36afb0ab648 ("ASoC: rt5677: Introduce proper table...")
>  moved the i2c ID probed via ACPI ("RT5677CE:00") to a proper
>  acpi_device_id table.  Although the action itself is correct per se,
>  the overseen issue is the reference id->driver_data at
>  rt5677_i2c_probe() for retrieving the corresponding chip model for
>  the given id.  Since id=NULL is passed for ACPI matching case, we get
>  an Oops now.
> 
>  We already have queued more fixes for 4.14 and they already address
>  the issue, but they are bigger changes that aren't preferable for the
>  late 4.13-rc stage.  So, this patch just papers over the bug as a
>  once-off quick fix for a particular ACPI matching.  -- tiwai ]
> 
> Fixes: a36afb0ab648 ("ASoC: rt5677: Introduce proper table for ACPI
> enumeration")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for this and sorry for bisectability issue. I didn't noticed it
before Takashi got my attention to the bug report.

I'm fine with this quick fix for v4.13 only.

> ---
>  sound/soc/codecs/rt5677.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 36e530a36c82..6f629278d982 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5021,6 +5021,7 @@ static const struct regmap_config rt5677_regmap
> = {
>  static const struct i2c_device_id rt5677_i2c_id[] = {
>  	{ "rt5677", RT5677 },
>  	{ "rt5676", RT5676 },
> +	{ "RT5677CE:00", RT5677 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
