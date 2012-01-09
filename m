From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
	of the	driver model
Date: Mon, 9 Jan 2012 22:16:57 +0000
Message-ID: <20120109221657.GE30766@opensource.wolfsonmicro.com>
References: <20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
	<20120106234923.GI2893@opensource.wolfsonmicro.com>
	<20120109095125.GG21765@n2100.arm.linux.org.uk>
	<20120109195211.GA30766@opensource.wolfsonmicro.com>
	<20120109201110.GA8377@kroah.com>
	<20120109203129.GA25743@opensource.wolfsonmicro.com>
	<20120109213724.GB7795@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DC0224398
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 23:17:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120109213724.GB7795@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 09:37:24PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 09, 2012 at 12:31:30PM -0800, Mark Brown wrote:

> > If it's code like the rtd devices which is reasonably sensible and
> > stable that's one thing but wading into code we know is fragile for
> > what's essentially a warning fix is completely disproportionate.

> You're still under the impression that it's "just a warning" and not
> "a potential oops".

To repeat myself yet again: there are a bunch of other issues here, if
we're ever in the situation where we can trigger this oops we're also
likely to be running into other equally severe problems.  As I keep
having to say we've got code which is buggy, difficult to work with but
has been there for quite some time without actually triggering issues on
systems.  Nothing about this is saying -rc is a good time to be wading
into the code.

> And I disagree with your assessment of how easy it is to fix each
> problem.

> The rtd devices are stored in an array - this array needs breaking
> up into separate allocations for each rtd as the very first step in
> fixing that.  That then needs more error checking added, etc.

There's a patch for the rtds already, they should be fine now - we just
dynamically allocate the device rather than worrying about the rtd.  The
issue with AC'97 isn't that it's especially hard to make this specific
change, it's that the code is horrible and I don't trust it not to
explode underneath us if we change anything.

If you want to completely restructure the rtds as well as providng a
release function for 3.3 then you've got similar issues, you're talking
about restructuring which is *completely* out of scope for -rc.

> On the other hand, the AC'97 code in ASoC should need this to fix it:

Which is roughly what we did for the rtds too.  This won't do as-is
though:

>  #endif
>  	kfree(codec->ac97->bus);
> -	kfree(codec->ac97);
> +	put_device(&codec->ac97->dev);

We can't have potentially live devices floating around without a bus,
there's an assumption that a valid AC'97 device will be on a bus.
Moving the bus free into the device release function is probably all we
need to do for that.
