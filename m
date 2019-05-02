From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add Geminilake
	Realtek+Maxim machine driver entry" to the asoc tree
Date: Thu,  2 May 2019 03:18:23 +0100 (BST)
Message-ID: <20190502021823.EEE54441D3D@finisterre.ee.mobilebroadband>
References: <1554917251-16772-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F15BF89724
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:32 +0200 (CEST)
In-Reply-To: <1554917251-16772-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, tiwai@suse.de, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add Geminilake Realtek+Maxim machine driver entry

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

>From d3692cb5c56daa2fb8046a8f4ebe1b2b8b22c895 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Wed, 10 Apr 2019 12:27:31 -0500
Subject: [PATCH] ASoC: Intel: common: add Geminilake Realtek+Maxim machine
 driver entry

This patch adds glk_rt5682_max98357a_i2s machine driver entry into
machine table. Both Skylake and SOF platform drivers can use this
machine drivers.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 3f2061475ae4..616eb09e78a0 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -31,6 +31,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.sof_fw_filename = "sof-glk.ri",
 		.sof_tplg_filename = "sof-glk-da7219.tplg",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "glk_rt5682_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &glk_codecs,
+		.sof_fw_filename = "sof-glk.ri",
+		.sof_tplg_filename = "sof-glk-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
-- 
2.20.1
