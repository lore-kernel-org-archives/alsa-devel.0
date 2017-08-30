From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt274: add acpi id" to the asoc tree
Date: Wed, 30 Aug 2017 16:22:50 +0100
Message-ID: <E1dn4pO-0003Up-BM@debutante>
References: <1504067311-6416-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFDD2671BA
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 17:23:07 +0200 (CEST)
In-Reply-To: <1504067311-6416-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt274: add acpi id

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 60b0fdeac19945107b956a8a2a0ba3a14827db60 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 30 Aug 2017 12:28:31 +0800
Subject: [PATCH] ASoC: rt274: add acpi id

Add ACPI id for Intel platform.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index fb683ffc4e03..0be69c112c45 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1102,6 +1102,7 @@ MODULE_DEVICE_TABLE(i2c, rt274_i2c_id);
 
 static const struct acpi_device_id rt274_acpi_match[] = {
 	{ "10EC0274", 0 },
+	{ "INT34C2", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt274_acpi_match);
-- 
2.14.1
