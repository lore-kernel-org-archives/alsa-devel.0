From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Remove unused DAPM suspend flag
Date: Sun,  9 May 2010 13:08:35 +0100
Message-ID: <1273406918-17007-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C6A2E24593
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:08:43 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

We now manage suspend within the main power analysis rather than by
flipping the state of widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 -
 sound/soc/soc-dapm.c     |   10 ----------
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d5d6ba8..55c6d3d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -427,7 +427,6 @@ struct snd_soc_dapm_widget {
 	unsigned char connected:1;		/* connected codec pin */
 	unsigned char new:1;			/* cnew complete */
 	unsigned char ext:1;			/* has external widgets */
-	unsigned char suspend:1;		/* was active before suspend */
 	unsigned char force:1;			/* force state */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 476dbe6..b30b0a2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2012,18 +2012,8 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
 				w->active = 0;
 				break;
 			case SND_SOC_DAPM_STREAM_SUSPEND:
-				if (w->active)
-					w->suspend = 1;
-				w->active = 0;
-				break;
 			case SND_SOC_DAPM_STREAM_RESUME:
-				if (w->suspend) {
-					w->active = 1;
-					w->suspend = 0;
-				}
-				break;
 			case SND_SOC_DAPM_STREAM_PAUSE_PUSH:
-				break;
 			case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
 				break;
 			}
-- 
1.7.0.5
