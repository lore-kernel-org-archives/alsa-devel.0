From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Improve legibility of
	if-statements
Date: Tue, 28 Aug 2018 23:42:31 +0200
Message-ID: <20180828214231.10164-2-kmarinushkin@birdec.tech>
References: <20180828194045.GQ2414@sirena.org.uk>
 <20180828214231.10164-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 752022678EE
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 23:42:14 +0200 (CEST)
In-Reply-To: <20180828214231.10164-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org

Modified some if-statements to make them more clear

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm3060.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 5b9718fa766d..494d9d662be8 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -68,7 +68,10 @@ static int pcm3060_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_FMT, val);
 
@@ -124,7 +127,10 @@ static int pcm3060_hw_params(struct snd_pcm_substream *substream,
 	}
 
 val_ready:
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_MS, val);
 
-- 
2.13.6
