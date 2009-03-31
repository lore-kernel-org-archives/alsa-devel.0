From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 + touchscreen
	suspend/resume
Date: Tue, 31 Mar 2009 20:15:40 +0100
Message-ID: <20090331191539.GA10854@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E86211037ED
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 21:15:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090331183755.GA27451@n2100.arm.linux.org.uk>
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
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 31, 2009 at 07:37:55PM +0100, Russell King - ARM Linux wrote:

> I don't think this is the complete story.  Sometime between 2.6.27 and
> 2.6.29, the structure below /sys/devices/platform/soc-audio changed
> (the ac97 codec moved to the top level.)

Oh, are you using the ac97.c codec driver?  With a normal ASoC codec
driver the AC97 codec is not visible as a separate device in the device
tree - if you could point me to your machine driver that'd be helpful.

I'll take a look at ac97.c tomorrow; there have been some problems found
with the way it registers in that timeframe so it's likely that one of
the fixes there has caused the regression.  The way it uses the generic
ALSA AC97 code means that it needs some special casing.

As a workaround I'd suggest using the generic PXA AC97 support in
sound/arm rather than an ASoC machine driver.  Switching your machine
driver to use the WM9705 codec driver should also avoid the problems.
