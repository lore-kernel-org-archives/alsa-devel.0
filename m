From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 6/9] ASoC: Add helper to find codec_dai from
	dai_name
Date: Thu, 12 Oct 2017 18:38:02 -0500
Message-ID: <20171012233805.30055-7-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F262266F35
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:19 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Create a helper function to remove duplicate code used in machine drivers

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index eea3007a28f1..99d4861ad34f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1743,6 +1743,20 @@ struct snd_soc_dai *snd_soc_find_dai(
 
 #include <sound/soc-dai.h>
 
+static inline
+struct snd_soc_dai *snd_soc_card_get_codec_dai(struct snd_soc_card *card,
+					       const char *dai_name)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (!strcmp(rtd->codec_dai->name, dai_name))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *snd_soc_debugfs_root;
 #endif
-- 
2.11.0
