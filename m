From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Fri, 25 Aug 2017 17:49:20 +0300
Message-ID: <1503672560.25945.104.camel@linux.intel.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
         <1503669407.25945.102.camel@linux.intel.com>
         <20170825142426.GN2827@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825142426.GN2827@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-08-25 at 10:24 -0400, Tom Rini wrote:
> On Fri, Aug 25, 2017 at 04:56:47PM +0300, Andy Shevchenko wrote:
> > +John
> > 
> > On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > > Not all devices with ACPI and this combination of sound devices
> > > will
> > > have the required information provided via ACPI.  Reintroduce the
> > > I2C
> > > device ID to restore sound functionality on on the Chromebook
> > > 'Samus'
> > > model.
> > 
> > Tom, one more question.

Just to be clear, the below has nothing to do with this patch or my
patches against rt5677.c. It points to a possible separate issue.

> > 
> > Apparently you are the one who tested the commit
> > 	89128534f925 ("ASoC: rt5677: Add ACPI support")
> > year ago.
> 
> Yes.
> 
> > The commit states that ACPI properties that are used in Chromebook
> > Pixel
> > 2015 is non-standard (not the same as for DT).
> > 
> > However, DSDT shows the opposite!
> 
> Interesting.  I'm not an ACPI person, I just tested what John came up
> with.
> 
> > I would like to ask yuo and John what is the status of that
> > currently?
> > Do we have any publicly available laptop with non-standard
> > properties?
> 
> Is there any sort of "build date" or similar in the dump I provided
> yesterday?

Header has this

 *     Signature        "DSDT"
 *     Length           0x00004720 (18208)
 *     Revision         0x02
 *     Checksum         0x6E
 *     OEM ID           "COREv4"
 *     OEM Table ID     "COREBOOT"
 *     OEM Revision     0x20110725 (537986853)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20130117 (538116375)

...if it's ever changed.

>   Every once in a while my laptop accidentally books into
> ChromeOS and then it might grab and apply some updates and it's not
> impossible that Google updated things in the interim.
> 
> I'm quite happy to test patches or provide further dumps / etc from my
> system.  You might want to start by talking with the person behind
> https://github.com/raphael/linux-samus to see if they know more about
> different versions of the hardware or at least point you towards more
> testers.  Thanks!

It's just a heads up to point to a potential problem with this board. I
suspect Google would take care of this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
