From: Greg KH <greg@kroah.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
 of the driver model
Date: Mon, 9 Jan 2012 12:11:10 -0800
Message-ID: <20120109201110.GA8377@kroah.com>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
	<20120106234923.GI2893@opensource.wolfsonmicro.com>
	<20120109095125.GG21765@n2100.arm.linux.org.uk>
	<20120109195211.GA30766@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 134B124427
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 21:15:14 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C47C521F1D
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 15:15:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120109195211.GA30766@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 07:52:13PM +0000, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 09:51:25AM +0000, Russell King - ARM Linux wrote:
> 
> > Anything which helps reduce the abuses of the driver model is a plus -
> > it helps remove the possibility of kernel oopses.
> 
> Trying to make any sort of modification to code this fragile is risky,
> especially during what's supposed to be a stabalization phase (which is
> what Greg is requesting).  It just seems completely irresponsible for
> something that isn't actually a practical problem.

I find it hard to believe that ignoring the driver model is not a
"practical" problem :)

For details as to why this is a problem, please see the kobject.txt
file.

Please fix this up, as you have seen, people end up cutting-and-pasting
bad code.

greg k-h
