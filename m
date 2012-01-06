From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
 of the driver model
Date: Fri, 6 Jan 2012 12:15:01 -0800
Message-ID: <20120106201458.GF2893@opensource.wolfsonmicro.com>
References: <20120106194052.GA7781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2565624434
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 21:15:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106194052.GA7781@kroah.com>
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
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 11:40:52AM -0800, Greg KH wrote:

> It was recently pointed out to me that the sound/soc/soc-core.c is
> flagrantly abusing the driver model by providing "empty" release
> functions, just to keep the kernel from complaining:

> Come on people, do you think that I wrote the code in the kernel that
> produces those errors just for fun?  It was telling you to fix your code
> by providing a function to free the structure that is being released,
> not to try to trick the kernel because you think you know better.  The
> kernel was trying to help you out here, to get the programming model
> correct, in a place that was commonly misunderstood.

The problem is that due to the entertaining nature of AC'97 support in
Linux we don't actually have anything to free at this point - we'd need
to redo the whole infrastructure, not just this code.

You really need to find someone with an ongoing interest in AC'97 and
convince them that it's worth overhauling the bus, the whole thing is
just too much of a can of worms to touch.  Fixing this for 3.3 seems
completely insane, we're already in the merge window and there's too
many skeletons.

I'm not even sure I have any AC'97 hardware any more myself.
