From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
	support
Date: Thu, 17 Feb 2011 06:11:38 +0000
Message-ID: <20110217061138.GB9645@opensource.wolfsonmicro.com>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	<20110216195314.GA29547@opensource.wolfsonmicro.com>
	<20110216185352.GC21063@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AFA224604
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 07:11:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110216185352.GC21063@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 17, 2011 at 02:53:52AM +0800, Zeng Zhaoming wrote:
> On Wed 2011-02-16 19:53:14, Mark Brown wrote:
> > On Wed, Feb 16, 2011 at 06:56:16AM +0800, zhaoming.zeng@freescale.com wrote:

> > > +	l = (reg & SGTL5000_DAC_VOL_LEFT_MASK) >> SGTL5000_DAC_VOL_LEFT_SHIFT;
> > > +	r = (reg & SGTL5000_DAC_VOL_RIGHT_MASK) >> SGTL5000_DAC_VOL_RIGHT_SHIFT;
> > > +	l = l < 0x3c ? 0x3c : l;
> > > +	l = l > 0xfc ? 0xfc : l;
> > > +	r = r < 0x3c ? 0x3c : r;
> > > +	r = r > 0xfc ? 0xfc : r;

> > My previous comments about the lebility of this still stand.

> Sorry, I don't catch you means quite well, you means more comments to make it clearer?

It needs to be clearer and I'm pretty certain that comments aren't
enough to deal with the issue - the stack of ternery operators and magic
numbers just isn't good for comprehensibility.

> > Since there's no macro arguments this could just be defined directly in
> > line.

> you means add it to kcontrol array directly instead of define a macro for it?

Yes.
