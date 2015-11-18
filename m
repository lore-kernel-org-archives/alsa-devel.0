From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Pass kcontrol to bytes tlv
	callbacks" to the asoc tree
Date: Wed, 18 Nov 2015 13:13:54 +0000
Message-ID: <E1Zz2Yc-0006LI-Ce@debutante>
References: <1447091401-24298-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0790F265756
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:14:03 +0100 (CET)
In-Reply-To: <1447091401-24298-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mythri P K <mythri.p.k@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Pass kcontrol to bytes tlv callbacks

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

>From a1e5e7e9b36f360bf75e4f0f7ceb899682f213bd Mon Sep 17 00:00:00 2001
From: Mythri P K <mythri.p.k@intel.com>
Date: Mon, 9 Nov 2015 23:20:00 +0530
Subject: [PATCH] ASoC: core: Pass kcontrol to bytes tlv callbacks

Add kcontrol to the tlv callbacks in soc_bytes_ext, as it is
needed for referencing the corresponding control in the driver
code

Also fix the only upstream user in topology core

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h | 6 ++++--
 include/sound/soc.h          | 6 ++++--
 sound/soc/soc-ops.c          | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 086cd7ff6ddc..5b68e3f5aa85 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -92,8 +92,10 @@ struct snd_soc_tplg_kcontrol_ops {
 /* Bytes ext operations, for TLV byte controls */
 struct snd_soc_tplg_bytes_ext_ops {
 	u32 id;
-	int (*get)(unsigned int __user *bytes, unsigned int size);
-	int (*put)(const unsigned int __user *bytes, unsigned int size);
+	int (*get)(struct snd_kcontrol *kcontrol, unsigned int __user *bytes,
+							unsigned int size);
+	int (*put)(struct snd_kcontrol *kcontrol,
+			const unsigned int __user *bytes, unsigned int size);
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8b4b9c8b1d2..6603155f50ca 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1225,8 +1225,10 @@ struct soc_bytes_ext {
 	struct snd_soc_dobj dobj;
 
 	/* used for TLV byte control */
-	int (*get)(unsigned int __user *bytes, unsigned int size);
-	int (*put)(const unsigned int __user *bytes, unsigned int size);
+	int (*get)(struct snd_kcontrol *kcontrol, unsigned int __user *bytes,
+			unsigned int size);
+	int (*put)(struct snd_kcontrol *kcontrol, const unsigned int __user *bytes,
+			unsigned int size);
 };
 
 /* multi register control */
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index ecd38e52285a..ba3e49010ac3 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -779,11 +779,11 @@ int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
 	switch (op_flag) {
 	case SNDRV_CTL_TLV_OP_READ:
 		if (params->get)
-			ret = params->get(tlv, count);
+			ret = params->get(kcontrol, tlv, count);
 		break;
 	case SNDRV_CTL_TLV_OP_WRITE:
 		if (params->put)
-			ret = params->put(tlv, count);
+			ret = params->put(kcontrol, tlv, count);
 		break;
 	}
 	return ret;
-- 
2.6.2
