From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 15:40:17 +0100
Message-ID: <20090402144017.GI9522@n2100.arm.linux.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
	<20090402141200.GH4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 920B6103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:40:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402141200.GH4527@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 03:12:01PM +0100, Mark Brown wrote:
> Before doing that could you please try the patch below to wm9705.c
> implementing suspend and resume operations?  It's completely
> speculative, I don't have a WM9705 test system to hand but I'm
> moderately confident

No real change - since I got rid of the debug printk's I scattered in
last time around, I don't know if this patch has changed anything.

It's actually worse though - using my devmem2 hack no longer restores
things to a functional state.  devmem2 says the control register is
now set as:

Value at address 0x4050000C: 0xC0002

but I'm still seeing lots of:

pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x0)                           
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x0)                             
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x0)                             
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x0)                             
...

messages.  Before, setting the control register to '2' (thereby
releasing the cold reset) caused things to start working again.
