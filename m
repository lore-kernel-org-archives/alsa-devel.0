From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 3/3] ASoC: mt6797-mt6351: add hostless phone
	call path
Date: Thu, 31 May 2018 09:26:21 +0800
Message-ID: <1527729981-4802-3-git-send-email-kaichieh.chuang@mediatek.com>
References: <1527729981-4802-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 307A226781D
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 03:26:29 +0200 (CEST)
In-Reply-To: <1527729981-4802-1-git-send-email-kaichieh.chuang@mediatek.com>
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
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index 9e5866d..b1558c5 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -89,6 +89,32 @@
 		.dynamic = 1,
 		.dpcm_capture = 1,
 	},
+	{
+		.name = "Hostless_LPBK",
+		.stream_name = "Hostless_LPBK",
+		.cpu_dai_name = "Hostless LPBK DAI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+	{
+		.name = "Hostless_Speech",
+		.stream_name = "Hostless_Speech",
+		.cpu_dai_name = "Hostless Speech DAI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
 	/* BE */
 	{
 		.name = "Primary Codec",
@@ -99,6 +125,26 @@
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
 	},
+	{
+		.name = "PCM 1",
+		.cpu_dai_name = "PCM 1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+	{
+		.name = "PCM 2",
+		.cpu_dai_name = "PCM 2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
 };
 
 static struct snd_soc_card mt6797_mt6351_card = {
-- 
1.9.1
