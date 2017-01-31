From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Add "10EC3276" ACPI ID" to the
	asoc tree
Date: Tue, 31 Jan 2017 21:18:06 +0000
Message-ID: <E1cYfoU-00019c-OQ@debutante>
References: <9e2493401df1f2f0419fa175b4fc9a84eb971e28.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DEC26745B
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:18:16 +0100 (CET)
In-Reply-To: <9e2493401df1f2f0419fa175b4fc9a84eb971e28.1483531270.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Add "10EC3276" ACPI ID

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

>From 03200140ee83b3655152bc0c144378732fec8af1 Mon Sep 17 00:00:00 2001
From: Alexandrov Stansilav <neko@nya.ai>
Date: Thu, 26 Jan 2017 14:09:31 -0600
Subject: [PATCH] ASoC: rt5640: Add "10EC3276" ACPI ID

Add ACPI ID "10EC3276" for sound card found on notebook HP Pavilion X2 10-p000.
ACPI DSDT Table on this device describes this card as ALC3276, but it is in fact rt5640.

Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e29a6defefa0..b857a715ef64 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2313,6 +2313,7 @@ MODULE_DEVICE_TABLE(of, rt5640_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
+	{ "10EC3276", 0 },
 	{ "10EC5640", 0 },
 	{ "10EC5642", 0 },
 	{ "INTCCFFD", 0 },
-- 
2.11.0
