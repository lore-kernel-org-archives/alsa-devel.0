From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 29/29] ASoC: wm_hubs: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:35 +0100
Message-ID: <1421141255-21477-29-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 630DF261A80
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:17 +0100 (CET)
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
 sound/soc/codecs/wm_hubs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 374537d..8366e19 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -500,7 +500,7 @@ SOC_SINGLE_TLV("LINEOUT2 Volume", WM8993_LINE_OUTPUTS_VOLUME, 0, 1, 1,
 static int hp_supply_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -542,7 +542,7 @@ static int hp_supply_event(struct snd_soc_dapm_widget *w,
 static int hp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int reg = snd_soc_read(codec, WM8993_ANALOGUE_HP_0);
 
 	switch (event) {
@@ -594,7 +594,7 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 static int earpiece_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *control, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u16 reg = snd_soc_read(codec, WM8993_ANTIPOP1) & ~WM8993_HPOUT2_IN_ENA;
 
 	switch (event) {
@@ -619,7 +619,7 @@ static int earpiece_event(struct snd_soc_dapm_widget *w,
 static int lineout_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *control, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	bool *flag;
 
@@ -649,7 +649,7 @@ static int lineout_event(struct snd_soc_dapm_widget *w,
 static int micbias_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 
 	switch (w->shift) {
-- 
1.8.0
