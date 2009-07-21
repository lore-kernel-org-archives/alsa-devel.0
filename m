From: John Bonesio <bones@secretlab.ca>
Subject: ASoC: PATCH: mpc5200_psc_ac97 (was Re: AC97 on pcm030
 board with WM9712 codec)
Date: Tue, 21 Jul 2009 13:24:04 -0700
Message-ID: <1248207844.27542.16.camel@riker>
References: <1248132551.6532.267.camel@riker>
	<20090721090104.GA12667@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 532AB1037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 22:24:25 +0200 (CEST)
Received: by bwz26 with SMTP id 26so1996844bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 13:24:24 -0700 (PDT)
In-Reply-To: <20090721090104.GA12667@rakim.wolfsonmicro.main>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org


>From ac594ad4aff30af6d65375df1a5e6c3b43134721 Mon Sep 17 00:00:00 2001
From: John Bonesio <bones@secretlab.ca>
Date: Tue, 21 Jul 2009 13:15:40 -0700
Subject: [PATCH] ASoC: MPC5200: Increase the delay time between resets

Reset was failing with the original udelay(50) between the code in
psc_ac97_cold_reset() and the call to psc_ac97_warm_reset(). Through testing
it was found that a delay of 1ms was necessary for the cold_reset code to
consistently complete successfully.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---
 sound/soc/fsl/mpc5200_psc_ac97.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 7eb5499..c4ae3e0 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/delay.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -112,7 +113,7 @@ static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 	out_8(&regs->op1, MPC52xx_PSC_OP_RES);
 	udelay(10);
 	out_8(&regs->op0, MPC52xx_PSC_OP_RES);
-	udelay(50);
+	msleep(1);
 	psc_ac97_warm_reset(ac97);
 }
 
-- 
1.6.0.4





On Tue, 2009-07-21 at 10:01 +0100, Mark Brown wrote:
> On Mon, Jul 20, 2009 at 04:29:11PM -0700, John Bonesio wrote:
> 
> > AC97 link. The AC97 driver also calls warm_reset() after the cold reset
> > is complete. Earlier the warm_reset() call was added in the AC97
> > cold_reset() routine to attempt to solve this bug, but it appears to not
> > completely solve the issue. After the reset the wm9712 driver attempts
> 
> No, the warm reset is an unrelated change.  The warm reset is there
> because the WM9712 can be strapped to not start up the AC97 link at
> startup.
> 
> > 2. Perhaps the cold_reset is not necessary and the warm_reset is all
> > that is needed
> 
> No, AC97 cold and warm resets do different things.  A cold reset
> restores the device to power on state while a warm reset will restart
> the AC97 link if it was not already running without changing any
> register settings in the device.  A warm reset cannot substitute for a
> cold reset.
> 
> [Buggy GPIOs]
> > might contain uninitialized values on power up. Should I still consider
> > this as a potential problem, or is this pretty much a non-issue?
> 
> Depends how much you trust your AC97 controller.
> 
> > would go away. So instead I increased the length of time in the udelay()
> > call right before the call to warm_reset(). I've empirically found that
> > delaying 1ms (udelay(50) -> udelay(1000)) seems to avoid the problem.
> > I'm not sure why this delay is necessary, or if it makes sense for the
> > hardware to need this much time to come out of the cold reset.
> 
> I'm not sure which delay you're talking about here (I'm guessing that
> it's one of those in the PSC driver?) but this does sound entirely
> plausible - if it resolves the issue could you produce a patch, please?
> I'd suggest changing to use msleep() instead of udeley() since delay
> will busy wait while sleep won't.
> 
> Thanks for your work on this.
