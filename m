From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 061/102] ASoC: wm_hubs: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:17 +0100
Message-ID: <1392723517-12772-34-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B47A02655E1
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
 sound/soc/codecs/wm_hubs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index b371066dd5bc..b6209662ab13 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -50,16 +50,16 @@ static const char *speaker_ref_text[] = {
 	"VMID",
 };
 
-static const struct soc_enum speaker_ref =
-	SOC_ENUM_SINGLE(WM8993_SPEAKER_MIXER, 8, 2, speaker_ref_text);
+static SOC_ENUM_SINGLE_DECL(speaker_ref,
+			    WM8993_SPEAKER_MIXER, 8, speaker_ref_text);
 
 static const char *speaker_mode_text[] = {
 	"Class D",
 	"Class AB",
 };
 
-static const struct soc_enum speaker_mode =
-	SOC_ENUM_SINGLE(WM8993_SPKMIXR_ATTENUATION, 8, 2, speaker_mode_text);
+static SOC_ENUM_SINGLE_DECL(speaker_mode,
+			    WM8993_SPKMIXR_ATTENUATION, 8, speaker_mode_text);
 
 static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 {
@@ -735,15 +735,15 @@ static const char *hp_mux_text[] = {
 	"DAC",
 };
 
-static const struct soc_enum hpl_enum =
-	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER1, 8, 2, hp_mux_text);
+static SOC_ENUM_SINGLE_DECL(hpl_enum,
+			    WM8993_OUTPUT_MIXER1, 8, hp_mux_text);
 
 const struct snd_kcontrol_new wm_hubs_hpl_mux =
 	WM_HUBS_ENUM_W("Left Headphone Mux", hpl_enum);
 EXPORT_SYMBOL_GPL(wm_hubs_hpl_mux);
 
-static const struct soc_enum hpr_enum =
-	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER2, 8, 2, hp_mux_text);
+static SOC_ENUM_SINGLE_DECL(hpr_enum,
+			    WM8993_OUTPUT_MIXER2, 8, hp_mux_text);
 
 const struct snd_kcontrol_new wm_hubs_hpr_mux =
 	WM_HUBS_ENUM_W("Right Headphone Mux", hpr_enum);
-- 
1.8.5.2
