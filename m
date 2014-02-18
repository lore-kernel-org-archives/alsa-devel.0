From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 075/102] ASoC: wm9705: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:31 +0100
Message-ID: <1392723517-12772-48-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B91442655E6
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
 sound/soc/codecs/wm9705.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 70ce6793c5bd..c0b7f45dfa37 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -67,12 +67,12 @@ static const char *wm9705_mic[] = {"Mic 1", "Mic 2"};
 static const char *wm9705_rec_sel[] = {"Mic", "CD", "NC", "NC",
 	"Line", "Stereo Mix", "Mono Mix", "Phone"};
 
-static const struct soc_enum wm9705_enum_mic =
-	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 8, 2, wm9705_mic);
-static const struct soc_enum wm9705_enum_rec_l =
-	SOC_ENUM_SINGLE(AC97_REC_SEL, 8, 8, wm9705_rec_sel);
-static const struct soc_enum wm9705_enum_rec_r =
-	SOC_ENUM_SINGLE(AC97_REC_SEL, 0, 8, wm9705_rec_sel);
+static SOC_ENUM_SINGLE_DECL(wm9705_enum_mic,
+			    AC97_GENERAL_PURPOSE, 8, wm9705_mic);
+static SOC_ENUM_SINGLE_DECL(wm9705_enum_rec_l,
+			    AC97_REC_SEL, 8, wm9705_rec_sel);
+static SOC_ENUM_SINGLE_DECL(wm9705_enum_rec_r,
+			    AC97_REC_SEL, 0, wm9705_rec_sel);
 
 /* Headphone Mixer */
 static const struct snd_kcontrol_new wm9705_hp_mixer_controls[] = {
-- 
1.8.5.2
