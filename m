From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] ASoC: pcm512x: Fix DSP program selection
Date: Thu,  8 Jan 2015 22:56:30 +0100
Message-ID: <1420754190-6309-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

The DSP programs are listed out of order.

Signed-off-by: Peter Rosin <peda@axentia.se>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/pcm512x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 0c8aefab404c..640c99198cda 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -188,8 +188,8 @@ static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 80, 0);
 static const char * const pcm512x_dsp_program_texts[] = {
 	"FIR interpolation with de-emphasis",
 	"Low latency IIR with de-emphasis",
-	"Fixed process flow",
 	"High attenuation with de-emphasis",
+	"Fixed process flow",
 	"Ringing-less low latency FIR",
 };
 
-- 
1.7.10.4
