From: mengdong.lin@intel.com
Subject: [PATCH v2 7/8] ASoC: topology: ABI - Add configuration
	for BE & Codec-Codec DAI Links
Date: Wed, 30 Sep 2015 17:32:22 +0800
Message-ID: <5a1fe81777b8416e5acc3a854aa88d8c09ab6ce3.1443605139.git.mengdong.lin@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B4FCC265B51
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:17:53 +0200 (CEST)
In-Reply-To: <cover.1443605139.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

struct snd_soc_tplg_link_config is defined to configure BE & CC links.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f75fd29..538ea13 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -395,4 +395,21 @@ struct snd_soc_tplg_pcm {
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 } __attribute__((packed));
 
+
+/*
+ * Describes the BE or CC link runtime supported configs or params
+ *
+ * File block representation for BE/CC link config :-
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_hdr           |  1  |
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_link_config   |  N  |
+ * +-----------------------------------+-----+
+ */
+struct snd_soc_tplg_link_config {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __attribute__((packed));
 #endif
-- 
1.9.1
