From: <twischer@de.adit-jv.com>
Subject: [PATCH - DMA engine v2 1/1] ALSA: SOC: DMA: increment
	buffer pointer atomically
Date: Thu, 19 Jul 2018 12:29:00 +0200
Message-ID: <1531996140-19880-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>, Jiada Wang <jiada_wang@mentor.com>, Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Setting pointer and afterwards check for wrap around leads
to the possibility of returning the inconsistent pointer position.
This patch increments buffer pointer atomically to avoid this issue.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Since commit: b7ae6f3 dmaengine implementation has been moved
from ASoC to ALSA core. So change goes to sound/soc/soc-dmaengine-pcm.c,
apply to sound/core/pcm_dmaengine.c now

cherry picked from ADIT v3.14 e2f803f("ALSA: SOC: DMA: increment buffer pointer atomically")
Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
(cherry picked from ADIT v4.1 commit 9e7eff10a38157db75f12e032fc378d3104a2812)
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
(cherry picked from ADIT v4.9 commit 66c00aa1e7cd3b077fc2e5a45a4594b86246cf78)
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---

v1 can be found in
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115277.html

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 8eb58c7..0a7ed85 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -139,12 +139,14 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
 static void dmaengine_pcm_dma_complete(void *arg)
 {
+	unsigned int new_pos;
 	struct snd_pcm_substream *substream = arg;
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
 
-	prtd->pos += snd_pcm_lib_period_bytes(substream);
-	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
-		prtd->pos = 0;
+	new_pos = READ_ONCE(prtd->pos) + snd_pcm_lib_period_bytes(substream);
+	if (new_pos >= snd_pcm_lib_buffer_bytes(substream))
+		new_pos = 0;
+	WRITE_ONCE(prtd->pos, new_pos);
 
 	snd_pcm_period_elapsed(substream);
 }
@@ -235,7 +237,7 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
 snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
-	return bytes_to_frames(substream->runtime, prtd->pos);
+	return bytes_to_frames(substream->runtime, READ_ONCE(prtd->pos));
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
 
-- 
2.7.4
