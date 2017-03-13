From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 13 Mar 2017 08:41:41 +0000
Message-ID: <CAAd53p5LgLDfRbhHvwzN6KKhsqW+yHU-bKnyXKdciCXsu0Vq2Q@mail.gmail.com>
References: <20170123053514.6193-1-kai.heng.feng@canonical.com>
 <20170216192230.mg6htsgqbu756e6y@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
 [209.85.161.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A07265823
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 09:41:52 +0100 (CET)
Received: by mail-yw0-f171.google.com with SMTP id v76so54665074ywg.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 01:41:52 -0700 (PDT)
In-Reply-To: <20170216192230.mg6htsgqbu756e6y@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 17, 2017 at 3:22 AM Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jan 23, 2017 at 01:35:14PM +0800, Kai-Heng Feng wrote:
>
> > +static void dell_dino_mute_hpo(struct snd_soc_codec *codec)
> > +{
> > +     snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> > +}
> > +
>
> How does this ever get unmuted, should it be an _AUTODISABLE control
> instead?
>

I think the AMP is overrode by another value when playing sound, but I am
not sure.

Can there be multiple callbacks hooked to the same widget?
In this case, in addition to hpol_enable_control(), can I register another
callback to "HPO L"?


>
> > @@ -1204,6 +1261,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
> >       mdelay(10);
> >
> >       regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
> > +
> >       /* Power down LDO, VREF */
> >       regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0xc, 0x0);
> >       regmap_update_bits(rt286->regmap, RT286_POWER_CTRL1, 0x1001,
> 0x1001);
>
> Random whitespace change.
>
> > @@ -1222,6 +1280,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
> >                       RT286_SET_GPIO_DATA, 0x40, 0x40);
> >               regmap_update_bits(rt286->regmap,
> >                       RT286_GPIO_CTRL, 0xc, 0x8);
> > +             rt286->mute_hpo_func = dell_dino_mute_hpo;
> >       }
>
> Why would we only do this on some machines, does this break others?
>

Because there's already an existing dmi quirk "dmi_dell_dino", I think I
should just follow.
I don't know if this may break other machines or not, I only have XPS 9343
to test.


>
> This change does appear to be two different changes merged into one,
> there's the GPIO setup and this automute thing and they don't seem to
> overlap AFAICT - they should be split into separate patches unless
> there's some reason why they overlap but I'm not seeing that.
>

Understood. I'll split them in later version.
