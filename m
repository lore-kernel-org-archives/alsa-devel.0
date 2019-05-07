From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677-spi: Rename driver to
	differentiate from main codec" to the asoc tree
Date: Tue,  7 May 2019 03:32:47 +0100 (BST)
Message-ID: <20190507023247.402B1440033@finisterre.sirena.org.uk>
References: <20190503193342.241330-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4280BF8972A
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 04:32:58 +0200 (CEST)
In-Reply-To: <20190503193342.241330-1-cujomalainey@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677-spi: Rename driver to differentiate from main codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b9960f6ea22da072c2fb27305a1a51517c3643fe Mon Sep 17 00:00:00 2001
From: Curtis Malainey <cujomalainey@chromium.org>
Date: Fri, 3 May 2019 12:33:42 -0700
Subject: [PATCH] ASoC: rt5677-spi: Rename driver to differentiate from main
 codec

Currently the SPI driver and the main codec share the same name. This
will become confusing when looking up components when using both
drivers.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677-spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 167a02773a0b..1efc37ee625f 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -29,6 +29,8 @@
 
 #include "rt5677-spi.h"
 
+#define DRV_NAME "rt5677spi"
+
 #define RT5677_SPI_BURST_LEN	240
 #define RT5677_SPI_HEADER	5
 #define RT5677_SPI_FREQ		6000000
@@ -235,7 +237,7 @@ MODULE_DEVICE_TABLE(acpi, rt5677_spi_acpi_id);
 
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
-		.name = "rt5677",
+		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(rt5677_spi_acpi_id),
 	},
 	.probe = rt5677_spi_probe,
-- 
2.20.1
