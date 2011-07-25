From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - change stream event dbg to vdgb
Date: Mon, 25 Jul 2011 11:15:50 +0100
Message-ID: <1311588950-3476-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 902E3103851
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 12:15:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Stream event debug can be noisy on larger audio devices so improve the
debug SNR by changing it to the verbose level.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 120df5b..3956670 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2710,7 +2710,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	{
 		if (!w->sname || w->dapm != dapm)
 			continue;
-		dev_dbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
+		dev_vdbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
 			w->name, w->sname, stream, event);
 		if (strstr(w->sname, stream)) {
 			switch(event) {
-- 
1.7.4.1
