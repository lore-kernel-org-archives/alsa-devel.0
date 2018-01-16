From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()" to the asoc tree
Date: Tue, 16 Jan 2018 13:57:14 +0000
Message-ID: <E1ebRjm-0005D1-DP@debutante>
References: <20180115080838.q6nupi7rs7k5pdky@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180115080838.q6nupi7rs7k5pdky@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 123af9043e93cb6f235207d260d50f832cdb5439 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 15 Jan 2018 11:08:38 +0300
Subject: [PATCH] ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

The loop timeout doesn't work because it's a post op and ends with "tmo"
set to -1.  I changed it from a post-op to a pre-op and I changed the
initial the starting value from 5 to 6 so we still iterate 5 times.  I
left the other as it was because it's a large number.

Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/ac97c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 29a97d52e8ad..66d6c52e7761 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac97 *ac97,
 	do {
 		mutex_lock(&ctx->lock);
 
-		tmo = 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo = 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac97 *ac97,
 		 * poll, Forrest, poll...
 		 */
 		tmo = 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data = RD(ctx, AC97_CMDRESP);
 
-- 
2.15.1

