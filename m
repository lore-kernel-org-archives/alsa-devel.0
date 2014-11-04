From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/6] ASoC: Intel: mrfld - remove unnecessary
	check for pointer
Date: Tue,  4 Nov 2014 16:25:15 +0530
Message-ID: <1415098520-14113-2-git-send-email-vinod.koul@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B82972608BC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:55:18 +0100 (CET)
In-Reply-To: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

the 'platform' pointer in sst_map_modules_to_pipe() is deref in caller
function so we need to check for it in this function

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-atom-controls.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index 309a8f3..90aa5c0 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -1351,7 +1351,7 @@ static int sst_map_modules_to_pipe(struct snd_soc_platform *platform)
 	int ret = 0;
 
 	list_for_each_entry(w, &platform->component.card->widgets, list) {
-		if (platform && is_sst_dapm_widget(w) && (w->priv)) {
+		if (is_sst_dapm_widget(w) && (w->priv)) {
 			struct sst_ids *ids = w->priv;
 
 			dev_dbg(platform->dev, "widget type=%d name=%s\n",
-- 
1.7.0.4
