From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/2] ASoC: topology: Check name strings of
	physical DAI links
Date: Sat,  5 Nov 2016 08:42:14 +0800
Message-ID: <1478306534-23587-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A62D26759C
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 01:40:46 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Check if the name strings are properly terminated, and only use valid
name strings to find existing physical DAI links to configure.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8772fd9..4dfdc65 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1994,10 +1994,24 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 {
 	struct snd_soc_dai_link *link;
 	const char *name, *stream_name;
+	size_t len;
 	int ret;
 
-	name = strlen(cfg->name) ? cfg->name : NULL;
-	stream_name = strlen(cfg->stream_name) ? cfg->stream_name : NULL;
+	len = strnlen(cfg->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (len == SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+		return -EINVAL;
+	else if (len)
+		name = cfg->name;
+	else
+		name = NULL;
+
+	len = strnlen(cfg->stream_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (len == SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+		return -EINVAL;
+	else if (len)
+		stream_name = cfg->stream_name;
+	else
+		stream_name = NULL;
 
 	link = snd_soc_find_dai_link(tplg->comp->card, cfg->id,
 				     name, stream_name);
-- 
2.7.4
