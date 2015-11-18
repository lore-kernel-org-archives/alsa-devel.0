From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add adi + nau8825
	machine driver entry" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:16 +0000
Message-ID: <E1Zz7lE-0001PN-09@debutante>
References: <1446744188-1274-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75220265B94
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:21 +0100 (CET)
In-Reply-To: <1446744188-1274-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fang Yang A <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add adi + nau8825 machine driver entry

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

>From 02cc23555dfeec9ab87340f052541dd906fb440c Mon Sep 17 00:00:00 2001
From: "Fang, Yang A" <yang.a.fang@intel.com>
Date: Thu, 5 Nov 2015 22:53:08 +0530
Subject: [PATCH] ASoC: Intel: Skylake: add adi + nau8825 machine driver entry

This patch adds skl_nau8825_ssn4567_i2s machine driver into
machine table

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 390f839d6168..8ead864f354a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -587,6 +587,8 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
+	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
+				NULL, NULL, NULL },
 	{}
 };
 
-- 
2.6.2
