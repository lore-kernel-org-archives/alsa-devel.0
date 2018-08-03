From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/7] ASoC: davinci-i2s: mark expected switch
	fall-through
Date: Fri, 3 Aug 2018 11:28:24 -0500
Message-ID: <7c1e135b84edc1ae9c6b121794ee35b8e35ce7e3.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E9722677B0
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 18:29:04 +0200 (CEST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 0DC7195874B
 for <alsa-devel@alsa-project.org>;
 Fri,  3 Aug 2018 11:29:03 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1364478 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/davinci/davinci-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 807040b..a3206e65 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -340,6 +340,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 * rate is lowered.
 		 */
 		inv_fs = true;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		dev->mode = MOD_DSP_A;
 		break;
-- 
2.7.4
