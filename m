From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Mark headphone, mic,
	speaker and line widgets as always connected
Date: Mon,  3 Oct 2011 22:43:30 +0100
Message-ID: <1317678210-30634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DCED103940
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 23:43:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're not actually doing any dynamic power management based on connection
and output drivers (which are pretty much the same thing) are marked as
unconditionally connected already.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e0d9971..214a709 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -329,7 +329,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		}
 	}
 	break;
-	/* does not effect routing - always connected */
+	/* does not affect routing - always connected */
 	case snd_soc_dapm_pga:
 	case snd_soc_dapm_out_drv:
 	case snd_soc_dapm_output:
@@ -341,13 +341,13 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-		p->connect = 1;
-	break;
-	/* does effect routing - dynamically connected */
 	case snd_soc_dapm_hp:
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_spk:
 	case snd_soc_dapm_line:
+		p->connect = 1;
+	break;
+	/* does affect routing - dynamically connected */
 	case snd_soc_dapm_pre:
 	case snd_soc_dapm_post:
 		p->connect = 0;
-- 
1.7.6.3
