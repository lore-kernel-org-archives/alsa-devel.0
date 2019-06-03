From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 9/9] ASoC: SOF: topology: add support for
	mux/demux component
Date: Mon,  3 Jun 2019 11:18:21 -0500
Message-ID: <20190603161821.7486-10-pierre-louis.bossart@linux.intel.com>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61DEDF80CC4
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:37 +0200 (CEST)
In-Reply-To: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Jaska Uimonen <jaska.uimonen@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaska Uimonen <jaska.uimonen@intel.com>

Add enumerations to support mux/demux processing component.

Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/topology.h | 3 +++
 sound/soc/sof/topology.c     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 4afed7f1c6b2..41dcabf89899 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -35,6 +35,7 @@ enum sof_comp_type {
 	SOF_COMP_KEYWORD_DETECT,
 	SOF_COMP_KPB,			/* A key phrase buffer component */
 	SOF_COMP_SELECTOR,		/**< channel selector component */
+	SOF_COMP_DEMUX,
 	/* keep FILEREAD/FILEWRITE as the last ones */
 	SOF_COMP_FILEREAD = 10000,	/**< host test based file IO */
 	SOF_COMP_FILEWRITE = 10001,	/**< host test based file IO */
@@ -175,6 +176,8 @@ enum sof_ipc_process_type {
 	SOF_PROCESS_KEYWORD_DETECT,	/**< Keyword Detection */
 	SOF_PROCESS_KPB,		/**< KeyPhrase Buffer Manager */
 	SOF_PROCESS_CHAN_SELECTOR,	/**< Channel Selector */
+	SOF_PROCESS_MUX,
+	SOF_PROCESS_DEMUX,
 };
 
 /* generic "effect", "codec" or proprietary processing component */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 745cb875863c..b969686f954f 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -394,6 +394,8 @@ static const struct sof_process_types sof_process[] = {
 	{"KEYWORD_DETECT", SOF_PROCESS_KEYWORD_DETECT, SOF_COMP_KEYWORD_DETECT},
 	{"KPB", SOF_PROCESS_KPB, SOF_COMP_KPB},
 	{"CHAN_SELECTOR", SOF_PROCESS_CHAN_SELECTOR, SOF_COMP_SELECTOR},
+	{"MUX", SOF_PROCESS_MUX, SOF_COMP_MUX},
+	{"DEMUX", SOF_PROCESS_DEMUX, SOF_COMP_DEMUX},
 };
 
 static enum sof_ipc_process_type find_process(const char *name)
-- 
2.20.1
