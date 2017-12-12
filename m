From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 07/10] ASoC: tlv320aic32x4: Use
	snd_soc_update_bits() in aic32x4_mute()
Date: Tue, 12 Dec 2017 16:43:08 -0600
Message-ID: <20171212224311.24045-7-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C522671E9
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 23:43:14 +0100 (CET)
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Simplify mute function by using snd_soc_update_bits() over
read/modify/write style code.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 426d06206ae4..0dffbe8a2666 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -757,13 +757,10 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u8 dac_reg;
 
-	dac_reg = snd_soc_read(codec, AIC32X4_DACMUTE) & ~AIC32X4_MUTEON;
-	if (mute)
-		snd_soc_write(codec, AIC32X4_DACMUTE, dac_reg | AIC32X4_MUTEON);
-	else
-		snd_soc_write(codec, AIC32X4_DACMUTE, dac_reg);
+	snd_soc_update_bits(codec, AIC32X4_DACMUTE,
+			    AIC32X4_MUTEON, mute ? AIC32X4_MUTEON : 0);
+
 	return 0;
 }
 
-- 
2.15.0
