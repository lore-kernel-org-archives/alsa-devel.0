From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 15:26:00 +0300
Message-ID: <1503577560.25945.84.camel@linux.intel.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
         <1503498573.25945.69.camel@linux.intel.com>
         <20170823173912.GN17193@bill-the-cat> <20170824000525.GY17193@bill-the-cat>
         <1503560349.25945.72.camel@linux.intel.com>
         <20170824111547.GA17193@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824111547.GA17193@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-08-24 at 07:15 -0400, Tom Rini wrote:
> On Thu, Aug 24, 2017 at 10:39:09AM +0300, Andy Shevchenko wrote:
> > On Wed, 2017-08-23 at 20:05 -0400, Tom Rini wrote:
> > > On Wed, Aug 23, 2017 at 01:39:12PM -0400, Tom Rini wrote:
> > > > On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:
> > > > 
> > > > > Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide
> > > > > platform
> > > > > data
> > > > > in the module sources") does not fix your issue?
> > > > 
> > > > As that's not in master yet I can't tell.  Can you give me a
> > > > pointer
> > > > to
> > > > somewhere?
> > 
> > It's in ASoC next at least.
> > 
> > > >   Thanks!
> > > 
> > > OK, my bad, it has a different hash upstream, but no, that change
> > > doesn't fix things as I see the problem on top of Linus'
> > > tree.  Thanks!
> > 
> > Interesting...
> > 
> > The only bug so far I saw is the following one
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=196397
> > 
> > ...and above commit fixes it.
> > 
> > Can you place somewhere the bundle of the following:
> > 
> > 1. Output file (tables.dat) of
> > 	% acpidump -o tables.dat
> 
> https://gist.github.com/trini/b9a9a547e37cb812506a22e18cd2aff5
> 
> > 2. Output of
> > 	% cat /proc/interrupts
> 
> https://gist.github.com/trini/39a5d88a5ecb9b71336ff5fe9da7c720
> 
> > 3. Output of
> > 	% lspci -vv -xx
> 
> https://gist.github.com/trini/e81ab21909eeaa05ea50dc0596d23c14
> 
> > 4. Output of
> > 	% grep -H 15 /sys/bus/acpi/devices/*/status
> 
> https://gist.github.com/trini/698dc284634ad9e1cfbafad8e705de5f

Thanks!

I have checked those files and found that device is in the table and
pretty much properly defined ACPI I2C slave.

The change in the driver you referred to makes the change to modalias.

Thus, I'm suspecting that your user space helper either has some hard
coded values for previous case, or just broken.

Can you also check is the codec module loaded (lsmod) and, if it's not,
load it manually and check if sound works again.

P.S. In any case you need the patch mentioned in bug #196397

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
