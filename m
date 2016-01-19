From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Tue, 19 Jan 2016 15:11:44 +0100
Message-ID: <20160119141144.GB12069@localhost>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
 <20160118165657.GE3169@localhost>
 <20160119122524.GM6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119122524.GM6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 12:25:24PM +0000, Mark Brown wrote:
> On Mon, Jan 18, 2016 at 05:56:57PM +0100, Johan Hovold wrote:
> > On Mon, Jan 18, 2016 at 05:14:42PM +0100, Michael Trimarchi wrote:
> 
> > > > +       { .compatible = "ti,pcm1792a", },
> > > > +       { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> 
> > > can match go in the common part?
> 
> > For matching purposes it could, but that would prevent the OF-aliases
> > from being defined for the driver modules.
> 
> > There are a couple of codec drivers that have taken this route, and it
> > works as long as they also define a legacy (e.g. i2c_device_id) table
> > that modalias autoloading can fall back to.
> 
> > But having having the common module carry the OF-aliases does not seem
> > like the right thing to do (e.g. as the common module cannot drive
> > anything on its own) even if it avoids a copy of the OF id table.
> 
> This does seem like something that the modules code should be able to
> cope with - we have a reference from the driver struct to the table
> which you'd really expect it to be using.  We already have some issues
> there with userspace not handling multiple modaliases terribly well IIRC.

That reference is only used for matching, while the aliases are
generated from the MODULE_DEVICE_TABLE macro (and elf magic).

Even if this sometimes means duplicating an id-table (and i2c and spi OF
id tables aren't necessarily always identical either), it seems to me
that the MODULE_DEVICE_TABLE should go in the actual driver rather than
any module dependency.

Thanks,
Johan
