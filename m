From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH 2/2] ASoC: mmp-pcm: add NO_PERIOD_WAKEUP for
	PCM INFO
Date: Wed, 10 Sep 2014 16:40:49 +0800
Message-ID: <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F4F1265055
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 10:40:54 +0200 (CEST)
In-Reply-To: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dan.j.williams@intel.com, vinod.koul@intel.com, dmaengine@vger.kernel.org, zhangfei.gao@gmail.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux@arm.linux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

add NO_PERIOD_WAKEUP to PCM INFO, which supports audio no IRQ mode

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/pxa/mmp-pcm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 5e8d813..64e8b94 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -34,7 +34,8 @@ struct mmp_dma_data {
 		SNDRV_PCM_INFO_MMAP_VALID |	\
 		SNDRV_PCM_INFO_INTERLEAVED |	\
 		SNDRV_PCM_INFO_PAUSE |		\
-		SNDRV_PCM_INFO_RESUME)
+		SNDRV_PCM_INFO_RESUME |		\
+		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP)
 
 static struct snd_pcm_hardware mmp_pcm_hardware[] = {
 	{
-- 
1.7.0.4
