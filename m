From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Nuvoton+Maxim machine driver
	entry" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:36 +0000
Message-ID: <E1a9twe-0006AF-HT@debutante>
References: <1449862153-68738-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8639526667E
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:44 +0100 (CET)
In-Reply-To: <1449862153-68738-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit Ainapure <rohit.m.ainapure@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Nuvoton+Maxim machine driver entry

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

>From 69b7f9c45856e49929bdde8492e5f46a07c8a2f3 Mon Sep 17 00:00:00 2001
From: Rohit Ainapure <rohit.m.ainapure@intel.com>
Date: Fri, 11 Dec 2015 11:29:07 -0800
Subject: [PATCH] ASoC: Intel: Add Nuvoton+Maxim machine driver entry

Add the NAU88L25 + MAX98357A machine driver entry into
the machine table

Signed-off-by: Rohit Ainapure <rohit.m.ainapure@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2c16325d1ce1..c38bf99ced10 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -600,6 +600,8 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
 	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
 				NULL, NULL, NULL },
+	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
+				NULL, NULL, NULL },
 	{}
 };
 
-- 
2.6.2
