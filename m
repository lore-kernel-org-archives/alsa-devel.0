From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: arizona: Add noise gate hold time
	enumeration
Date: Tue, 18 Dec 2012 14:13:04 +0000
Message-ID: <1355839986-17604-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 954FA261615
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 15:13:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    9 +++++++++
 sound/soc/codecs/arizona.h |    2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a85a68f..89c0433 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -323,6 +323,15 @@ const struct soc_enum arizona_lhpf4_mode =
 			arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf4_mode);
 
+static const char *arizona_ng_hold_text[] = {
+	"30ms", "120ms", "250ms", "500ms",
+};
+
+const struct soc_enum arizona_ng_hold =
+	SOC_ENUM_SINGLE(ARIZONA_NOISE_GATE_CONTROL, ARIZONA_NGATE_HOLD_SHIFT,
+			4, arizona_ng_hold_text);
+EXPORT_SYMBOL_GPL(arizona_ng_hold);
+
 int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		  int event)
 {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index db0c8dd..68dfae5 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -176,6 +176,8 @@ extern const struct soc_enum arizona_lhpf2_mode;
 extern const struct soc_enum arizona_lhpf3_mode;
 extern const struct soc_enum arizona_lhpf4_mode;
 
+extern const struct soc_enum arizona_ng_hold;
+
 extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
-- 
1.7.10.4
