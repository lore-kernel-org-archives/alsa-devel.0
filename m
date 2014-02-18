From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 018/102] ASoC: ad1980: Fix wrong number of
	items for capture source
Date: Tue, 18 Feb 2014 12:36:53 +0100
Message-ID: <1392723422-12689-3-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC5F26549A
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

The number of capture sources is 8, not 7.
Use SOC_ENUM_DOUBLE_DECL() macro and it's automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ad1980.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 7257a8885f42..34d965a4a040 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -57,8 +57,8 @@ static const u16 ad1980_reg[] = {
 static const char *ad1980_rec_sel[] = {"Mic", "CD", "NC", "AUX", "Line",
 		"Stereo Mix", "Mono Mix", "Phone"};
 
-static const struct soc_enum ad1980_cap_src =
-	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 7, ad1980_rec_sel);
+static SOC_ENUM_DOUBLE_DECL(ad1980_cap_src,
+			    AC97_REC_SEL, 8, 0, ad1980_rec_sel);
 
 static const struct snd_kcontrol_new ad1980_snd_ac97_controls[] = {
 SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
-- 
1.8.5.2
