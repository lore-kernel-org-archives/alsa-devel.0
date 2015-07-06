From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH] ASoC: dpcm: Add checks of playback/capture
	before dpcm_get_be
Date: Mon, 6 Jul 2015 10:02:10 +0800
Message-ID: <1436148130-22739-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 845F42604EB
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 04:03:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, Koro Chen <koro.chen@mediatek.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

In dpcm_get_be(), it looks for a BE rtd that has the DAI widget
according to current stream type. Only playback_widgets are searched
in the case of playback stream and vice versa. However, the DAI widget
itself can be playback or capture.

If the DAI widget is capture, but current stream type is playback,
dpcm_get_be() will always fail to find a rtd, print error messages,
and continue to the next DAI widget in list. We can just skip this
DAI widget to further suppress error messages. This happens in a
special case when 2 codecs are inter-connected, and the 1st codec's
"capture" widget is used to send data to the 2nd codec during "playback":

mtk-rt5650-rt5676 sound: ASoC: can't get playback BE for Sub AIF2 Capture
rt5650_rt5676 Playback: ASoC: no BE found for Sub AIF2 Capture

Add checks to continue to next DAI widget if current DAI widget's
direction does not match the stream type.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 256b9c9..a6d3313 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1306,7 +1306,12 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 
 		switch (list->widgets[i]->id) {
 		case snd_soc_dapm_dai_in:
+			if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+				continue;
+			break;
 		case snd_soc_dapm_dai_out:
+			if (stream != SNDRV_PCM_STREAM_CAPTURE)
+				continue;
 			break;
 		default:
 			continue;
-- 
1.8.1.1.dirty
