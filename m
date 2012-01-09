From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
 of the driver model
Date: Mon, 9 Jan 2012 12:31:30 -0800
Message-ID: <20120109203129.GA25743@opensource.wolfsonmicro.com>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
	<20120106234923.GI2893@opensource.wolfsonmicro.com>
	<20120109095125.GG21765@n2100.arm.linux.org.uk>
	<20120109195211.GA30766@opensource.wolfsonmicro.com>
	<20120109201110.GA8377@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A2F124435
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 21:31:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120109201110.GA8377@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 12:11:10PM -0800, Greg KH wrote:
> On Mon, Jan 09, 2012 at 07:52:13PM +0000, Mark Brown wrote:

> > Trying to make any sort of modification to code this fragile is risky,
> > especially during what's supposed to be a stabalization phase (which is
> > what Greg is requesting).  It just seems completely irresponsible for
> > something that isn't actually a practical problem.

> I find it hard to believe that ignoring the driver model is not a
> "practical" problem :)

> For details as to why this is a problem, please see the kobject.txt
> file.

Sure, I'm fully aware of the issue.  The reason this is so painful to
work with is that AC'97 is just generally doing a really bad job of
using the driver model.

> Please fix this up, as you have seen, people end up cutting-and-pasting
> bad code.

In my copious free time, but like I say trying to do this for 3.3 (you
only posted *after* the merge window opened) is just nuts and I'd rather
hope someone who cares about AC'97 systems will come forward and work on
it (having one would be a real bonus).  If people actually had problems
we were fixing that'd be one thing but if they do they're being
extremely quiet about it.

If it's code like the rtd devices which is reasonably sensible and
stable that's one thing but wading into code we know is fragile for
what's essentially a warning fix is completely disproportionate.  It's
not like we'd actually make a substantial improvement in the overall
code quality or robustness, if anyone's using AC'97 as a reference for
how to do this stuff they're going to have a bunch of other issues to
work through.
