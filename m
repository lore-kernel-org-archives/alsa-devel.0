From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Correct types of mixer
	texts and values
Date: Thu, 3 Dec 2015 18:15:06 +0000
Message-ID: <1449166507-3096-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD5226054D
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 19:15:11 +0100 (CET)
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

The core expects "const char * const" and "unsigned int" for enum
controls, various places in Arizona use "const char *" and "int".
This patch corrects the type of these arrays.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 8 ++++----
 sound/soc/codecs/arizona.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a23f7d1..d2731cf 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -310,7 +310,7 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_gpio);
 
-const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
+const char * const arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"None",
 	"Tone Generator 1",
 	"Tone Generator 2",
@@ -418,7 +418,7 @@ const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 };
 EXPORT_SYMBOL_GPL(arizona_mixer_texts);
 
-int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS] = {
+unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS] = {
 	0x00,  /* None */
 	0x04,  /* Tone */
 	0x05,
@@ -555,12 +555,12 @@ const char *arizona_sample_rate_val_to_name(unsigned int rate_val)
 }
 EXPORT_SYMBOL_GPL(arizona_sample_rate_val_to_name);
 
-const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE] = {
+const char * const arizona_rate_text[ARIZONA_RATE_ENUM_SIZE] = {
 	"SYNCCLK rate", "8kHz", "16kHz", "ASYNCCLK rate",
 };
 EXPORT_SYMBOL_GPL(arizona_rate_text);
 
-const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE] = {
+const unsigned int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE] = {
 	0, 1, 2, 8,
 };
 EXPORT_SYMBOL_GPL(arizona_rate_val);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 01a367c..b4f1867 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -96,8 +96,8 @@ struct arizona_priv {
 #define ARIZONA_NUM_MIXER_INPUTS 104
 
 extern const unsigned int arizona_mixer_tlv[];
-extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
-extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
+extern const char * const arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
+extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
 #define ARIZONA_GAINMUX_CONTROLS(name, base) \
 	SOC_SINGLE_RANGE_TLV(name " Input Volume", base + 1,		\
@@ -216,8 +216,8 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 #define ARIZONA_RATE_ENUM_SIZE 4
 #define ARIZONA_SAMPLE_RATE_ENUM_SIZE 14
 
-extern const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
-extern const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
+extern const char * const arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
+extern const unsigned int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
 extern const char * const arizona_sample_rate_text[ARIZONA_SAMPLE_RATE_ENUM_SIZE];
 extern const unsigned int arizona_sample_rate_val[ARIZONA_SAMPLE_RATE_ENUM_SIZE];
 
-- 
2.1.4
