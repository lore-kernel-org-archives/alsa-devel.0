From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] ASoC: rt5651: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:09 +0200
Message-ID: <1432064952-31997-5-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 465072605C0
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:24 +0200 (CEST)
In-Reply-To: <1432064952-31997-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f03c6fc..a3506e1 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1571,7 +1571,7 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
 				RT5651_PWR_VREF1 | RT5651_PWR_MB |
 				RT5651_PWR_BG | RT5651_PWR_VREF2,
-- 
1.8.0
