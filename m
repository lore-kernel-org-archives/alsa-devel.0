From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Strip T and L from TLV
	IPCs" to the asoc tree
Date: Wed, 26 Jun 2019 12:32:44 +0100 (BST)
Message-ID: <20190626113244.83D0B44004F@finisterre.sirena.org.uk>
References: <20190613190436.20156-8-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A01FAF896CC
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 13:32:48 +0200 (CEST)
In-Reply-To: <20190613190436.20156-8-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kamil Lulko <kamilx.lulko@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, pierre-louis.bossart@linux.intel.com, tiwai@suse.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Strip T and L from TLV IPCs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From a8cd7066f0422f378902770034ddac1720d0e032 Mon Sep 17 00:00:00 2001
From: Kamil Lulko <kamilx.lulko@intel.com>
Date: Thu, 13 Jun 2019 21:04:36 +0200
Subject: [PATCH] ASoC: Intel: Skylake: Strip T and L from TLV IPCs

cAVS modules do not require Type and Length header within the
set_module_params IPC. This is also true for Vendor modules. The
userspace (like tinymix) always appends this header to TLV controls
which are used for set_module_params. Simply assume this header is
always present in the payload and omit it from the IPC.

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 99825dda34af..c353eb14ce36 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1492,22 +1492,18 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 	struct skl *skl = get_skl_ctx(w->dapm->dev);
 
 	if (ac->params) {
+		/*
+		 * Widget data is expected to be stripped of T and L
+		 */
+		size -= 2 * sizeof(unsigned int);
+		data += 2;
+
 		if (size > ac->max)
 			return -EINVAL;
-
 		ac->size = size;
-		/*
-		 * if the param_is is of type Vendor, firmware expects actual
-		 * parameter id and size from the control.
-		 */
-		if (ac->param_id == SKL_PARAM_VENDOR_ID) {
-			if (copy_from_user(ac->params, data, size))
-				return -EFAULT;
-		} else {
-			if (copy_from_user(ac->params,
-					   data + 2, size))
-				return -EFAULT;
-		}
+
+		if (copy_from_user(ac->params, data, size))
+			return -EFAULT;
 
 		if (w->power)
 			return skl_set_module_params(skl->skl_sst,
-- 
2.20.1
