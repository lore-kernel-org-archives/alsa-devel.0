From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix a couple signedness
	bugs" to the asoc tree
Date: Wed, 16 Dec 2015 19:24:25 +0000
Message-ID: <E1a9HgX-0006RS-CB@debutante>
References: <20151212123815.GA21408@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 642C92657B3
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 20:24:32 +0100 (CET)
In-Reply-To: <20151212123815.GA21408@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix a couple signedness bugs

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

>From db4e561378b539230feb4db5e7d5d548c2db2cd4 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 15 Dec 2015 12:20:14 +0300
Subject: [PATCH] ASoC: Intel: Skylake: Fix a couple signedness bugs

These need to be signed because they hold negative error codes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8cd5cdb21fd5..e26f4746afb7 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -208,7 +208,7 @@ static unsigned int skl_get_errorcode(struct sst_dsp *ctx)
  * since get/set_module are called from DAPM context,
  * we don't need lock for usage count
  */
-static unsigned int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
+static int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
 {
 	struct skl_module_table *module;
 
@@ -220,7 +220,7 @@ static unsigned int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
 	return -EINVAL;
 }
 
-static unsigned int skl_put_module(struct sst_dsp *ctx, u16 mod_id)
+static int skl_put_module(struct sst_dsp *ctx, u16 mod_id)
 {
 	struct skl_module_table *module;
 
@@ -340,7 +340,7 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, char *guid)
 
 static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
 {
-	unsigned int usage_cnt;
+	int usage_cnt;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret = 0;
 
-- 
2.6.2
