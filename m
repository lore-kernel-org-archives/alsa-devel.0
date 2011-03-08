From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use the correct DAPM context when
	cleaning up final widget set
Date: Tue,  8 Mar 2011 19:31:28 +0000
Message-ID: <1299612689-770-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25B3D1038FC
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 20:31:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now we've got multi-component we need to make sure that the DAPM context
(and hence register I/O context) we use to apply the pending updates at
the end of a DAPM sequence is the one we were processing rather than the
one that was used to initate the state change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a6fb85d..c5335da 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -984,7 +984,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (!list_empty(&pending))
-		dapm_seq_run_coalesced(dapm, &pending);
+		dapm_seq_run_coalesced(cur_dapm, &pending);
 
 	if (cur_dapm && cur_dapm->seq_notifier) {
 		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
-- 
1.7.2.3
