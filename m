From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 04/11] ASoC: wm8955: Mark expected switch
	fall-through
Date: Wed, 1 Aug 2018 14:51:18 -0500
Message-ID: <7d2ee577e6a132b8a29663ea11ca1e449d1951bd.1533151956.git.gustavo@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.46.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 049232677DA
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 21:51:19 +0200 (CEST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 404C19BFB
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 14:51:19 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <cover.1533151956.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115047 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8955.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index ba44e3d..cd204f7 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -686,6 +686,7 @@ static int wm8955_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif |= WM8955_LRP;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif |= 0x3;
 		break;
-- 
2.7.4
