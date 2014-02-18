From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 047/102] ASoC: wl1273: Use
	SOC_ENUM_SINGLE_EXT_DECL()
Date: Tue, 18 Feb 2014 12:38:03 +0100
Message-ID: <1392723517-12772-20-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 880EC2655C9
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
 sound/soc/codecs/wl1273.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index b7ab2ef567c8..7485285d08d2 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -209,8 +209,7 @@ static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static const struct soc_enum wl1273_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wl1273_audio_route), wl1273_audio_route);
+static SOC_ENUM_SINGLE_EXT_DECL(wl1273_enum, wl1273_audio_route);
 
 static int snd_wl1273_fm_audio_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
@@ -247,9 +246,7 @@ static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,
 
 static const char * const wl1273_audio_strings[] = { "Digital", "Analog" };
 
-static const struct soc_enum wl1273_audio_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wl1273_audio_strings),
-			    wl1273_audio_strings);
+static SOC_ENUM_SINGLE_EXT_DECL(wl1273_audio_enum, wl1273_audio_strings);
 
 static int snd_wl1273_fm_volume_get(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
-- 
1.8.5.2
