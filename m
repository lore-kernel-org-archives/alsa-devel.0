From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Fri, 24 Feb 2012 22:35:12 +0000
Message-ID: <20120224223512.GB15120@n2100.arm.linux.org.uk>
References: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
	<20120223171407.GC22562@n2100.arm.linux.org.uk>
	<4F480120.6080409@freescale.com>
	<20120224215448.GA15120@n2100.arm.linux.org.uk>
	<4F480871.9020206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 474B7103C52
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 23:35:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F480871.9020206@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 04:00:17PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> > BenH tells me that he'll accept patches which converts in_32be() to
> > ioread32be(), as in_32be() is ancient PPC cruft that needs to die.
> 
> Where did he say this?  in_be32() (and its variants) are used EVERYWHERE
> in PowerPC code.

It was actually Grant Likely who said it after Ben H said that drivers
using in_be* is historical PPC stuff that needs fixing.

> Also, keep in mind that on ARM, ioread32be() is probably wrong, because we
> want to read the register as little-endian.  The SSI audio controller is
> little-endian on i.MX chips and big-endian on PowerPC chip.  So we really
> need a native-endian variant of ioread32be().  ioread32() is little-endian
> on PowerPC, so we can't use that.

Ho hum.  So, what that's saying to me is that even implementing in_32be()
on ARM results in rubbish because it wouldn't be big endian there.

So are we heading towards driver specific sets of IO accessors? :-(  It
sounds like that's what it needs because of these different endian-ness
issues.

And lets not forget that we're talking just about this - there's also
the issue of on-SoC devices on ARM now appearing behind PCI buses on
x86, which would make those appear as LE.  I bet if any of those
appearing on PPC would appear in BE mode.  So, 'native endian' doesn't
work either.

So, I'm getting the feeling that something as simple as IO accessors are
just a huge mountain of crap waiting to bite.
