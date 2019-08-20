From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/2] ASoC: wm8904: fix typo in DAPM kcontrol name
Date: Tue, 20 Aug 2019 13:02:35 +0200
Message-ID: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566298834.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, Enrico Weigelt <info@metux.net>
List-Id: alsa-devel@alsa-project.org

Trivial fix for typo in "Capture Inverting Mux"es' name.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 v2: no changes
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 5ebdd1d9afde..525e4ef654a1 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -866,7 +866,7 @@ static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
 			    lin_text);
 
 static const struct snd_kcontrol_new lin_inv_mux =
-	SOC_DAPM_ENUM("Left Capture Inveting Mux", lin_inv_enum);
+	SOC_DAPM_ENUM("Left Capture Inverting Mux", lin_inv_enum);
 
 static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
@@ -882,7 +882,7 @@ static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
 			    rin_text);
 
 static const struct snd_kcontrol_new rin_inv_mux =
-	SOC_DAPM_ENUM("Right Capture Inveting Mux", rin_inv_enum);
+	SOC_DAPM_ENUM("Right Capture Inverting Mux", rin_inv_enum);
 
 static const char *aif_text[] = {
 	"Left", "Right"
-- 
2.20.1
