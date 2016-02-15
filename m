From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: [RFC 1/4] ASoc: Use ref_count for soc DAI & component
Date: Mon, 15 Feb 2016 17:49:29 +0530
Message-ID: <1455538772-24926-2-git-send-email-vaibhav.agarwal@linaro.org>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 117022612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:19:45 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id yy13so85274428pab.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 04:19:44 -0800 (PST)
In-Reply-To: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
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
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This is preperation to allow dynamic DAI link insertion &
removal.

Currently, DAI links are added/removed once during soc-card
instatiate & removal. Thus, irrespective of usage count by multiple
DAI links, DAIs and components are probed or removed only once
while maintaining 'probed' flag.
However, in case of dynamic DAI link insertion/removal we need to
ensure DAI/components are not unnecessarily probed multiple & not
removed mistakenly while in use by any other existing DAI link.
Thus, ref_count is used to maintain their usage count.

Signed-off-by: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
---
 include/sound/soc-dai.h |  1 +
 include/sound/soc.h     |  2 ++
 sound/soc/soc-core.c    | 47 ++++++++++++++++++++++++++++++-----------------
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..03c2c7a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -270,6 +270,7 @@ struct snd_soc_dai {
 	unsigned int symmetric_samplebits:1;
 	unsigned int active;
 	unsigned char probed:1;
+	int ref_count;
 
 	struct snd_soc_dapm_widget *playback_widget;
 	struct snd_soc_dapm_widget *capture_widget;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7afb72c..3dda0c4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -822,6 +822,8 @@ struct snd_soc_component {
 	struct dentry *debugfs_root;
 #endif
 
+	int ref_count;
+
 	/*
 	* DO NOT use any of the fields below in drivers, they are temporary and
 	* are going to be removed again soon. If you use them in driver code the
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 790ee2b..2b83814 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1060,6 +1060,11 @@ static void soc_remove_component(struct snd_soc_component *component)
 	if (!component->card)
 		return;
 
+	component->ref_count--;
+
+	if (component->ref_count)
+		return;
+
 	/* This is a HACK and will be removed soon */
 	if (component->codec)
 		list_del(&component->codec->card_list);
@@ -1080,14 +1085,17 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 
 	if (dai && dai->probed &&
 			dai->driver->remove_order == order) {
-		if (dai->driver->remove) {
-			err = dai->driver->remove(dai);
-			if (err < 0)
-				dev_err(dai->dev,
-					"ASoC: failed to remove %s: %d\n",
-					dai->name, err);
+		dai->ref_count--;
+		if (!dai->ref_count) {
+			if (dai->driver->remove) {
+				err = dai->driver->remove(dai);
+				if (err < 0)
+					dev_err(dai->dev,
+						"ASoC: failed to remove %s: %d\n",
+						dai->name, err);
+			}
+			dai->probed = 0;
 		}
-		dai->probed = 0;
 	}
 }
 
@@ -1367,6 +1375,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 				card->name, component->card->name);
 			return -ENODEV;
 		}
+		component->ref_count++;
 		return 0;
 	}
 
@@ -1436,6 +1445,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 	if (component->codec)
 		list_add(&component->codec->card_list, &card->codec_dev_list);
 
+	component->ref_count++;
 	return 0;
 
 err_probe:
@@ -1523,18 +1533,21 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 {
 	int ret;
 
-	if (!dai->probed && dai->driver->probe_order == order) {
-		if (dai->driver->probe) {
-			ret = dai->driver->probe(dai);
-			if (ret < 0) {
-				dev_err(dai->dev,
-					"ASoC: failed to probe DAI %s: %d\n",
-					dai->name, ret);
-				return ret;
+	if (dai->driver->probe_order == order) {
+		if (!dai->probed) {
+			if (dai->driver->probe) {
+				ret = dai->driver->probe(dai);
+				if (ret < 0) {
+					dev_err(dai->dev,
+						"ASoC: failed to probe DAI %s: %d\n",
+						dai->name, ret);
+					return ret;
+				}
 			}
-		}
 
-		dai->probed = 1;
+			dai->probed = 1;
+		}
+		dai->ref_count++;
 	}
 
 	return 0;
-- 
2.1.4
