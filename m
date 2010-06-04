From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Fri, 4 Jun 2010 19:27:00 +1000
Message-ID: <20100604092700.GD3662@www.longlandclan.yi.org>
References: <hu6v9i$v43$1@dough.gmane.org>
	<20100603112022.GA24589@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4CB1C24386
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jun 2010 11:27:08 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OKTB8-0000Dp-Uz
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 19:27:03 +1000
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OKTB8-0000Dm-Td
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 19:27:02 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OKTB8-0000BL-HE
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 19:27:02 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OKTB8-0000BH-Fz
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 19:27:02 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OKTB7-0002gR-Ki
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 19:27:02 +1000
Content-Disposition: inline
In-Reply-To: <20100603112022.GA24589@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 12:20:24PM +0100, Mark Brown wrote:
> On Thu, Jun 03, 2010 at 11:07:57AM +1000, Stuart Longland wrote:
> 
> Please do remember to CC maintainers on posts to mailing lists.  I've
> had to remind you previously about dropping CCs (and see that you were
> doing that again this morning)...

Well no, this was a separate query to the other thread, and one of a
more general nature (not specific to the 'AIC3204... and not necessarily
ASoC specific either).

> > My query though; the mixer on this CODEC provides gain settings, 
> > helpfully scaled in dB, as signed integers.  For instance; the four line 
> > level output drivers: Headphone left/right,and Line Out left/right, can 
> > all be adjusted in gain from -6dB through to +29dB.
> 
> Are you looking for SOC_DOUBLE_R_SX_TLV and variants thereof by any
> chance?  If you need variants you'd need to add them but that's
> straightforward.

Is this something that has been added since kernel 2.6.34?  I'll have a
hunt around for it, but I haven't spotted that in the kernel tree I'm
using.

I'm running slightly-behind bleeding edge here, since I hit a few
regressions[1] with the latest code (ARM-wise), and rather than battle
those in this early phase of development, I decided to move back to
something stable, get it working, then bring it forward.  It's for this
reason that my driver currently uses the older driver registration
model.

Once I get it working; there will likely be two forks of it -- one
brought up to mainline to go into the tree... and one to be backported
to kernel 2.6.28 which is what we're using in our product (as everything
else we have works with that kernel).

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

1. There were a couple of stability issues I struck; moving back to
2.6.34 "fixed" them, so I figured they'd be something worth tackling
once I got everything else working.
