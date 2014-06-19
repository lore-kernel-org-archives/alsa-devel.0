From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm5100/wm8903/wm8996: Replace open-coded
	snd_soc_dapm_to_codec()
Date: Thu, 19 Jun 2014 07:50:01 +0200
Message-ID: <1403157002-11638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-075.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A2D2651CF
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 07:50:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We now have a generic helper function to cast from a DAPM context to a CODEC.
Make use of it in the places which previously open-coded it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5100.c | 3 +--
 sound/soc/codecs/wm8903.c | 3 +--
 sound/soc/codecs/wm8996.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 91a9ea2..7bb0d36 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -735,8 +735,7 @@ WM5100_MIXER_CONTROLS("LHPF4", WM5100_HPLP4MIX_INPUT_1_SOURCE),
 static void wm5100_seq_notifier(struct snd_soc_dapm_context *dapm,
 				enum snd_soc_dapm_type event, int subseq)
 {
-	struct snd_soc_codec *codec = container_of(dapm,
-						   struct snd_soc_codec, dapm);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
 	u16 val, expect, i;
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b84940c..ec3250d 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -281,8 +281,7 @@ static int wm8903_dcs_event(struct snd_soc_dapm_widget *w,
 static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
 				enum snd_soc_dapm_type event, int subseq)
 {
-	struct snd_soc_codec *codec = container_of(dapm,
-						   struct snd_soc_codec, dapm);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int dcs_mode = WM8903_DCS_MODE_WRITE_STOP;
 	int i, val;
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 6926633..9304a91 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -690,8 +690,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 				enum snd_soc_dapm_type event, int subseq)
 {
-	struct snd_soc_codec *codec = container_of(dapm,
-						   struct snd_soc_codec, dapm);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	u16 val, mask;
 
-- 
1.8.0
