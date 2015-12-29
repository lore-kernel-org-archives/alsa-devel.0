From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Use helper function to lock
	the DAPM mutex
Date: Tue, 29 Dec 2015 16:25:14 +0000
Message-ID: <1451406314-13973-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1451406314-13973-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E80F265867
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 17:25:38 +0100 (CET)
In-Reply-To: <1451406314-13973-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

A couple of call sites were missed when the snd_soc_dapm_mutex_lock
function was added this patch fixes those up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c364096..eb1e665 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -439,18 +439,17 @@ static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	/*
 	 * PGA Volume is also used as part of the enable sequence, so
 	 * usage of it should be avoided whilst that is running.
 	 */
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
 
-	mutex_unlock(&card->dapm_mutex);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	return ret;
 }
@@ -460,18 +459,17 @@ static int wm5110_in_pga_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	/*
 	 * PGA Volume is also used as part of the enable sequence, so
 	 * usage of it should be avoided whilst that is running.
 	 */
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = snd_soc_put_volsw_range(kcontrol, ucontrol);
 
-	mutex_unlock(&card->dapm_mutex);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	return ret;
 }
-- 
2.1.4
