From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dpcm: Allow FE to be opened without
	valid BE routes.
Date: Fri,  6 Jul 2012 17:07:00 +0100
Message-ID: <1341590820-21040-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog127.obsmtp.com (na3sys009aog127.obsmtp.com
	[74.125.149.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F86610458B
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 18:07:59 +0200 (CEST)
Received: by werc12 with SMTP id c12so2821058wer.35
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 09:07:08 -0700 (PDT)
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

Some userspace will open a PCM device and then configure mixers
for routing before triggering. This patch allows userspace to do
this sequence.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7063b8f..ef22d0b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1955,10 +1955,8 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	if (dpcm_path_get(fe, stream, &list) <= 0) {
-		dev_warn(fe->dev, "asoc: %s no valid %s route\n",
+		dev_dbg(fe->dev, "asoc: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
-			mutex_unlock(&fe->card->mutex);
-			return -EINVAL;
 	}
 
 	/* calculate valid and active FE <-> BE dpcms */
-- 
1.7.9.5
