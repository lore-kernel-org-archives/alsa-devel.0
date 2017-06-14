From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Convert all sst_codecs data
	definition to c99 style" to the asoc tree
Date: Wed, 14 Jun 2017 19:21:58 +0100
Message-ID: <E1dLCvW-0002DO-Ug@debutante>
References: <1496885261-10771-3-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 933EE2672C5
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 20:22:09 +0200 (CEST)
In-Reply-To: <1496885261-10771-3-git-send-email-harshapriya.n@intel.com>
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

   ASoC: Intel: Convert all sst_codecs data definition to c99 style

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

>From 9a90c972b6e5814a5f928f8d5a3d145fa50988b0 Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Wed, 14 Jun 2017 10:32:18 -0700
Subject: [PATCH] ASoC: Intel: Convert all sst_codecs data definition to c99
 style

C99 style struct initialization helps in readability as well as
initialization of variables not specified as NULL. This patch
changes the struct data definitions in skl.c that were not in c99 style.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4ebae850c559..6a79fc759fb4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -876,10 +876,25 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
-static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
-static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
-static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
+static struct sst_codecs skl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs kbl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"NAU88L25"}
+};
+
+static struct sst_codecs bxt_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
+static struct sst_codecs kbl_poppy_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10EC5663"}
+};
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
-- 
2.11.0
