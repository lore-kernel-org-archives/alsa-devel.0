From: cezary.rojewski@intel.com
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Strip T and L from
	TLV IPCs
Date: Thu, 13 Jun 2019 21:04:36 +0200
Message-ID: <20190613190436.20156-8-cezary.rojewski@intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FEBDF89711
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:36 +0200 (CEST)
In-Reply-To: <20190613190436.20156-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: pierre-louis.bossart@linux.intel.com, Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org, Kamil Lulko <kamilx.lulko@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kamil Lulko <kamilx.lulko@intel.com>

cAVS modules do not require Type and Length header within the
set_module_params IPC. This is also true for Vendor modules. The
userspace (like tinymix) always appends this header to TLV controls
which are used for set_module_params. Simply assume this header is
always present in the payload and omit it from the IPC.

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c69d999d7bf1..76e971b8536a 100644
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
2.17.1
