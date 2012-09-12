From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA9055 codec driver
Date: Wed, 12 Sep 2012 20:49:34 +0800
Message-ID: <20120912124932.GC19055@opensource.wolfsonmicro.com>
References: <1347375823.12329.14.camel@matrix>
 <20120912025709.GD9162@opensource.wolfsonmicro.com>
 <1347454578.23366.305.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 767C22616A1
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 14:49:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347454578.23366.305.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2012 at 06:26:18PM +0530, Ashish Chavan wrote:
> On Wed, 2012-09-12 at 10:57 +0800, Mark Brown wrote:

> > Why is any of this being exposed to userspace?  If this should be
> > configured I'd expect it to be static platform data, not something that
> > gets changed at runtime.

> These parameters are exposed considering the fact that DMIC itself is
> not part of the codec. Codec only provides DMIC interface using which an
> external DMIC can be attached. These parameters depend on the actual
> DMIC hardware and hence kept configurable to allow runtime plug in of
> any DMIC hardware. Doesn't it make sense to keep them runtime
> configurable?

No.  The only realistic way to attach a new DMIC to a board is to solder
it down, that's not something people are going to do while the system is
actve.  It's something that's fixed at PCB design time.

> > > +	/* In slave mode, there is only one set of divisors */
> > > +	if (!da9055->master)
> > > +		fout = 2822400;

> > Should check the user supplied this value

> Can you explain which value / user supplied value you are referring to?
> It is not quite clear to me.

The specified output frequency, you just totally ignore it.

> For other things like input mixers, Headphone and Lineouts, DAPM is
> already used to control power specific bits. The confusion is because
> there are two separate control bits for these blocks. One bit is for
> "Enabling" that block and other is for "Enabling Amplifier" of that
> block.
> e.g for headphone, one bit is for "output enable" while other is for
> "output amplifier enable".

So document this.
