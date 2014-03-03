From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASOC: spear: spdif_out: Fix mute control
Date: Mon,  3 Mar 2014 08:57:49 +0100
Message-ID: <1393833469-20838-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-129.synserver.de
 [212.40.185.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 467662654FB
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:57:25 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For controls registers with snd_soc_add_dai_controls snd_kcontrol_chip() returns
a pointer to the DAI, not to the CODEC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/spear/spdif_out.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index fe99f46..19cca04 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -213,10 +213,7 @@ static int spdif_digital_mute(struct snd_soc_dai *dai, int mute)
 static int spdif_mute_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_card *card = codec->card;
-	struct snd_soc_pcm_runtime *rtd = card->rtd;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
 
 	ucontrol->value.integer.value[0] = host->saved_params.mute;
@@ -226,10 +223,7 @@ static int spdif_mute_get(struct snd_kcontrol *kcontrol,
 static int spdif_mute_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_card *card = codec->card;
-	struct snd_soc_pcm_runtime *rtd = card->rtd;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
 
 	if (host->saved_params.mute == ucontrol->value.integer.value[0])
-- 
1.8.0
