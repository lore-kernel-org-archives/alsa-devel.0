From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/6] ASoC: da7219: Disable regulators on
	probe() failure
Date: Tue, 22 Dec 2015 18:27:51 +0000
Message-ID: <013f8a59618a9dfa74f6f983ed6ba4d7bec6a9d0.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 514302659FF
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 19:27:52 +0100 (CET)
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

If codec probe() function fails after supplies have been enabled
it should really tidy up and disable them again. This patch updates
the probe function to do just that.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index f238c1e..0ba714c 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1662,10 +1662,12 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	/* Check if MCLK provided */
 	da7219->mclk = devm_clk_get(codec->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
-		if (PTR_ERR(da7219->mclk) != -ENOENT)
-			return PTR_ERR(da7219->mclk);
-		else
+		if (PTR_ERR(da7219->mclk) != -ENOENT) {
+			ret = PTR_ERR(da7219->mclk);
+			goto err_disable_reg;
+		} else {
 			da7219->mclk = NULL;
+		}
 	}
 
 	/* Default PC counter to free-running */
@@ -1693,7 +1695,16 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, DA7219_TONE_GEN_CYCLES, DA7219_BEEP_CYCLES_MASK);
 
 	/* Initialise AAD block */
-	return da7219_aad_init(codec);
+	ret = da7219_aad_init(codec);
+	if (ret)
+		goto err_disable_reg;
+
+	return 0;
+
+err_disable_reg:
+	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
+
+	return ret;
 }
 
 static int da7219_remove(struct snd_soc_codec *codec)
-- 
1.9.3
