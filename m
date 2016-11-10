From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Call arizona_init_notifiers
	for all CODECs
Date: Thu, 10 Nov 2016 15:24:15 +0000
Message-ID: <1478791455-11246-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1478791455-11246-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 581B526683A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 16:24:03 +0100 (CET)
In-Reply-To: <1478791455-11246-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

The call to arizona_init_notifiers was only added for CODECs that are
generating voice trigger events, however, this is somewhat annoying
for machine drivers that might be used with multiple CODECs as they
need to conditionally register for the notifier, depending on the
CODEC being attached.

As the cost of initialising the notifier is so minimal, and we may
well add other events in the future that apply to more CODECs, simply
do this for all Arizona CODECs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c | 1 +
 sound/soc/codecs/wm8997.c | 1 +
 sound/soc/codecs/wm8998.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0136234..72ff291 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1945,6 +1945,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 600595c..ea8b1bf 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1063,6 +1063,7 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
 
 	arizona_init_spk(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 4cccaae..1e1d9c1 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1325,6 +1325,7 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
-- 
2.1.4
