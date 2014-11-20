From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: cs42l73: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 20 Nov 2014 21:05:39 +0100
Message-ID: <1416513940-28717-2-git-send-email-lars@metafoo.de>
References: <1416513940-28717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E88D2605FC
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:05:41 +0100 (CET)
In-Reply-To: <1416513940-28717-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs42l73.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 2f8b946..7c55537 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -584,7 +584,7 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 static int cs42l73_spklo_spk_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
@@ -600,7 +600,7 @@ static int cs42l73_spklo_spk_amp_event(struct snd_soc_dapm_widget *w,
 static int cs42l73_ear_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
@@ -618,7 +618,7 @@ static int cs42l73_ear_amp_event(struct snd_soc_dapm_widget *w,
 static int cs42l73_hp_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
-- 
1.8.0
