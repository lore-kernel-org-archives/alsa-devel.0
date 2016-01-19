From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Tue, 19 Jan 2016 14:51:03 +0100
Message-ID: <20160119135103.GA12069@localhost>
References: <1453199388-8354-1-git-send-email-jacob@teenage.engineering>
 <1453199388-8354-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnCpJG_L6N9S5J0=QKiU8wxwXnrsKfni35-nr305SSM0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnCpJG_L6N9S5J0=QKiU8wxwXnrsKfni35-nr305SSM0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 11:50:35AM +0100, Michael Trimarchi wrote:
> Hi Jacob
> 
> On Tue, Jan 19, 2016 at 11:29 AM, Jacob Siverskog
> <jacob@teenage.engineering> wrote:
> > The PCM179x family supports both SPI and I2C. This patch adds support
> > for the I2C interface.
> >
> > Reviewed-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> > ---

> > +static int pcm179x_i2c_probe(struct i2c_client *client,
> > +                             const struct i2c_device_id *id)
> > +{
> > +       struct pcm179x_private *pcm179x;
> > +       int ret;
> > +
> > +       pcm179x = devm_kzalloc(&client->dev, sizeof(struct pcm179x_private),
> > +                               GFP_KERNEL);
> > +       if (!pcm179x)
> > +               return -ENOMEM;
> > +
> > +       i2c_set_clientdata(client, pcm179x);
> > +
> > +       pcm179x->dev = &client->dev;
> > +
> > +       pcm179x->regmap = devm_regmap_init_i2c(client, &pcm179x_regmap_config);
> > +       if (IS_ERR(pcm179x->regmap)) {
> > +               ret = PTR_ERR(pcm179x->regmap);
> > +               dev_err(&client->dev, "Failed to register regmap: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> 
> sound/soc/codecs/adau1781-spi.c
> 
> I like more how was done here for private data and codec data. What do
> you think?

Why do you prefer that?

Having a common_exit() to clean up whatever was done in common_init()
seems like a better design than open-coding this in both of the i2c and
spi drivers (if that's what you were referring to).

> > +       return pcm179x_common_init(pcm179x);
> > +}
> > +
> > +static int pcm179x_i2c_remove(struct i2c_client *client)
> > +{
> > +       return pcm179x_common_exit(i2c_get_clientdata(client));
> > +}

Thanks,
Johan
