From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Fix usage of
	SND_SOC_TPLG_INDEX_ALL during load
Date: Thu, 29 Jun 2017 14:22:25 +0100
Message-ID: <1498742546-23463-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D91B26736D
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 15:22:57 +0200 (CEST)
In-Reply-To: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

SND_SOC_TPLG_INDEX_ALL is used by drivers to tell the core to load
all topology component indexes, not just the index in the header.
Fix this so that SND_SOC_TPLG_INDEX_ALL will load all components no matter
their index.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 10797d74a700..06fb7c4c664a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2389,7 +2389,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 
 	/* check for matching ID */
 	if (hdr->index != tplg->req_index &&
-		hdr->index != SND_SOC_TPLG_INDEX_ALL)
+		tplg->req_index != SND_SOC_TPLG_INDEX_ALL)
 		return 0;
 
 	tplg->index = hdr->index;
-- 
2.11.0
