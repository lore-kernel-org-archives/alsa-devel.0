From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 07/10] ASoC: blackfin: bf5xx-ad1836: Use
	snd_soc_dai_set_tdm_slot_xlate()
Date: Wed, 26 Feb 2014 11:59:32 +0800
Message-ID: <1393387175-15539-8-git-send-email-Li.Xiubo@freescale.com>
References: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 12F922656AB
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:09:01 +0100 (CET)
In-Reply-To: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: fabio.estevam@freescale.com, moinejf@free.fr, alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, s.hauer@pengutronix.de, timur@tabi.org, linux-kernel@vger.kernel.org, denis@eukrea.com, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, mpa@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Use snd_soc_dai_set_tdm_slot_xlate instead of snd_soc_dai_set_tdm_slot.
This will use the default snd_soc_of_xlate_tdm_slot_mask to generate
the TDM slot TX/RX mask using the slot parameter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/blackfin/bf5xx-ad1836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 8fcfc4e..b1908ce 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -44,7 +44,7 @@ static int bf5xx_ad1836_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xFF, 0xFF, 8, 32);
+	ret = snd_soc_dai_set_tdm_slot_xlate(cpu_dai, 8, 32);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.4
