From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/17] ASoC: pcm512x: Replace usage deprecated
	SOC_VALUE_ENUM macro
Date: Mon, 14 Apr 2014 21:31:01 +0200
Message-ID: <1397503872-20864-7-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D1A2656B3
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:23 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SOC_VALUE_ENUM is deprecated and merely an alias for SOC_ENUM. Replace the
deprecated macro so we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/pcm512x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4b4c0c7..381d22c 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -269,7 +269,7 @@ SOC_DOUBLE("Playback Digital Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
 	   PCM512x_RQMR_SHIFT, 1, 1),
 
 SOC_SINGLE("Deemphasis Switch", PCM512x_DSP, PCM512x_DEMP_SHIFT, 1, 1),
-SOC_VALUE_ENUM("DSP Program", pcm512x_dsp_program),
+SOC_ENUM("DSP Program", pcm512x_dsp_program),
 
 SOC_ENUM("Clock Missing Period", pcm512x_clk_missing),
 SOC_ENUM("Auto Mute Time Left", pcm512x_autom_l),
-- 
1.8.0
