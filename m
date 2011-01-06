From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 21:41:04 +0000
Message-ID: <20110106214103.GH8018@opensource.wolfsonmicro.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
	<4D2624EB.6060704@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 964B8103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 22:40:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2624EB.6060704@freescale.com>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 02:24:11PM -0600, Timur Tabi wrote:

> What do I do if there are two CS4270s in a system, and they each have different
> power-on default values for the registers?  Granted, it's a contrived example,
> but this could happen if the first CS4270 is a rev1 chip, and the second is a
> rev2 chip.

So the driver should cope with this, for example by updating the rev1
configuration to match rev2 at probe time (presumably if the change in
rev2 was important enough to introduce the change for then rev1 needs
the change anyway).

> And even if this example is contrived, it's conceivable that there can be codecs
> where the power-on defaults are set by pin configuration.  Perhaps codec #1 is
> muted by default and codec #2 isn't.

Again, do something that seems tasteful.  For example, mark the relevant
register volatile as it might get varied randomly at runtime anyway (I'm
not sure how the mute pin plays with the register value?).  Or write out
a particular value at startup.

If there really are insurmountable obstacles (I don't beleive there are)
or you're really dead set on it then teach the core about having to read
back the state from the device.
