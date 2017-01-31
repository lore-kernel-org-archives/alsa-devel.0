From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: rt5670: add quirk for Lenovo
	Thinkpad 10" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:57 +0000
Message-ID: <E1cYfoL-00016W-BX@debutante>
References: <1485461385-14544-7-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA19F26743A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:18:06 +0100 (CET)
In-Reply-To: <1485461385-14544-7-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: codecs: rt5670: add quirk for Lenovo Thinkpad 10

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

>From 93ffeaa8ee3f10a0628ad135b552a2497e0bef2c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:34 -0600
Subject: [PATCH] ASoC: codecs: rt5670: add quirk for Lenovo Thinkpad 10

the BIOS incorrectly reports this codec as 5640 but it is
really a rt5670

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 97bafac3bc15..17d20b99f041 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2814,6 +2814,7 @@ MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
 static const struct acpi_device_id rt5670_acpi_match[] = {
 	{ "10EC5670", 0},
 	{ "10EC5672", 0},
+	{ "10EC5640", 0}, /* quirk */
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5670_acpi_match);
-- 
2.11.0
