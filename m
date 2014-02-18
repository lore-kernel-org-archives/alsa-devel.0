From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 048/102] ASoC: wm2200: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:04 +0100
Message-ID: <1392723517-12772-21-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E6092655D4
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
 sound/soc/codecs/wm2200.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 57ba315d0c84..1e0a083d8345 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1113,11 +1113,10 @@ static const char *wm2200_rxanc_input_sel_texts[] = {
 	"None", "IN1", "IN2", "IN3",
 };
 
-static const struct soc_enum wm2200_rxanc_input_sel =
-	SOC_ENUM_SINGLE(WM2200_RXANC_SRC,
-			WM2200_IN_RXANC_SEL_SHIFT,
-			ARRAY_SIZE(wm2200_rxanc_input_sel_texts),
-			wm2200_rxanc_input_sel_texts);
+static SOC_ENUM_SINGLE_DECL(wm2200_rxanc_input_sel,
+			    WM2200_RXANC_SRC,
+			    WM2200_IN_RXANC_SEL_SHIFT,
+			    wm2200_rxanc_input_sel_texts);
 
 static const struct snd_kcontrol_new wm2200_snd_controls[] = {
 SOC_SINGLE("IN1 High Performance Switch", WM2200_IN1L_CONTROL,
@@ -1288,11 +1287,10 @@ static const char *wm2200_aec_loopback_texts[] = {
 	"OUT1L", "OUT1R", "OUT2L", "OUT2R",
 };
 
-static const struct soc_enum wm2200_aec_loopback =
-	SOC_ENUM_SINGLE(WM2200_DAC_AEC_CONTROL_1,
-			WM2200_AEC_LOOPBACK_SRC_SHIFT,
-			ARRAY_SIZE(wm2200_aec_loopback_texts),
-			wm2200_aec_loopback_texts);
+static SOC_ENUM_SINGLE_DECL(wm2200_aec_loopback,
+			    WM2200_DAC_AEC_CONTROL_1,
+			    WM2200_AEC_LOOPBACK_SRC_SHIFT,
+			    wm2200_aec_loopback_texts);
 
 static const struct snd_kcontrol_new wm2200_aec_loopback_mux =
 	SOC_DAPM_ENUM("AEC Loopback", wm2200_aec_loopback);
-- 
1.8.5.2
