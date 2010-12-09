From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: Remove unnecessary structure definitions
Date: Thu,  9 Dec 2010 13:17:39 +0900
Message-ID: <1291868259-15059-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE341037EC
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 05:34:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch removes some legacy structure definitions which are not using
in current ASoC drivers.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 include/sound/soc.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c3bce8..6458c71 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -222,10 +222,8 @@ enum snd_soc_bias_level {
 
 struct snd_jack;
 struct snd_soc_card;
-struct snd_soc_device;
 struct snd_soc_pcm_stream;
 struct snd_soc_ops;
-struct snd_soc_dai_mode;
 struct snd_soc_pcm_runtime;
 struct snd_soc_dai;
 struct snd_soc_dai_driver;
@@ -235,7 +233,6 @@ struct snd_soc_platform_driver;
 struct snd_soc_codec;
 struct snd_soc_codec_driver;
 struct soc_enum;
-struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
 
-- 
1.6.2.5
