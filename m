From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Wed, 20 Jan 2016 18:26:37 +0100
Message-ID: <20160120172637.GF18739@localhost>
References: <1453199388-8354-1-git-send-email-jacob@teenage.engineering>
 <1453199388-8354-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnCpJG_L6N9S5J0=QKiU8wxwXnrsKfni35-nr305SSM0g@mail.gmail.com>
 <20160119135103.GA12069@localhost>
 <CAOf5uwkSL91v4Trdp-QgarngHehY=Mj3Ur+Z21V7FEJ-mmqb1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwkSL91v4Trdp-QgarngHehY=Mj3Ur+Z21V7FEJ-mmqb1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Johan Hovold <johan@kernel.org>, Jacob Siverskog <jacob@teenage.engineering>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2016 at 05:58:26AM +0100, Michael Trimarchi wrote:
> Hi
> 
> On Tue, Jan 19, 2016 at 2:51 PM, Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Jan 19, 2016 at 11:50:35AM +0100, Michael Trimarchi wrote:
> >> Hi Jacob
> >>
> >> On Tue, Jan 19, 2016 at 11:29 AM, Jacob Siverskog
> >> <jacob@teenage.engineering> wrote:
> >> > The PCM179x family supports both SPI and I2C. This patch adds support
> >> > for the I2C interface.
> >> >
> >> > Reviewed-by: Johan Hovold <johan@kernel.org>
> >> > Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> >> > ---
> >
> >> > +static int pcm179x_i2c_probe(struct i2c_client *client,
> >> > +                             const struct i2c_device_id *id)
> >> > +{
> >> > +       struct pcm179x_private *pcm179x;
> >> > +       int ret;
> >> > +
> >> > +       pcm179x = devm_kzalloc(&client->dev, sizeof(struct pcm179x_private),
> >> > +                               GFP_KERNEL);
> >> > +       if (!pcm179x)
> >> > +               return -ENOMEM;
> >> > +
> >> > +       i2c_set_clientdata(client, pcm179x);
> >> > +
> >> > +       pcm179x->dev = &client->dev;
> >> > +
> >> > +       pcm179x->regmap = devm_regmap_init_i2c(client, &pcm179x_regmap_config);
> >> > +       if (IS_ERR(pcm179x->regmap)) {
> >> > +               ret = PTR_ERR(pcm179x->regmap);
> >> > +               dev_err(&client->dev, "Failed to register regmap: %d\n", ret);
> >> > +               return ret;
> >> > +       }
> >> > +
> >>
> >> sound/soc/codecs/adau1781-spi.c
> >>
> >> I like more how was done here for private data and codec data. What do
> >> you think?
> >
> > Why do you prefer that?
> >
> > Having a common_exit() to clean up whatever was done in common_init()
> > seems like a better design than open-coding this in both of the i2c and
> > spi drivers (if that's what you were referring to).
> >
> 
> private data can be allocated in common code and you can pass the
> regmap in the common init.
> As I can understand in that way more common code is shared between i2c
> and spi and make much
> more clean and easy. I had a look very quick but I think that this was
> the key point of that example

You're right, and this seems to be how the other codec drivers do this
(unlike mfd for example). Some have a shared remove function, while most
call snd_soc_unregister_codec from the driver's remove callback, which
was what I found a bit odd as registration was done by the common init
code.

Thanks,
Johan
