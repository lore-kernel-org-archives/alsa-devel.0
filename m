From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: cs42l51: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 20 Nov 2014 21:05:38 +0100
Message-ID: <1416513940-28717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4192605F4
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:05:40 +0100 (CET)
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
 sound/soc/codecs/cs42l51.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 669c38f..b395152 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -153,15 +153,17 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 static int cs42l51_pdn_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(w->codec, CS42L51_POWER_CTL1,
+		snd_soc_update_bits(codec, CS42L51_POWER_CTL1,
 				    CS42L51_POWER_CTL1_PDN,
 				    CS42L51_POWER_CTL1_PDN);
 		break;
 	default:
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(w->codec, CS42L51_POWER_CTL1,
+		snd_soc_update_bits(codec, CS42L51_POWER_CTL1,
 				    CS42L51_POWER_CTL1_PDN, 0);
 		break;
 	}
-- 
1.8.0
