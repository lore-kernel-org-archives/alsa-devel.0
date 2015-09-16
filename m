From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: arizona: Add utility function to
	check if an input is analog
Date: Wed, 16 Sep 2015 13:59:41 +0100
Message-ID: <1442408383-31682-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 05512261501
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 15:23:19 +0200 (CEST)
In-Reply-To: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

We will occasionally require to take different action based on if an
input is analog or digital so add a helper function to return if an
input is analog.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    9 +++++++++
 sound/soc/codecs/arizona.h |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1bc19f1..ac21b85 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -691,6 +691,15 @@ static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 				    ARIZONA_IN_VU, val);
 }
 
+bool arizona_input_analog(struct snd_soc_codec *codec, int shift)
+{
+	unsigned int reg = ARIZONA_IN1L_CONTROL + ((shift / 2) * 8);
+	unsigned int val = snd_soc_read(codec, reg);
+
+	return !(val & ARIZONA_IN1_MODE_MASK);
+}
+EXPORT_SYMBOL_GPL(arizona_input_analog);
+
 int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		  int event)
 {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index ada0a41..7b68d05 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -294,4 +294,6 @@ extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 int arizona_set_output_mode(struct snd_soc_codec *codec, int output,
 			    bool diff);
 
+extern bool arizona_input_analog(struct snd_soc_codec *codec, int shift);
+
 #endif
-- 
1.7.2.5
