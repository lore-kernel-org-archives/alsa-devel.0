From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Fix to parse
	consecutive string tkns in manifest
Date: Mon, 15 May 2017 19:44:30 +0530
Message-ID: <1494857671-19257-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8872426743C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 16:28:38 +0200 (CEST)
In-Reply-To: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Element size in the manifest should be updated for each token, so that the
loop can parse all the string elements in the manifest. This was not
happening when more than two string elements appear consecutively, as it is
not updated with correct string element size. Fixed with this patch.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b28199a5348c..43ca39d61559 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2502,7 +2502,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 
 			if (ret < 0)
 				return ret;
-			tkn_count += ret;
+			tkn_count = ret;
 
 			tuple_size += tkn_count *
 				sizeof(struct snd_soc_tplg_vendor_string_elem);
-- 
1.9.1
