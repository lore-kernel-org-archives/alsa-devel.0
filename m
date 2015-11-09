From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: core: Pass kcontrol to bytes tlv
	callbacks
Date: Mon,  9 Nov 2015 23:20:00 +0530
Message-ID: <1447091401-24298-4-git-send-email-vinod.koul@intel.com>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EF752616F3
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 18:46:42 +0100 (CET)
In-Reply-To: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Mythri P K <mythri.p.k@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mythri P K <mythri.p.k@intel.com>

Add kcontrol to the tlv callbacks in soc_bytes_ext, as it is
needed for referencing the corresponding control in the driver
code

Also fix the only upstream user in topology core

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
index e93927789d98..e09673dbae1b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1228,8 +1228,10 @@ struct soc_bytes_ext {
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
1.9.1
