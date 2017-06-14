From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Kabylake
	RT5663+RT5514+MAX98927 machine driver entry" to the asoc tree
Date: Wed, 14 Jun 2017 19:21:55 +0100
Message-ID: <E1dLCvT-0002CR-Qk@debutante>
References: <1496885261-10771-4-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 731762672C4
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 20:22:09 +0200 (CEST)
In-Reply-To: <1496885261-10771-4-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine driver entry

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

>From ad7fb5a3b89a7a11d3306948c6954de7a999be40 Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Wed, 14 Jun 2017 10:32:19 -0700
Subject: [PATCH] ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine
 driver entry

This patch adds Kabylake I2S machine driver which uses codecs
MAX98927 as speakers and RT5514 as dmic on ssp0 and
RT5663 as headset on ssp1.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6a79fc759fb4..e761550c6dad 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -896,6 +896,12 @@ static struct sst_codecs kbl_poppy_codecs = {
 	.codecs = {"10EC5663"}
 };
 
+static struct sst_codecs kbl_5663_5514_codecs = {
+	.num_codecs = 2,
+	.codecs = {"10EC5663", "10EC5514"}
+};
+
+
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
 		.id = "INT343A",
@@ -960,6 +966,14 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 	},
 	{
 		.id = "MX98927",
+		.drv_name = "kbl_r5514_5663_max",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = sst_acpi_codec_list,
+		.quirk_data = &kbl_5663_5514_codecs,
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98927",
 		.drv_name = "kbl_rt5663_m98927",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 		.machine_quirk = sst_acpi_codec_list,
-- 
2.11.0
