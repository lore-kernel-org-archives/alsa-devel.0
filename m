From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835: Enforce full symmetry" to the
	asoc tree
Date: Fri, 10 Nov 2017 21:28:57 +0000
Message-ID: <E1eDGrB-0004NB-4r@debutante>
References: <20171108200332.28949-5-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E16A267985
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 22:29:01 +0100 (CET)
In-Reply-To: <20171108200332.28949-5-hias@horus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835: Enforce full symmetry

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

>From 3d2b3c707b3f9516d6c183eb1ffbf02a6dc5dc98 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 8 Nov 2017 21:03:32 +0100
Subject: [PATCH] ASoC: bcm2835: Enforce full symmetry

bcm2835's configuration registers can't be changed when a stream
is running, which means asymmetric configurations aren't supported.

Channel and rate symmetry are already enforced by constraints
but samplebits had been missed.

As hw_params doesn't check for symmetry constraints by itself
and just returns success if a stream is running this led to
situations where asymmetric configurations were seeming to
succeed but of course didn't work because the hardware wasn't
configured at all.

Fix this by adding the missing samplerate symmetry constraint.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index f4b778ed350b..111b4ef7ce35 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -737,7 +737,8 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 				| SNDRV_PCM_FMTBIT_S32_LE
 		},
 	.ops = &bcm2835_i2s_dai_ops,
-	.symmetric_rates = 1
+	.symmetric_rates = 1,
+	.symmetric_samplebits = 1,
 };
 
 static bool bcm2835_i2s_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.15.0
