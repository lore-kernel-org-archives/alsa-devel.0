From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: do not close shared backend dailink
Date: Fri, 14 Jul 2017 23:15:05 -0700
Message-ID: <1500099305-16438-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id CE37B2669F3
 for <alsa-devel@alsa-project.org>; Sat, 15 Jul 2017 08:15:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Gopikrishnaiah Anandan <agopik@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Banajit Goswami <bgoswami@codeaurora.org>

Multiple frontend dailinks may be connected to a backend
dailink at the same time. When one of frontend dailinks is
closed, the associated backend dailink should not be closed
if it is connected to other active frontend dailinks. Change
ensures that backend dailink is closed only after all
connected frontend dailinks are closed.

Signed-off-by: Gopikrishnaiah Anandan <agopik@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Patrick Lai <plai@codeaurora.org>
---
 sound/soc/soc-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index efc5831..3d2c69f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -181,6 +181,10 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 		dev_dbg(be->dev, "ASoC: BE %s event %d dir %d\n",
 				be->dai_link->name, event, dir);
 
+		if ((event == SND_SOC_DAPM_STREAM_STOP) &&
+		    (be->dpcm[dir].users >= 1))
+			continue;
+
 		snd_soc_dapm_stream_event(be, dir, event);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
