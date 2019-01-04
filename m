From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add ACPI match table entry for
	ES8316 codec on BYTCR platform" to the asoc tree
Date: Fri,  4 Jan 2019 17:08:46 +0000 (GMT)
Message-ID: <20190104170846.5D5B511270A3@debutante.sirena.org.uk>
References: <20190103134535.13861-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FEEE267C5C
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:08:47 +0100 (CET)
In-Reply-To: <20190103134535.13861-11-hdegoede@redhat.com>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add ACPI match table entry for ES8316 codec on BYTCR platform

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

>From 5198baf8817d7e6e0fe2f3e74ea2ead714b74d9c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:35 +0100
Subject: [PATCH] ASoC: Intel: Add ACPI match table entry for ES8316 codec on
 BYTCR platform

Some BYTCR devices use an ES8316 codec, add an ACPI match table entry
for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-byt-match.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 097dc06377ba..47a90909b956 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -154,6 +154,15 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
+	{
+		.id = "ESSX8316",
+		.drv_name = "bytcht_es8316",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_es8316",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-es8316.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
+	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{
 		.id = "10EC5645",
-- 
2.20.1
