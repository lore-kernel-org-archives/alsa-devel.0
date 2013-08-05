From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8994: Fix class W controls
Date: Mon,  5 Aug 2013 23:35:07 +0100
Message-ID: <1375742107-7583-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A7D0226526D
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 00:35:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Commit 6e0650 (ASoC: wm8994: Use SOC_SINGLE_EXT() instead of open-coding
it) went too far and converted a DAPM control to use SOC_SINGLE_EXT()
which crashes.  Revert that portion of the patch.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8994.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d76b056..29ad480 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1432,8 +1432,8 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
 };
 
 #define WM8994_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
-	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
-		snd_soc_get_volsw, wm8994_put_class_w)
+	SOC_SINGLE_EXT(xname, reg, shift, 1, 0, \
+		snd_soc_dapm_get_volsw, wm8994_put_class_w)
 
 static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
-- 
1.8.4.rc0
