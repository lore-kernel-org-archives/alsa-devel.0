From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 013/102] ASoC: wm8978: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:25 +0100
Message-ID: <1392723148-12597-11-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FEDD265342
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
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

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8978.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index d8fc531c0e59..a9e2f465c331 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -117,21 +117,21 @@ static const char *wm8978_eq5[] = {"5.3kHz", "6.9kHz", "9kHz", "11.7kHz"};
 static const char *wm8978_alc3[] = {"ALC", "Limiter"};
 static const char *wm8978_alc1[] = {"Off", "Right", "Left", "Both"};
 
-static const SOC_ENUM_SINGLE_DECL(adc_compand, WM8978_COMPANDING_CONTROL, 1,
-				  wm8978_companding);
-static const SOC_ENUM_SINGLE_DECL(dac_compand, WM8978_COMPANDING_CONTROL, 3,
-				  wm8978_companding);
-static const SOC_ENUM_SINGLE_DECL(eqmode, WM8978_EQ1, 8, wm8978_eqmode);
-static const SOC_ENUM_SINGLE_DECL(eq1, WM8978_EQ1, 5, wm8978_eq1);
-static const SOC_ENUM_SINGLE_DECL(eq2bw, WM8978_EQ2, 8, wm8978_bw);
-static const SOC_ENUM_SINGLE_DECL(eq2, WM8978_EQ2, 5, wm8978_eq2);
-static const SOC_ENUM_SINGLE_DECL(eq3bw, WM8978_EQ3, 8, wm8978_bw);
-static const SOC_ENUM_SINGLE_DECL(eq3, WM8978_EQ3, 5, wm8978_eq3);
-static const SOC_ENUM_SINGLE_DECL(eq4bw, WM8978_EQ4, 8, wm8978_bw);
-static const SOC_ENUM_SINGLE_DECL(eq4, WM8978_EQ4, 5, wm8978_eq4);
-static const SOC_ENUM_SINGLE_DECL(eq5, WM8978_EQ5, 5, wm8978_eq5);
-static const SOC_ENUM_SINGLE_DECL(alc3, WM8978_ALC_CONTROL_3, 8, wm8978_alc3);
-static const SOC_ENUM_SINGLE_DECL(alc1, WM8978_ALC_CONTROL_1, 7, wm8978_alc1);
+static SOC_ENUM_SINGLE_DECL(adc_compand, WM8978_COMPANDING_CONTROL, 1,
+			    wm8978_companding);
+static SOC_ENUM_SINGLE_DECL(dac_compand, WM8978_COMPANDING_CONTROL, 3,
+			    wm8978_companding);
+static SOC_ENUM_SINGLE_DECL(eqmode, WM8978_EQ1, 8, wm8978_eqmode);
+static SOC_ENUM_SINGLE_DECL(eq1, WM8978_EQ1, 5, wm8978_eq1);
+static SOC_ENUM_SINGLE_DECL(eq2bw, WM8978_EQ2, 8, wm8978_bw);
+static SOC_ENUM_SINGLE_DECL(eq2, WM8978_EQ2, 5, wm8978_eq2);
+static SOC_ENUM_SINGLE_DECL(eq3bw, WM8978_EQ3, 8, wm8978_bw);
+static SOC_ENUM_SINGLE_DECL(eq3, WM8978_EQ3, 5, wm8978_eq3);
+static SOC_ENUM_SINGLE_DECL(eq4bw, WM8978_EQ4, 8, wm8978_bw);
+static SOC_ENUM_SINGLE_DECL(eq4, WM8978_EQ4, 5, wm8978_eq4);
+static SOC_ENUM_SINGLE_DECL(eq5, WM8978_EQ5, 5, wm8978_eq5);
+static SOC_ENUM_SINGLE_DECL(alc3, WM8978_ALC_CONTROL_3, 8, wm8978_alc3);
+static SOC_ENUM_SINGLE_DECL(alc1, WM8978_ALC_CONTROL_1, 7, wm8978_alc1);
 
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
-- 
1.8.5.2
