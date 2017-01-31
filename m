From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: rt5645: add ACPI ID 10EC3270" to the
	asoc tree
Date: Tue, 31 Jan 2017 21:17:42 +0000
Message-ID: <E1cYfo6-00011U-2n@debutante>
References: <1485461385-14544-10-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 227BE2673F5
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:50 +0100 (CET)
In-Reply-To: <1485461385-14544-10-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: rt5645: add ACPI ID 10EC3270

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

>From ff9d1fbb3ffa901472cbaf331c999745b5915906 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:37 -0600
Subject: [PATCH] ASoc: rt5645: add ACPI ID 10EC3270

ALC3270 is a low-cost version of RT5645, add ACPI ID
to enable probe and use rt5645 codec driver
Tested on Asus T100HA

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ccfabeb8aab7..b0c264d361bc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3548,6 +3548,7 @@ static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{ "10EC5640", 0 },
+	{ "10EC3270", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
-- 
2.11.0
