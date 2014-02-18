From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 062/102] ASoC: omap: Use
	SOC_ENUM_SINGLE_EXT_DECL()
Date: Tue, 18 Feb 2014 12:38:18 +0100
Message-ID: <1392723517-12772-35-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ED522655D5
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
 sound/soc/omap/ams-delta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 2eca91a51f51..8a4a63a79d31 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -194,13 +194,11 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const struct soc_enum ams_delta_audio_enum[] = {
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ams_delta_audio_mode),
-						ams_delta_audio_mode),
-};
+static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
+				      ams_delta_audio_mode);
 
 static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
-	SOC_ENUM_EXT("Audio Mode", ams_delta_audio_enum[0],
+	SOC_ENUM_EXT("Audio Mode", ams_delta_audio_enum,
 			ams_delta_get_audio_mode, ams_delta_set_audio_mode),
 };
 
-- 
1.8.5.2
