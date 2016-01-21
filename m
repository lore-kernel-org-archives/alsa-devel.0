From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Thu, 21 Jan 2016 11:59:34 +0100
Message-ID: <20160121105934.GB31514@localhost>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
 <20160118165657.GE3169@localhost>
 <20160119122524.GM6588@sirena.org.uk>
 <20160119141144.GB12069@localhost>
 <20160119163208.GN6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119163208.GN6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 04:32:08PM +0000, Mark Brown wrote:
> On Tue, Jan 19, 2016 at 03:11:44PM +0100, Johan Hovold wrote:
> > On Tue, Jan 19, 2016 at 12:25:24PM +0000, Mark Brown wrote:
> 
> > > This does seem like something that the modules code should be able to
> > > cope with - we have a reference from the driver struct to the table
> > > which you'd really expect it to be using.  We already have some issues
> > > there with userspace not handling multiple modaliases terribly well IIRC.
> 
> > That reference is only used for matching, while the aliases are
> > generated from the MODULE_DEVICE_TABLE macro (and elf magic).
> 
> Sure, but there's no reason we can't change that.

Might take quite a bit of work to the modpost tools to achieve, though.

Johan
