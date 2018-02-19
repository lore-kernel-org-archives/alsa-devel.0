From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Fix regcache sync errors on
	resume" to the asoc tree
Date: Mon, 19 Feb 2018 12:18:19 +0000
Message-ID: <E1enkOh-0002i6-6s@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 006262673F6
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:18:22 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Fix regcache sync errors on resume

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

>From 2d30e9494f1ea320aaaad0cff9ddd92c87eac355 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:44 +0100
Subject: [PATCH] ASoC: rt5651: Fix regcache sync errors on resume

The ALC5651 does not like multi-write accesses, avoid them. This fixes:

rt5651 i2c-10EC5651:00: Unable to sync registers 0x27-0x28. -121

Errors on resume (and all registers after the registers in the error not
being synced).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5651.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 831b297978a4..45a73049cf64 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1722,6 +1722,7 @@ static const struct regmap_config rt5651_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+	.use_single_rw = true,
 };
 
 #if defined(CONFIG_OF)
-- 
2.16.1
