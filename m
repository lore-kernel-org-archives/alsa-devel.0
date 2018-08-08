From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: adau1761: Mark expected switch
	fall-though
Date: Wed, 8 Aug 2018 14:22:13 -0500
Message-ID: <20180808192213.GA27872@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com
 [192.185.50.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 174632678C4
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 21:22:44 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 7832412303
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 14:22:43 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114879 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/adau1761.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index be136e9..bef3e9e 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
 			ARRAY_SIZE(adau1761_jack_detect_controls));
 		if (ret)
 			return ret;
-	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
+		/* fall through */
+	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
 		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
 			ARRAY_SIZE(adau1761_no_dmic_routes));
 		if (ret)
-- 
2.7.4
