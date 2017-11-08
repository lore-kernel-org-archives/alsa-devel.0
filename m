From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 5/7] ASoC: wm8753: mark expected switch
	fall-throughs
Date: Wed, 8 Nov 2017 14:04:31 -0600
Message-ID: <2a3113ceca1b3f70258486038ed93cfbed70741c.1510170034.git.garsilva@embeddedor.com>
References: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.102])
 by alsa0.perex.cz (Postfix) with ESMTP id C52E926761D
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 21:04:38 +0100 (CET)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 8421A3DBA37
 for <alsa-devel@alsa-project.org>;
 Wed,  8 Nov 2017 14:04:37 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <cover.1510170034.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 146568
Addresses-Coverity-ID: 146569
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/wm8753.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index d05d76e..0271a52 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -971,7 +971,7 @@ static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec *codec,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ioctl |= 0x2;
+		ioctl |= 0x2; /* fall through */
 	case SND_SOC_DAIFMT_CBM_CFS:
 		voice |= 0x0040;
 		break;
@@ -1096,7 +1096,7 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ioctl |= 0x1;
+		ioctl |= 0x1; /* fall through */
 	case SND_SOC_DAIFMT_CBM_CFS:
 		hifi |= 0x0040;
 		break;
-- 
2.7.4
