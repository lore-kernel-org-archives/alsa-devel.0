From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
	of the	driver model
Date: Mon, 9 Jan 2012 19:52:13 +0000
Message-ID: <20120109195211.GA30766@opensource.wolfsonmicro.com>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
	<20120106234923.GI2893@opensource.wolfsonmicro.com>
	<20120109095125.GG21765@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC9432440F
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 20:52:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120109095125.GG21765@n2100.arm.linux.org.uk>
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

On Mon, Jan 09, 2012 at 09:51:25AM +0000, Russell King - ARM Linux wrote:

> Anything which helps reduce the abuses of the driver model is a plus -
> it helps remove the possibility of kernel oopses.

Trying to make any sort of modification to code this fragile is risky,
especially during what's supposed to be a stabalization phase (which is
what Greg is requesting).  It just seems completely irresponsible for
something that isn't actually a practical problem.
