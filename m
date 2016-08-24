From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] ASoC: Intel: Skylake: Fix the inverted
	logic check
Date: Wed, 24 Aug 2016 18:03:14 +0530
Message-ID: <1472042001-9582-3-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A99026759D
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:33 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

While converting to new core hda capability parsing, one instance of
check had inverted logic which was converted wrongly.

Fixes: ec8ae5703da1 (ALSA: convert users to core bus_parse_capabilities)
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index eb1f00b28df1..77bfd407f2a1 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1020,7 +1020,7 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 
-	if ((ebus_to_hbus(ebus))->ppcap)
+	if (!(ebus_to_hbus(ebus))->ppcap)
 		return skl_coupled_trigger(substream, cmd);
 
 	return 0;
-- 
1.9.1
