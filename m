From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: topology: fix big-endian check
Date: Thu,  4 Apr 2019 14:13:58 -0500
Message-ID: <20190404191358.4235-3-pierre-louis.bossart@linux.intel.com>
References: <20190404191358.4235-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 627C9F8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 21:14:13 +0200 (CEST)
In-Reply-To: <20190404191358.4235-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use an explicit define to avoid Sparse issues coming from the use of
cpu_to_be32

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 03c4dbdfc584..51903ca7614b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -30,6 +30,8 @@
 #include <sound/soc-topology.h>
 #include <sound/tlv.h>
 
+#define SOC_TPLG_MAGIC_BIG_ENDIAN            0x436F5341 /* ASoC in reverse */
+
 /*
  * We make several passes over the data (since it wont necessarily be ordered)
  * and process objects in the following order. This guarantees the component
@@ -2502,7 +2504,7 @@ static int soc_valid_header(struct soc_tplg *tplg,
 	}
 
 	/* big endian firmware objects not supported atm */
-	if (hdr->magic == cpu_to_be32(SND_SOC_TPLG_MAGIC)) {
+	if (hdr->magic == SOC_TPLG_MAGIC_BIG_ENDIAN) {
 		dev_err(tplg->dev,
 			"ASoC: pass %d big endian not supported header got %x at offset 0x%lx size 0x%zx.\n",
 			tplg->pass, hdr->magic,
-- 
2.17.1
