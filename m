From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5660: Add a new ACPI match ID" to the
	asoc tree
Date: Thu,  6 Dec 2018 20:25:46 +0000 (GMT)
Message-ID: <20181206202546.05AC811252F7@debutante.sirena.org.uk>
References: <20181206145207.4477-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA3AF267CBB
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:25:51 +0100 (CET)
In-Reply-To: <20181206145207.4477-1-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: tiwai@suse.de, naveen.m@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5660: Add a new ACPI match ID

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

>From a01b8d1d24451bfc00d3a975d107f9b1590bf826 Mon Sep 17 00:00:00 2001
From: Hui Wang <hui.wang@canonical.com>
Date: Thu, 6 Dec 2018 22:52:05 +0800
Subject: [PATCH] ASoC: rt5660: Add a new ACPI match ID

The Realtek codec ALC3277 is 100% compatible with the codec RT5660
in I2S mode. And on the Dell IoT platform, the codec is ALC3277,
and the HID of the codec in the BIOS is 10EC3277, so adding this
ID to the ACPI match table.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 20a755137e63..ba1e9d89ad1b 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1245,6 +1245,7 @@ MODULE_DEVICE_TABLE(of, rt5660_of_match);
 
 static const struct acpi_device_id rt5660_acpi_match[] = {
 	{ "10EC5660", 0 },
+	{ "10EC3277", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5660_acpi_match);
-- 
2.19.0.rc2
