From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Kabylake RT5663 machine
	driver entry" to the asoc tree
Date: Fri, 28 Jul 2017 13:37:38 +0100
Message-ID: <E1db4WQ-0004rI-1g@finisterre>
References: <20170724032339.4304-3-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C56266C13
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 14:37:54 +0200 (CEST)
In-Reply-To: <20170724032339.4304-3-kevin.cheng@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kevin.cheng@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Kabylake RT5663 machine driver entry

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

>From 0dfa7a046aa9a3e3dcaee59bfc23598679fc4247 Mon Sep 17 00:00:00 2001
From: Kevin Cheng <kevin.cheng@intel.com>
Date: Thu, 27 Jul 2017 16:38:37 +0800
Subject: [PATCH] ASoC: Intel: Add Kabylake RT5663 machine driver entry

Adds Kabylake rt5663 machine driver entry into machine table

Signed-off-by: Kevin Cheng <kevin.cheng@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917ee41cf..01a2dd6518a4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -981,6 +981,11 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.quirk_data = &kbl_poppy_codecs,
 		.pdata = &skl_dmic_data
 	},
+	{
+		.id = "10EC5663",
+		.drv_name = "kbl_rt5663",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
 
 	{}
 };
-- 
2.13.2
