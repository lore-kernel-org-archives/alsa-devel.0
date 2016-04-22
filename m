From: mengdong.lin@linux.intel.com
Subject: [PATCH] ASoC: Add kerneldoc comments for
	snd_soc_find_dai
Date: Fri, 22 Apr 2016 12:25:33 +0800
Message-ID: <1461299133-1535-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C622625EE
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 06:22:46 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

snd_soc_find_dai() has been exported and so add the kerneldoc comments
for it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 07663de..16369ca 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -930,6 +930,17 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
+/**
+ * snd_soc_find_dai - Find a registered DAI
+ *
+ * @dlc: name of the DAI and optional component info to match
+ *
+ * This function will search all regsitered components and their DAIs to
+ * find the DAI of the same name. The component's of_node and name
+ * should also match if being specified.
+ *
+ * Return: pointer of DAI, or NULL if not found.
+ */
 struct snd_soc_dai *snd_soc_find_dai(
 	const struct snd_soc_dai_link_component *dlc)
 {
-- 
2.5.0
