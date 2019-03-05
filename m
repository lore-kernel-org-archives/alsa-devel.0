From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 2/2] ASoC: topology: free link string in error
Date: Tue,  5 Mar 2019 23:57:53 +0800
Message-ID: <20190305155753.10362-2-yung-chuan.liao@linux.intel.com>
References: <20190305155753.10362-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BD53F896CE
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2019 04:57:19 +0100 (CET)
In-Reply-To: <20190305155753.10362-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

Some strings are allocated by kstrdup, but not freed when error
happened.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4e05ef001e04..bb055c001b9c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1881,6 +1881,9 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_link_load(tplg, link, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
+		kfree(link->name);
+		kfree(link->stream_name);
+		kfree(link->cpu_dai_name);
 		kfree(link);
 		return ret;
 	}
-- 
2.17.1
