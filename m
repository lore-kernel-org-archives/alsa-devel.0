From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Remove unused "n_widgets" field from
	snd_soc_dapm struct
Date: Fri,  8 Mar 2013 13:44:27 +0100
Message-ID: <1362746667-8919-2-git-send-email-lars@metafoo.de>
References: <1362746667-8919-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-057.synserver.de (smtp-out-064.synserver.de
 [212.40.185.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B125261724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 13:42:43 +0100 (CET)
In-Reply-To: <1362746667-8919-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 497098be ("ASoC: dapm: Remove bodges for no-widget CODECs") removed the
last user of the n_widgets field. Currently it is incremented for each widget
added, but the value is never used, so we can remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 1 -
 sound/soc/soc-dapm.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 44a30b1..d460902 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -566,7 +566,6 @@ struct snd_soc_dapm_update {
 
 /* DAPM context */
 struct snd_soc_dapm_context {
-	int n_widgets; /* number of widgets in this context */
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ee94032..eaf9b74 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3138,7 +3138,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	}
 
-	dapm->n_widgets++;
 	w->dapm = dapm;
 	w->codec = dapm->codec;
 	w->platform = dapm->platform;
-- 
1.8.0
