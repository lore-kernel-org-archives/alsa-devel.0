From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 22/29] ASoC: wm8995: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:28 +0100
Message-ID: <1421141255-21477-22-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 89E47261606
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:06 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
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

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8995.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 120228b..66103c2 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -534,10 +534,11 @@ static void wm8995_update_class_w(struct snd_soc_codec *codec)
 static int check_clk_sys(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 	const char *clk;
 
-	reg = snd_soc_read(source->codec, WM8995_CLOCKING_1);
+	reg = snd_soc_read(codec, WM8995_CLOCKING_1);
 	/* Check what we're currently using for CLK_SYS */
 	if (reg & WM8995_SYSCLK_SRC)
 		clk = "AIF2CLK";
@@ -560,9 +561,7 @@ static int wm8995_put_class_w(struct snd_kcontrol *kcontrol,
 static int hp_supply_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec;
-
-	codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -611,10 +610,9 @@ static void dc_servo_cmd(struct snd_soc_codec *codec,
 static int hp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int reg;
 
-	codec = w->codec;
 	reg = snd_soc_read(codec, WM8995_ANALOGUE_HP_1);
 
 	switch (event) {
@@ -761,9 +759,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec;
-
-	codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-- 
1.8.0
