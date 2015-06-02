From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: core: Pass kcontrol pointer to bytes tlv callbacks
Date: Tue,  2 Jun 2015 15:24:03 -0700
Message-ID: <1433283843-33856-1-git-send-email-benzh@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Dylan Reid <dgreid@chromium.org>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The get/put callbacks need the kcontrol pointer to get context
information like snd_soc_codec and drvdata.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 include/sound/soc.h | 6 ++++--
 sound/soc/soc-ops.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fcb312b..404265d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1169,8 +1169,10 @@ struct soc_bytes {
 struct soc_bytes_ext {
 	int max;
 	/* used for TLV byte control */
-	int (*get)(unsigned int __user *bytes, unsigned int size);
-	int (*put)(const unsigned int __user *bytes, unsigned int size);
+	int (*get)(struct snd_kcontrol *kcontrol,
+		   unsigned int __user *bytes, unsigned int size);
+	int (*put)(struct snd_kcontrol *kcontrol,
+		   const unsigned int __user *bytes, unsigned int size);
 };
 
 /* multi register control */
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 100d92b..7f53da9 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -751,11 +751,11 @@ int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
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
2.2.0.rc0.207.ga3a616c
