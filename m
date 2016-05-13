From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: fix null deref on acpi driver
	data" to the asoc tree
Date: Fri, 13 May 2016 08:59:09 +0100
Message-ID: <E1b1805-0004vZ-HL@debutante>
References: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D69026043A
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 09:59:14 +0200 (CEST)
In-Reply-To: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: fix null deref on acpi driver data

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

>From bb7cb54b388d8d0fbb3af27f14b121ee9c92e867 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 12 May 2016 09:38:49 +0530
Subject: [PATCH] ASoC: rt298: fix null deref on acpi driver data

ACPI driver data can be NULL so we need to check that before
dereference the driver data.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index f0e6c06e89ac..52aacb1d5e4c 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1184,7 +1184,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 
 	/* enable jack combo mode on supported devices */
 	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (acpiid) {
+	if (acpiid && acpiid->driver_data) {
 		rt298->pdata = *(struct rt298_platform_data *)
 				acpiid->driver_data;
 	}
-- 
2.8.1
