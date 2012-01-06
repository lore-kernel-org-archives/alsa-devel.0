From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
	of the	driver model
Date: Fri, 6 Jan 2012 23:44:45 +0000
Message-ID: <20120106234445.GC13857@n2100.arm.linux.org.uk>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 765DB103B4E
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 00:45:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106234135.GH2893@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 03:41:39PM -0800, Mark Brown wrote:
> This only helps this specific device model bit of things, if anything is
> still actually holding a reference to the device and tries to use it
> after we tore away the resource underneath it we'll still explode (never
> mind the fact that we're backing this stuff up with some global pointers
> to other devices which may or may not actually be there...).

Err what?  Explain showing the code where you think this is the case
with the patch I proposed please.
