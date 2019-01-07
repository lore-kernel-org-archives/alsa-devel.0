From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add ACPI ID 10EC5640" to the
	asoc tree
Date: Mon,  7 Jan 2019 19:24:42 +0000 (GMT)
Message-ID: <20190107192442.C22FA1127491@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A45712673B4
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 20:24:43 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add ACPI ID 10EC5640

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

>From d306873589c5a4c13df7176cd73d66ebfa690064 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 30 Dec 2018 00:00:20 +0100
Subject: [PATCH] ASoC: rt5651: Add ACPI ID 10EC5640

Some BYT platforms have a RT5651 codec while using an ACPI node with
a HID of 10EC5640 to describe the coded. Add the 10EC5640 HID to the
acpi_device_id list, so that the rt5651 will bind to the codec on these
devices.

Like the rt5645 and rt5670 drivers which also have the 10EC5640 ACPI HID
in their acpi_device_id list for similar reasons, the rt5651 driver checks
the codecs device-id register so that it will only bind if the codec
actually is a rt5651 and it will ignore actual rt5640 codecs.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 3882e238ff99..9a007c162631 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2138,6 +2138,7 @@ MODULE_DEVICE_TABLE(of, rt5651_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5651_acpi_match[] = {
 	{ "10EC5651", 0 },
+	{ "10EC5640", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5651_acpi_match);
-- 
2.20.1
