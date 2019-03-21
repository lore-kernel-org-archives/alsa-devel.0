From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4270: Set auto-increment bit for
	register writes" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:15 +0000 (GMT)
Message-ID: <20190321150715.EA57311288EC@debutante.sirena.org.uk>
References: <20190320214156.16346-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CD8DF89734
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:07:17 +0100 (CET)
In-Reply-To: <20190320214156.16346-1-daniel@zonque.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4270: Set auto-increment bit for register writes

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

>From f0f2338a9cfaf71db895fa989ea7234e8a9b471d Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 20 Mar 2019 22:41:56 +0100
Subject: [PATCH] ASoC: cs4270: Set auto-increment bit for register writes

The CS4270 does not by default increment the register address on
consecutive writes. During normal operation it doesn't matter as all
register accesses are done individually. At resume time after suspend,
however, the regcache code gathers the biggest possible block of
registers to sync and sends them one on one go.

To fix this, set the INCR bit in all cases.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4270.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 33d74f163bd7..793a14d58667 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -642,6 +642,7 @@ static const struct regmap_config cs4270_regmap = {
 	.reg_defaults =		cs4270_reg_defaults,
 	.num_reg_defaults =	ARRAY_SIZE(cs4270_reg_defaults),
 	.cache_type =		REGCACHE_RBTREE,
+	.write_flag_mask =	CS4270_I2C_INCR,
 
 	.readable_reg =		cs4270_reg_is_readable,
 	.volatile_reg =		cs4270_reg_is_volatile,
-- 
2.20.1
