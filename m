From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm512x: Fix duplicate const warning
Date: Fri,  7 Mar 2014 11:44:40 +0800
Message-ID: <1394163880-17876-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FFC26593D
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 04:46:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm512x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 3a0bbb6..a035ba8 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -203,10 +203,10 @@ static const unsigned int pcm512x_dsp_program_values[] = {
 	7,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(pcm512x_dsp_program,
-					PCM512x_DSP_PROGRAM, 0, 0x1f,
-					pcm512x_dsp_program_texts,
-					pcm512x_dsp_program_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(pcm512x_dsp_program,
+				  PCM512x_DSP_PROGRAM, 0, 0x1f,
+				  pcm512x_dsp_program_texts,
+				  pcm512x_dsp_program_values);
 
 static const char * const pcm512x_clk_missing_text[] = {
 	"1s", "2s", "3s", "4s", "5s", "6s", "7s", "8s"
-- 
1.9.0
