From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] ASoC: codecs: wm8753: Replace magic number
Date: Sat, 25 Jun 2016 07:58:09 +0300
Message-ID: <1466830689-31587-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp41.i.mail.ru (smtp41.i.mail.ru [94.100.177.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 6287B261B01
 for <alsa-devel@alsa-project.org>; Sat, 25 Jun 2016 06:58:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Shiyan <shc_work@mail.ru>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Use SND_SOC_NOPM constant, instead of -1.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/wm8753.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 6f1024f..9f851b8 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -486,7 +486,7 @@ SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", WM8753_PWR1, 4, 0),
 SND_SOC_DAPM_OUTPUT("MONO1"),
 SND_SOC_DAPM_MUX("Mono 2 Mux", SND_SOC_NOPM, 0, 0, &wm8753_mono2_controls),
 SND_SOC_DAPM_OUTPUT("MONO2"),
-SND_SOC_DAPM_MIXER("Out3 Left + Right", -1, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("Out3 Left + Right", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MUX("Out3 Mux", SND_SOC_NOPM, 0, 0, &wm8753_out3_controls),
 SND_SOC_DAPM_PGA("Out 3", WM8753_PWR3, 4, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("OUT3"),
-- 
2.4.9
