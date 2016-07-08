From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: statify cht_quirk" to the
	asoc tree
Date: Fri, 08 Jul 2016 16:37:19 +0200
Message-ID: <E1bLWu7-0008Sk-PE@finisterre>
References: <1467982818-4528-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA625265D85
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 16:37:52 +0200 (CEST)
In-Reply-To: <1467982818-4528-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: statify cht_quirk

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

>From 24dad509ed5528bbbe31ff17f9fb39c0473ec8f4 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 8 Jul 2016 18:30:18 +0530
Subject: [PATCH] ASoC: Intel: atom: statify cht_quirk

Sparse rightly warns:
sound/soc/intel/atom/sst/sst_acpi.c:353:22: warning: symbol 'cht_quirk' was not declared. Should it be static?

So statify this

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 82a374d885a7..4d3184971227 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -350,7 +350,7 @@ static struct sst_acpi_mach cht_surface_mach = {
 	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 								&chv_platform_data };
 
-struct sst_acpi_mach *cht_quirk(void *arg)
+static struct sst_acpi_mach *cht_quirk(void *arg)
 {
 	struct sst_acpi_mach *mach = arg;
 
-- 
2.8.1
