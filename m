From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 093/102] ASoC: wm8350: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:39 +0100
Message-ID: <1392724308-13375-13-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D38265769
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8350.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index a183dcf3d5c1..1d8d1424264a 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -381,14 +381,14 @@ static const char *wm8350_adchp[] = { "44.1kHz", "8kHz", "16kHz", "32kHz" };
 static const char *wm8350_lr[] = { "Left", "Right" };
 
 static const struct soc_enum wm8350_enum[] = {
-	SOC_ENUM_SINGLE(WM8350_DAC_CONTROL, 4, 4, wm8350_deemp),
-	SOC_ENUM_SINGLE(WM8350_DAC_CONTROL, 0, 4, wm8350_pol),
-	SOC_ENUM_SINGLE(WM8350_DAC_MUTE_VOLUME, 14, 2, wm8350_dacmutem),
-	SOC_ENUM_SINGLE(WM8350_DAC_MUTE_VOLUME, 13, 2, wm8350_dacmutes),
-	SOC_ENUM_SINGLE(WM8350_ADC_CONTROL, 15, 2, wm8350_adcfilter),
-	SOC_ENUM_SINGLE(WM8350_ADC_CONTROL, 8, 4, wm8350_adchp),
-	SOC_ENUM_SINGLE(WM8350_ADC_CONTROL, 0, 4, wm8350_pol),
-	SOC_ENUM_SINGLE(WM8350_INPUT_MIXER_VOLUME, 15, 2, wm8350_lr),
+	SOC_ENUM_SINGLE_CONST(WM8350_DAC_CONTROL, 4, wm8350_deemp),
+	SOC_ENUM_SINGLE_CONST(WM8350_DAC_CONTROL, 0, wm8350_pol),
+	SOC_ENUM_SINGLE_CONST(WM8350_DAC_MUTE_VOLUME, 14, wm8350_dacmutem),
+	SOC_ENUM_SINGLE_CONST(WM8350_DAC_MUTE_VOLUME, 13, wm8350_dacmutes),
+	SOC_ENUM_SINGLE_CONST(WM8350_ADC_CONTROL, 15, wm8350_adcfilter),
+	SOC_ENUM_SINGLE_CONST(WM8350_ADC_CONTROL, 8, wm8350_adchp),
+	SOC_ENUM_SINGLE_CONST(WM8350_ADC_CONTROL, 0, wm8350_pol),
+	SOC_ENUM_SINGLE_CONST(WM8350_INPUT_MIXER_VOLUME, 15, wm8350_lr),
 };
 
 static DECLARE_TLV_DB_SCALE(pre_amp_tlv, -1200, 3525, 0);
-- 
1.8.5.2
