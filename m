From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 18:09:52 +0300
Message-ID: <1503673792.25945.106.camel@linux.intel.com>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
 <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
 <1503667988.25945.100.camel@linux.intel.com>
 <20170825142140.bobbc2pclcw4x3vh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1672673DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 17:09:58 +0200 (CEST)
In-Reply-To: <20170825142140.bobbc2pclcw4x3vh@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-08-25 at 15:21 +0100, Mark Brown wrote:
> On Fri, Aug 25, 2017 at 04:33:08PM +0300, Andy Shevchenko wrote:
> > On Fri, 2017-08-25 at 14:11 +0100, Mark Brown wrote:
> > > On Thu, Aug 24, 2017 at 06:11:12PM +0200, Takashi Iwai wrote:
> > > > Well, that's what the commit ddc9e69b9dc2 does after all: it
> > > > cleans
> > > > up
> > > > the legacy usage, and moves all either OF or ACPI matching.
> > > Which is broken since not all the world is ACPI or DT.
> > While I agree on the second part, I don't think it's broken per se,
> > there never was a single user of that, and looking how ASoC board
> > files
> > are organized it is quite unlikely there will be one...
> 
> I have no idea why you say the ASoC machine drivers would prevent
> someone adding a platform based user,

For example, looking into
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
I see a direct use of codec driver without any platform driver
involvement.

Is it exception from the rule, or a common use?

>  obviously ASoC predates the use of
> both ACPI and DT quite considerably.

Yep, the current users of driver in question either DT or ACPI, would it
be pure platform in the future?

> 
> > > That's what I said, yes.
> > ...though we can (re)introduce this dead code back for a potential
> > user
> > in the future.
> 
> The IDs are back as a result of the merge resolution I did.

I'm fine as long as it doesn't include broken 'ACPI instance as I2C ID'.
Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
