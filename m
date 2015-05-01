From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3 2/5] ASoC: dapm: Remove local OOM error
	message
Date: Fri,  1 May 2015 12:37:24 +0100
Message-ID: <1430480247-28753-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C25A72617C6
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 13:45:32 +0200 (CEST)
In-Reply-To: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The memory subsystem is pretty chatty on failure no need to have local
OOM messages as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 79b9478..beb48b6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -310,12 +310,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 	struct soc_mixer_control *mc;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(widget->dapm->dev,
-				"ASoC: can't allocate kcontrol data for %s\n",
-				widget->name);
+	if (!data)
 		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&data->paths);
 
-- 
1.7.2.5
