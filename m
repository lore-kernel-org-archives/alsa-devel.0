From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dpcm: Fix dpcm_get_be() to check that
	DAI is BE.
Date: Tue,  5 Jun 2012 19:26:59 +0100
Message-ID: <1338920819-5246-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C54510439A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 20:27:08 +0200 (CEST)
Received: by wejx9 with SMTP id x9so4218301wej.2
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 11:27:05 -0700 (PDT)
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

Make sure that the dpcm_get_be() only returns BE DAI links.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index edb0d0c..1b6f6be 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -830,6 +830,9 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		for (i = 0; i < card->num_links; i++) {
 			be = &card->rtd[i];
 
+			if (!be->dai_link->no_pcm)
+				continue;
+
 			if (be->cpu_dai->playback_widget == widget ||
 				be->codec_dai->playback_widget == widget)
 				return be;
@@ -839,6 +842,9 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		for (i = 0; i < card->num_links; i++) {
 			be = &card->rtd[i];
 
+			if (!be->dai_link->no_pcm)
+				continue;
+
 			if (be->cpu_dai->capture_widget == widget ||
 				be->codec_dai->capture_widget == widget)
 				return be;
-- 
1.7.9.5
