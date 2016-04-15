From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5102: Free compressed IRQ in CODEC
	remove
Date: Fri, 15 Apr 2016 13:11:57 +0100
Message-ID: <1460722317-31486-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1460722317-31486-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 31D5F264F3A
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 14:11:51 +0200 (CEST)
In-Reply-To: <1460722317-31486-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We request one of the DSP IRQs during CODEC probe, as such we should
free it during CODEC remove, this patch does so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 59fd3e8..1bae17e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1955,11 +1955,14 @@ err_adsp2_codec_probe:
 static int wm5102_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 
 	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
 	arizona_free_spk(codec);
 
 	return 0;
-- 
2.1.4
