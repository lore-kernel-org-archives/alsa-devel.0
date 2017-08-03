From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use correct nuvoton
	codec ID" to the asoc tree
Date: Thu, 03 Aug 2017 17:28:04 +0100
Message-ID: <E1ddIyi-0001rV-TB@debutante>
References: <1501654663-24663-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3021C266D9B
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:28:24 +0200 (CEST)
In-Reply-To: <1501654663-24663-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use correct nuvoton codec ID

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

>From d70c4a048195769ff22e65b9efe984de2259b974 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 2 Aug 2017 11:47:43 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use correct nuvoton codec ID

Correcting the nau88l25 codec ID to match secondary codec
and load the machine driver.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9e3f8c04dd32..6b49feb11b12 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -879,12 +879,12 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_codecs skl_codecs = {
 	.num_codecs = 1,
-	.codecs = {"NAU88L25"}
+	.codecs = {"10508825"}
 };
 
 static struct sst_codecs kbl_codecs = {
 	.num_codecs = 1,
-	.codecs = {"NAU88L25"}
+	.codecs = {"10508825"}
 };
 
 static struct sst_codecs bxt_codecs = {
-- 
2.13.2
