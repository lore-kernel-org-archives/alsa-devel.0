From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 077/102] ASoC: cs42l73: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:33 +0100
Message-ID: <1392723517-12772-50-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4952655EA
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
 sound/soc/codecs/cs42l73.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 69c8e2de7d0e..06f429184821 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -278,13 +278,13 @@ static const DECLARE_TLV_DB_SCALE(attn_tlv, -6300, 100, 1);
 static const char * const cs42l73_pgaa_text[] = { "Line A", "Mic 1" };
 static const char * const cs42l73_pgab_text[] = { "Line B", "Mic 2" };
 
-static const struct soc_enum pgaa_enum =
-	SOC_ENUM_SINGLE(CS42L73_ADCIPC, 3,
-		ARRAY_SIZE(cs42l73_pgaa_text), cs42l73_pgaa_text);
+static SOC_ENUM_SINGLE_DECL(pgaa_enum,
+			    CS42L73_ADCIPC, 3,
+			    cs42l73_pgaa_text);
 
-static const struct soc_enum pgab_enum =
-	SOC_ENUM_SINGLE(CS42L73_ADCIPC, 7,
-		ARRAY_SIZE(cs42l73_pgab_text), cs42l73_pgab_text);
+static SOC_ENUM_SINGLE_DECL(pgab_enum,
+			    CS42L73_ADCIPC, 7,
+			    cs42l73_pgab_text);
 
 static const struct snd_kcontrol_new pgaa_mux =
 	SOC_DAPM_ENUM("Left Analog Input Capture Mux", pgaa_enum);
@@ -309,9 +309,9 @@ static const struct snd_kcontrol_new input_right_mixer[] = {
 static const char * const cs42l73_ng_delay_text[] = {
 	"50ms", "100ms", "150ms", "200ms" };
 
-static const struct soc_enum ng_delay_enum =
-	SOC_ENUM_SINGLE(CS42L73_NGCAB, 0,
-		ARRAY_SIZE(cs42l73_ng_delay_text), cs42l73_ng_delay_text);
+static SOC_ENUM_SINGLE_DECL(ng_delay_enum,
+			    CS42L73_NGCAB, 0,
+			    cs42l73_ng_delay_text);
 
 static const char * const cs42l73_mono_mix_texts[] = {
 	"Left", "Right", "Mono Mix"};
@@ -357,19 +357,19 @@ static const struct snd_kcontrol_new esl_xsp_mixer =
 static const char * const cs42l73_ip_swap_text[] = {
 	"Stereo", "Mono A", "Mono B", "Swap A-B"};
 
-static const struct soc_enum ip_swap_enum =
-	SOC_ENUM_SINGLE(CS42L73_MIOPC, 6,
-		ARRAY_SIZE(cs42l73_ip_swap_text), cs42l73_ip_swap_text);
+static SOC_ENUM_SINGLE_DECL(ip_swap_enum,
+			    CS42L73_MIOPC, 6,
+			    cs42l73_ip_swap_text);
 
 static const char * const cs42l73_spo_mixer_text[] = {"Mono", "Stereo"};
 
-static const struct soc_enum vsp_output_mux_enum =
-	SOC_ENUM_SINGLE(CS42L73_MIXERCTL, 5,
-		ARRAY_SIZE(cs42l73_spo_mixer_text), cs42l73_spo_mixer_text);
+static SOC_ENUM_SINGLE_DECL(vsp_output_mux_enum,
+			    CS42L73_MIXERCTL, 5,
+			    cs42l73_spo_mixer_text);
 
-static const struct soc_enum xsp_output_mux_enum =
-	SOC_ENUM_SINGLE(CS42L73_MIXERCTL, 4,
-		ARRAY_SIZE(cs42l73_spo_mixer_text), cs42l73_spo_mixer_text);
+static SOC_ENUM_SINGLE_DECL(xsp_output_mux_enum,
+			    CS42L73_MIXERCTL, 4,
+			    cs42l73_spo_mixer_text);
 
 static const struct snd_kcontrol_new vsp_output_mux =
 	SOC_DAPM_ENUM("Route", vsp_output_mux_enum);
-- 
1.8.5.2
