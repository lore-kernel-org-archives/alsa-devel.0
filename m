From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Mon, 18 Jan 2016 17:56:57 +0100
Message-ID: <20160118165657.GE3169@localhost>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 05:14:42PM +0100, Michael Trimarchi wrote:
> Hi
> 
> On Mon, Jan 18, 2016 at 4:57 PM, Jacob Siverskog
> <jacob@teenage.engineering> wrote:
> > The PCM179x family supports both SPI and I2C. This patch adds support
> > for the I2C interface.
> >
> > Reviewed-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> > ---

> > +const struct of_device_id pcm179x_of_match[] = {
> > +       { .compatible = "ti,pcm1792a", },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> > +
> 
> can match go in the common part?

For matching purposes it could, but that would prevent the OF-aliases
from being defined for the driver modules.

There are a couple of codec drivers that have taken this route, and it
works as long as they also define a legacy (e.g. i2c_device_id) table
that modalias autoloading can fall back to.

But having having the common module carry the OF-aliases does not seem
like the right thing to do (e.g. as the common module cannot drive
anything on its own) even if it avoids a copy of the OF id table.

> > +static const struct i2c_device_id pcm179x_i2c_ids[] = {
> > +       { "pcm179x", 0 },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pcm179x_i2c_ids);
> > +
> > +static struct i2c_driver pcm179x_i2c_driver = {
> > +       .driver = {
> > +               .name   = "pcm179x",
> > +               .of_match_table = of_match_ptr(pcm179x_of_match),
> > +       },
> > +       .id_table       = pcm179x_i2c_ids,
> > +       .probe          = pcm179x_i2c_probe,
> > +       .remove         = pcm179x_i2c_remove,
> > +};

> > +
> > +module_i2c_driver(pcm179x_i2c_driver);

Thanks,
Johan
