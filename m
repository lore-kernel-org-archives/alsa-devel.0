From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 039/102] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:55 +0100
Message-ID: <1392723517-12772-12-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF9A2655BD
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
 sound/soc/codecs/mc13783.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 147c2e53797b..c605036cc0b0 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -408,8 +408,8 @@ static const char * const adcl_enum_text[] = {
 	"MC1L", "RXINL",
 };
 
-static const struct soc_enum adcl_enum =
-	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(adcl_enum_text), adcl_enum_text);
+static SOC_ENUM_SINGLE_DECL(adcl_enum,
+			    0, 0, adcl_enum_text);
 
 static const struct snd_kcontrol_new left_input_mux =
 	SOC_DAPM_ENUM_VIRT("Route", adcl_enum);
@@ -418,8 +418,8 @@ static const char * const adcr_enum_text[] = {
 	"MC1R", "MC2", "RXINR", "TXIN",
 };
 
-static const struct soc_enum adcr_enum =
-	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(adcr_enum_text), adcr_enum_text);
+static SOC_ENUM_SINGLE_DECL(adcr_enum,
+			    0, 0, adcr_enum_text);
 
 static const struct snd_kcontrol_new right_input_mux =
 	SOC_DAPM_ENUM_VIRT("Route", adcr_enum);
@@ -580,9 +580,9 @@ static struct snd_soc_dapm_route mc13783_routes[] = {
 static const char * const mc13783_3d_mixer[] = {"Stereo", "Phase Mix",
 						"Mono", "Mono Mix"};
 
-static const struct soc_enum mc13783_enum_3d_mixer =
-	SOC_ENUM_SINGLE(MC13783_AUDIO_RX1, 16, ARRAY_SIZE(mc13783_3d_mixer),
-			mc13783_3d_mixer);
+static SOC_ENUM_SINGLE_DECL(mc13783_enum_3d_mixer,
+			    MC13783_AUDIO_RX1, 16,
+			    mc13783_3d_mixer);
 
 static struct snd_kcontrol_new mc13783_control_list[] = {
 	SOC_SINGLE("Loudspeaker enable", MC13783_AUDIO_RX0, 5, 1, 0),
-- 
1.8.5.2
