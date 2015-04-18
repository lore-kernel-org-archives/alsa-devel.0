From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Sat, 18 Apr 2015 09:16:36 -0700
Message-ID: <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org> <20150418113632.GE26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418113632.GE26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 18, 2015 at 4:36 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Apr 15, 2015 at 02:42:20PM -0700, Kevin Cernekee wrote:
>> +static int tas571x_set_sysclk(struct snd_soc_dai *dai,
>> +                           int clk_id, unsigned int freq, int dir)
>> +{
>> +     /*
>> +      * TAS5717 datasheet pg 21: "The DAP can autodetect and set the
>> +      * internal clock-control logic to the appropriate settings for all
>> +      * supported clock rates as defined in the clock control register."
>> +      */
>> +     return 0;
>> +}
>
> Remove empty functions, at best they waste space at worst they break
> things.

Without the empty function, we run into problems with drivers that
abort when they get -ENOTSUPP here:

sound/soc/atmel/atmel_wm8904.c: ret =
snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
sound/soc/atmel/atmel_wm8904.c-                 0, SND_SOC_CLOCK_IN);
sound/soc/atmel/atmel_wm8904.c- if (ret < 0) {
sound/soc/atmel/atmel_wm8904.c-         pr_err("%s -failed to set
wm8904 SYSCLK\n", __func__);
sound/soc/atmel/atmel_wm8904.c-         return ret;
sound/soc/atmel/atmel_wm8904.c- }

Is there a stub version that I can use instead?  Nothing jumped out at
me when looking at the other codec drivers.

>> +static int tas571x_set_shutdown(struct tas571x_private *priv, bool is_shutdown)
>> +{
>> +     return regmap_update_bits(priv->regmap, TAS571X_SYS_CTRL_2_REG,
>> +             TAS571X_SYS_CTRL_2_SDN_MASK,
>> +             is_shutdown ? TAS571X_SYS_CTRL_2_SDN_MASK : 0);
>> +}
>
>> +             ret = tas571x_set_shutdown(priv, false);
>> +             if (ret)
>> +                     return ret;
>> +             break;
>> +     case SND_SOC_BIAS_STANDBY:
>> +             ret = tas571x_set_shutdown(priv, true);
>> +             if (ret)
>> +                     return ret;
>
> This looks like it'd be clearer just as direct register updates, I'm not
> sure a function to set a single bit is addinng much.

It might be useful if another tas571x variant put the bit somewhere
else, but that hasn't happened yet so I can nuke the helper function
for now.

>> +     case SND_SOC_BIAS_OFF:
>> +             /* Note that this kills I2C accesses. */
>> +             assert_pdn = 1;
>
> No, the GPIO set associated with it kills I2C access.  I'd also expect
> to see the regmap being marked cache only before we do this and a resync
> of the register map when we power back up (assuming that is actually a
> power down).

Hmm, not sure if this actually resets the registers back to power-on
defaults, but I'll check.

>> +             /*
>> +              * The master volume defaults to 0x3ff (mute), but we ignore
>> +              * (zero) the LSB because the hardware step size is 0.125 dB
>> +              * and TLV_DB_SCALE_ITEM has a resolution of 0.01 dB.
>> +              */
>> +             if (regmap_write(priv->regmap, TAS571X_MVOL_REG, 0x3fe))
>> +                     return -EIO;
>
> I don't understand this - is the LSB a mute bit or sommething?

The 10-bit master volume field on 5717/5719 works like:

0x3ff: MUTE (power-on default)
0x3fe: -103.750 dB
0x3fd: -103.625 dB
[lots more options, in 0.125 dB increments]
0x001: 23.875 dB
0x000: 24.000 dB

Since we only have a resolution of 0.01 dB, the driver forces the LSB
to 0 and uses 0.25 dB increments instead of 0.125 dB.  Mute is handled
through the dedicated per-channel soft mute register bits instead of
the 0x3ff volume setting.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
