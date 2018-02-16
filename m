From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Kabylake Dialog+Maxim
	machine driver entry" to the asoc tree
Date: Fri, 16 Feb 2018 12:05:02 +0000
Message-ID: <E1emelC-000562-Px@debutante>
References: <1517804997-13776-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 734EE267E21
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 13:05:08 +0100 (CET)
In-Reply-To: <1517804997-13776-3-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, harshapriya.n@intel.com, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Kabylake Dialog+Maxim machine driver entry

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

>From ea954fbc35e655c77c11389124a29aae873e5ca6 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Mon, 5 Feb 2018 09:59:57 +0530
Subject: [PATCH] ASoC: Intel: Add Kabylake Dialog+Maxim machine driver entry

Adds Kabylake kbl_da7219_max98357a_i2s machine driver entry into
machine table

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 32ce64c6b2dc..aa9edc84eefb 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1017,6 +1017,11 @@ static struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
 	.codecs = {"10EC5663", "10EC5514"}
 };
 
+static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
 static struct skl_machine_pdata cnl_pdata = {
 	.use_tplg_pcm = true,
 };
@@ -1105,6 +1110,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
 		.drv_name = "kbl_rt5663",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "kbl_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_7219_98357_codecs,
+		.pdata = &skl_dmic_data
+	},
 
 	{}
 };
-- 
2.16.1
