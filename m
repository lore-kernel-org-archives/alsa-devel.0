From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: Document snd-soc-dummy-dai purpose
Date: Mon, 31 Aug 2015 08:24:23 -0700
Message-ID: <1441034663-4372-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E4A7260494
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 17:24:28 +0200 (CEST)
Received: by pabpg12 with SMTP id pg12so9993750pab.3
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 08:24:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/soc-utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 362c69a..53dd085 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -101,6 +101,15 @@ static struct snd_soc_codec_driver dummy_codec;
 			SNDRV_PCM_FMTBIT_S32_LE | \
 			SNDRV_PCM_FMTBIT_U32_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
+/*
+ * The dummy CODEC is only meant to be used in situations where there is no
+ * actual hardware.
+ *
+ * If there is actual hardware even if it does not have a control bus
+ * the hardware will still have constraints like supported samplerates, etc.
+ * which should be modelled. And the data flow graph also should be modelled
+ * using DAPM.
+ */
 static struct snd_soc_dai_driver dummy_dai = {
 	.name = "snd-soc-dummy-dai",
 	.playback = {
-- 
2.5.0.457.gab17608
