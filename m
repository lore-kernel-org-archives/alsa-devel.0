From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 065/102] ASoC: ak4671: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:21 +0100
Message-ID: <1392723517-12772-38-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A40452655D8
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
 sound/soc/codecs/ak4671.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 743bbe31bc08..deb2b44669de 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -237,19 +237,17 @@ static const struct snd_kcontrol_new ak4671_rout3_mixer_controls[] = {
 /* Input MUXs */
 static const char *ak4671_lin_mux_texts[] =
 		{"LIN1", "LIN2", "LIN3", "LIN4"};
-static const struct soc_enum ak4671_lin_mux_enum =
-	SOC_ENUM_SINGLE(AK4671_MIC_SIGNAL_SELECT, 0,
-			ARRAY_SIZE(ak4671_lin_mux_texts),
-			ak4671_lin_mux_texts);
+static SOC_ENUM_SINGLE_DECL(ak4671_lin_mux_enum,
+			    AK4671_MIC_SIGNAL_SELECT, 0,
+			    ak4671_lin_mux_texts);
 static const struct snd_kcontrol_new ak4671_lin_mux_control =
 	SOC_DAPM_ENUM("Route", ak4671_lin_mux_enum);
 
 static const char *ak4671_rin_mux_texts[] =
 		{"RIN1", "RIN2", "RIN3", "RIN4"};
-static const struct soc_enum ak4671_rin_mux_enum =
-	SOC_ENUM_SINGLE(AK4671_MIC_SIGNAL_SELECT, 2,
-			ARRAY_SIZE(ak4671_rin_mux_texts),
-			ak4671_rin_mux_texts);
+static SOC_ENUM_SINGLE_DECL(ak4671_rin_mux_enum,
+			    AK4671_MIC_SIGNAL_SELECT, 2,
+			    ak4671_rin_mux_texts);
 static const struct snd_kcontrol_new ak4671_rin_mux_control =
 	SOC_DAPM_ENUM("Route", ak4671_rin_mux_enum);
 
-- 
1.8.5.2
