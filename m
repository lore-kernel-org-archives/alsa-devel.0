From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 07/13] ASoC: soc_bind_dai_link() directly
	returns success for a bound DAI link
Date: Thu,  5 Nov 2015 17:59:19 +0800
Message-ID: <9cb8b4b46674b6688c92bf9c22f0cd9db1b86dff.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A22E265D33
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:43:53 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This function will return success immediately for a bound DAI link.
No need to look for the cpu/codec DAIs again.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24e0c50..86c3219 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -960,6 +960,19 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	return NULL;
 }
 
+static bool soc_is_dai_link_bound(struct snd_soc_card *card,
+		struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->dai_link == dai_link)
+			return true;
+	}
+
+	return false;
+}
+
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -977,6 +990,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	if (!rtd)
 		return -ENOMEM;
 
+	if (soc_is_dai_link_bound(card, dai_link)) {
+		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
+			dai_link->name);
+		return 0;
+	}
+
 	cpu_dai_component.name = dai_link->cpu_name;
 	cpu_dai_component.of_node = dai_link->cpu_of_node;
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-- 
1.9.1
