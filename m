From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Fri, 5 Jun 2009 10:30:02 +0100
Message-ID: <20090605093001.GA21128@rakim.wolfsonmicro.main>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
	<20090604085407.GB6983@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
	<20090604093737.GF6983@rakim.wolfsonmicro.main>
	<s5hiqjcqqo9.wl%tiwai@suse.de>
	<20090604103807.GG6983@rakim.wolfsonmicro.main>
	<s5hy6s7yrab.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20B6124635
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 11:30:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy6s7yrab.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 11:16:12AM +0200, Takashi Iwai wrote:

> I couldn't find it.  But IIRC, the original patch was to add "int irq"
> field to struct snd_ac97.  I would accept it because it can do any
> harm.

Ah, yes - I do remember that proposal.  The problem with that is that it
doesn't scale up to all the platform data you might want to pass in.
The WM97xx battery and touchscreen drivers are the main things I'm
interested in here - the platform data for the WM97xx touch driver is
struct wm97xx_mach_ops in include/linux/wm97xx.h for example.

> But, adding a generic "void *driver_data" instead of "int irq" can
> play a bad game.  It can be dangerous when the creator and the user of
> this pointer are different drivers.  That was my argument.

There is potential risk involved in these interfaces but it's the
standard idiom for doing this on embedded systems.  The buses definitely
don't want to know anything about the random data that drivers may need
and since you're not dealing with pluggable or variable hardware in the
same way as you do on PCs the risks of mismatched data aren't such a big
deal - you'd generally only be able to encounter problems if you're
building your own kernel.
