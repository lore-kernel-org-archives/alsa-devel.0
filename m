From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH] ASoC: dpcm: Make BE prepare possible in
	suspend state
Date: Wed, 28 Oct 2015 10:15:34 +0800
Message-ID: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 79843265680
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 03:16:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, Koro Chen <koro.chen@mediatek.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

During suspend/resume, there is a flow that if a driver does not support
SNDRV_PCM_INFO_RESUME, it will fail at snd_pcm_resume(), and user space
can then issue SNDRV_PCM_IOCTL_PREPARE to let audio continue to play.

However, in dpcm_be_dai_prepare() it only allows BEs to be prepared
in state SND_SOC_DPCM_STATE_HW_PARAMS or SND_SOC_DPCM_STATE_STOP.
The BE state will then stay in SND_SOC_DPCM_STATE_SUSPEND, consequently
dpcm_be_dai_shutdown() is skipped in the end of playback and
be_substream->runtime is not cleared while this runtime is actually freed
by snd_pcm_detach_substream(). If another suspend comes, a NULL pointer
dereference will happen in snd_pcm_suspend() when accessing
BE substream's runtime.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3173958..5c41a58 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2117,7 +2117,8 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-- 
1.7.9.5
