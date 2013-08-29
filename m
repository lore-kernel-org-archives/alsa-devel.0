From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] ASoC: soc-pcm: Allow to specify
	unidirectional dai_link
Date: Thu, 29 Aug 2013 10:32:13 -0300
Message-ID: <1377783134-23528-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id CD6372654E4
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 15:32:36 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Add 'playback_only' and 'capture_only' fields that can be used for specifying
that a dai_link has a unidirectional capability.

The motivation for this is for the cases of systems, such as Freescale MX28,
that has two unidirectional DAIs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/sound/soc.h |  4 ++++
 sound/soc/soc-pcm.c | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e2ad52..774d3be 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -934,6 +934,10 @@ struct snd_soc_dai_link {
 	/* machine stream operations */
 	const struct snd_soc_ops *ops;
 	const struct snd_soc_compr_ops *compr_ops;
+
+	/* For unidirectional dai links */
+	bool playback_only;
+	bool capture_only;
 };
 
 struct snd_soc_codec_conf {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fb70fbe..5e44863 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2020,6 +2020,16 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			capture = 1;
 	}
 
+	if (rtd->dai_link->playback_only) {
+		playback = 1;
+		capture = 0;
+	}
+
+	if (rtd->dai_link->capture_only) {
+		playback = 0;
+		capture = 1;
+	}
+
 	/* create the PCM */
 	if (rtd->dai_link->no_pcm) {
 		snprintf(new_name, sizeof(new_name), "(%s)",
-- 
1.8.1.2
