From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH] ASoC: ab8500: remove the useless 'break' after
	'return'
Date: Tue, 19 Jan 2016 11:13:12 +0800
Message-ID: <1453173192-8350-1-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AEF42604D6
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 04:12:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Xiubo Li <lixiubo@cmss.chinamobile.com>
List-Id: alsa-devel@alsa-project.org

'break' here is not useful after 'return' or 'goto'.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
---
 sound/soc/codecs/ab8500-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index affb192..b6820a1 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2134,7 +2134,6 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
 			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
 		return -EINVAL;
-		break;
 	}
 
 	snd_soc_update_bits(codec, AB8500_DIGIFCONF3, mask, val);
-- 
1.8.3.1
