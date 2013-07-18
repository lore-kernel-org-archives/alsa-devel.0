From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] ASoC: wm8904: fix the typo error for LINER Mux
Date: Thu, 18 Jul 2013 14:38:20 +0800
Message-ID: <1374129500-5270-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 74D54265543
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 08:41:50 +0200 (CEST)
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
Cc: Bo Shen <voice.shen@atmel.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

fix the typo error, from "LINEL Mux" to "LINER Mux"

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/codecs/wm8904.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 3ff195c..bdd575a 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1017,7 +1017,7 @@ static const struct soc_enum liner_enum =
 	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 0, 2, out_mux_text);
 
 static const struct snd_kcontrol_new liner_mux =
-	SOC_DAPM_ENUM("LINEL Mux", liner_enum);
+	SOC_DAPM_ENUM("LINER Mux", liner_enum);
 
 static const char *sidetone_text[] = {
 	"None", "Left", "Right"
-- 
1.7.9.5
