From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/7] ASoC: topology: fix memory leak in
	soc_tplg_dapm_widget_create
Date: Fri, 25 Jan 2019 14:06:45 -0600
Message-ID: <20190125200648.12470-5-pierre-louis.bossart@linux.intel.com>
References: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DE2D1267495
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:06:59 +0100 (CET)
In-Reply-To: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

template.sname and template.name are only freed when an error occur.
They should be freed in the success return case, too.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 71bc5b8a9bd3..2cb0a05e2368 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1583,6 +1583,9 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	if (ret < 0)
 		goto ready_err;
 
+	kfree(template.sname);
+	kfree(template.name);
+
 	return 0;
 
 ready_err:
-- 
2.17.1
