From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 06/17 v2] ASoC: wm5100: Update locking around
	use of DAPM pin API
Date: Tue, 18 Feb 2014 15:22:17 +0000
Message-ID: <1392736948-26623-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 967862652DB
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 16:30:51 +0100 (CET)
In-Reply-To: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4e3e31a..492fe84 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2100,6 +2100,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	if (jack) {
 		wm5100->jack = jack;
@@ -2117,9 +2118,14 @@ int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 				    WM5100_ACCDET_RATE_MASK);
 
 		/* We need the charge pump to power MICBIAS */
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "CP2");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_mutex_lock(dapm);
+
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "CP2");
+		snd_soc_dapm_force_enable_pin_unlocked(dapm, "SYSCLK");
+
+		snd_soc_dapm_sync_unlocked(dapm);
+
+		snd_soc_dapm_mutex_unlock(dapm);
 
 		/* We start off just enabling microphone detection - even a
 		 * plain headphone will trigger detection.
-- 
1.7.2.5
