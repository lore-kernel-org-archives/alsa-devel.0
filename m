From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 3/4 v2] pxa2xx-i2s: Fix inappropriate release
	of i2s clock
Date: Wed, 13 May 2009 22:16:52 +0200
Message-ID: <4A0B2AB4.4070505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 688BD10393A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 22:16:55 +0200 (CEST)
Received: by mail-ew0-f175.google.com with SMTP id 23so1093528ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 13:16:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

i2s_clk is 'put' for no reason in pxa2xx_i2s_shutdown.
Now we 'get' i2s_clk at probe and 'put' it at driver removal or when
probe fails.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index a461c8d..a423637 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -257,8 +257,6 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream
*substream,
 		pxa_i2s_wait();
 		clk_disable(clk_i2s);
 	}
-
-	clk_put(clk_i2s);
 }

 #ifdef CONFIG_PM
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
