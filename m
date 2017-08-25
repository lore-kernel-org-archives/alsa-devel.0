From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 16:33:08 +0300
Message-ID: <1503667988.25945.100.camel@linux.intel.com>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
 <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 449E7266EA7
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 15:33:13 +0200 (CEST)
In-Reply-To: <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-08-25 at 14:11 +0100, Mark Brown wrote:
> On Thu, Aug 24, 2017 at 06:11:12PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > > But the id table is already empty...?
> > > Right, that seems like a bug though.
> > Well, that's what the commit ddc9e69b9dc2 does after all: it cleans
> > up
> > the legacy usage, and moves all either OF or ACPI matching.
> 
> Which is broken since not all the world is ACPI or DT.

While I agree on the second part, I don't think it's broken per se,
there never was a single user of that, and looking how ASoC board files
are organized it is quite unlikely there will be one...

> > If we want to take back old i2c ids, better to put the explicit
> > i2c_match_id() check in rt5677_i2c_probe() instead of sticking with
> > the old i2c probe callback.
> 
> That's what I said, yes.

...though we can (re)introduce this dead code back for a potential user
in the future.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
