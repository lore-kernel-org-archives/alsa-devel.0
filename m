From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 074/102] ASoC: wm9081: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:30 +0100
Message-ID: <1392723517-12772-47-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FF92655E4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm9081.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 0982c1d38ec4..721cee71d5fc 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -268,8 +268,7 @@ static const char *drc_high_text[] = {
 	"0",
 };
 
-static const struct soc_enum drc_high =
-	SOC_ENUM_SINGLE(WM9081_DRC_3, 3, 6, drc_high_text);
+static SOC_ENUM_SINGLE_DECL(drc_high, WM9081_DRC_3, 3, drc_high_text);
 
 static const char *drc_low_text[] = {
 	"1",
@@ -279,8 +278,7 @@ static const char *drc_low_text[] = {
 	"0",
 };
 
-static const struct soc_enum drc_low =
-	SOC_ENUM_SINGLE(WM9081_DRC_3, 0, 5, drc_low_text);
+static SOC_ENUM_SINGLE_DECL(drc_low, WM9081_DRC_3, 0, drc_low_text);
 
 static const char *drc_atk_text[] = {
 	"181us",
@@ -297,8 +295,7 @@ static const char *drc_atk_text[] = {
 	"185.6ms",
 };
 
-static const struct soc_enum drc_atk =
-	SOC_ENUM_SINGLE(WM9081_DRC_2, 12, 12, drc_atk_text);
+static SOC_ENUM_SINGLE_DECL(drc_atk, WM9081_DRC_2, 12, drc_atk_text);
 
 static const char *drc_dcy_text[] = {
 	"186ms",
@@ -312,8 +309,7 @@ static const char *drc_dcy_text[] = {
 	"47.56s",
 };
 
-static const struct soc_enum drc_dcy =
-	SOC_ENUM_SINGLE(WM9081_DRC_2, 8, 9, drc_dcy_text);
+static SOC_ENUM_SINGLE_DECL(drc_dcy, WM9081_DRC_2, 8, drc_dcy_text);
 
 static const char *drc_qr_dcy_text[] = {
 	"0.725ms",
@@ -321,8 +317,7 @@ static const char *drc_qr_dcy_text[] = {
 	"5.8ms",
 };
 
-static const struct soc_enum drc_qr_dcy =
-	SOC_ENUM_SINGLE(WM9081_DRC_2, 4, 3, drc_qr_dcy_text);
+static SOC_ENUM_SINGLE_DECL(drc_qr_dcy, WM9081_DRC_2, 4, drc_qr_dcy_text);
 
 static const char *dac_deemph_text[] = {
 	"None",
@@ -331,16 +326,16 @@ static const char *dac_deemph_text[] = {
 	"48kHz",
 };
 
-static const struct soc_enum dac_deemph =
-	SOC_ENUM_SINGLE(WM9081_DAC_DIGITAL_2, 1, 4, dac_deemph_text);
+static SOC_ENUM_SINGLE_DECL(dac_deemph, WM9081_DAC_DIGITAL_2, 1,
+			    dac_deemph_text);
 
 static const char *speaker_mode_text[] = {
 	"Class D",
 	"Class AB",
 };
 
-static const struct soc_enum speaker_mode =
-	SOC_ENUM_SINGLE(WM9081_ANALOGUE_SPEAKER_2, 6, 2, speaker_mode_text);
+static SOC_ENUM_SINGLE_DECL(speaker_mode, WM9081_ANALOGUE_SPEAKER_2, 6,
+			    speaker_mode_text);
 
 static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
-- 
1.8.5.2
