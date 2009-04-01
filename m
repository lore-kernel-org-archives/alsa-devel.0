From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Wed, 1 Apr 2009 20:27:10 +0100
Message-ID: <20090401192710.GH21294@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C8631037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 21:27:11 +0200 (CEST)
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

I've reproduced and fixed this for the ASoC native driver case (patch
below); looking at the code and history I can't immediately see how this
ever worked properly - the parent appears to have been NULL ever since
ASoC was merged into mainline.  I can't reproduce this for the ac97.c
case, the code looks correct and the behaviour at runtime also appears
correct in my tests.

I also haven't manage to reproduce the ordering issues with the register
writes with or without my fixes so I can't be 100% confident that this
will fix the problem you're seeing.  If you could post your machine
driver that'd be helpful.

> I'm not sure where wm9705-ts currently appears in the device tree (I
> need to resume the device, and sort out its resume quirks so that I can
> see the sysfs layout... but I'm absolutely sure that the ac97 device
> appears at /sys/devices/platform/ which is definitely wrong.

Note that there *is* a device for the AC97 controller visible in the
device tree but that currently it plays no role in suspend and resume
when ASoC is being used, it exists only to tell ASoC that the AC97
device has probed.  Hopefully by 2.6.31 there will be internal
synchronisation within ASoC to do the suspend and resume of the entire
ASoC card over multiple parent buses when the first and last component
get called.

>From 2ad05c2b141d14a668467cb9ec50b8beb5d19a8d Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 1 Apr 2009 19:35:01 +0100
Subject: [PATCH] ASoC: Set parent for AC97 devices we register

Ensure that any AC97 devices that bind to the CODEC are below the
ASoC device in the device tree so the suspend and resume code can
figure out what order to handle them in.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6c62d4a..99712f6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -98,7 +98,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	int err;
 
 	codec->ac97->dev.bus = &ac97_bus_type;
-	codec->ac97->dev.parent = NULL;
+	codec->ac97->dev.parent = codec->card->dev;
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-- 
1.6.2.1
