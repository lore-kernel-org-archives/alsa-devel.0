From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/14] ASoC: spear_pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 14:12:02 +0100
Message-ID: <1363957934-20059-3-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F066266529
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:30 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

If a PCM driver using the dmaengine PCM helper functions doesn't need to do
anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
directly for as the pcm_close callback and there is no need to wrap it in a
custom function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/spear_pcm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index dd71167..903ac15 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -73,14 +73,6 @@ static int spear_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int spear_pcm_close(struct snd_pcm_substream *substream)
-{
-
-	snd_dmaengine_pcm_close(substream);
-
-	return 0;
-}
-
 static int spear_pcm_mmap(struct snd_pcm_substream *substream,
 		struct vm_area_struct *vma)
 {
@@ -93,7 +85,7 @@ static int spear_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops spear_pcm_ops = {
 	.open		= spear_pcm_open,
-	.close		= spear_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= spear_pcm_hw_params,
 	.hw_free	= spear_pcm_hw_free,
-- 
1.8.0
