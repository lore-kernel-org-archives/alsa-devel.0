From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: core: Change power state before
	rechecking endpoint
Date: Mon, 23 Nov 2015 21:22:31 +0530
Message-ID: <1448293951-32071-4-git-send-email-vinod.koul@intel.com>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 68E2826582D
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:48:50 +0100 (CET)
In-Reply-To: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For DAPM resume, we should first change the power state of the
card and then recheck the endpoints. This ensures the dapm is
resumed first and then userspace can resume the streams.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0a26ac0fb513..6dd704a6b76f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -846,12 +846,12 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	dev_dbg(card->dev, "ASoC: resume work completed\n");
 
-	/* userspace can access us now we are back as we were before */
-	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
-
 	/* Recheck all endpoints too, their state is affected by suspend */
 	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
+
+	/* userspace can access us now we are back as we were before */
+	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
 }
 
 /* powers up audio subsystem after a suspend */
-- 
1.9.1
