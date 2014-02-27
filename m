From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/3] ASoC: io: Clean up
	snd_soc_codec_set_cache_io()
Date: Thu, 27 Feb 2014 17:49:51 +0800
Message-ID: <1393494593-26310-2-git-send-email-Li.Xiubo@freescale.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B377261737
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 11:55:38 +0100 (CET)
In-Reply-To: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
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
Cc: Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Now that all users have been converted to regmap and the config.reg_bits
and config.val_bits can be setted by each user through regmap core API.
So these two params are redundant here.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index add99e2..18353f1 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -88,16 +88,11 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control)
 {
-	struct regmap_config config;
 	int ret;
 
-	memset(&config, 0, sizeof(config));
 	codec->write = hw_write;
 	codec->read = hw_read;
 
-	config.reg_bits = addr_bits;
-	config.val_bits = data_bits;
-
 	switch (control) {
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
-- 
1.8.4
