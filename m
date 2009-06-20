From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: keep better track of SPORT
	configuration state
Date: Sat, 20 Jun 2009 11:29:05 -0400
Message-ID: <1245511745-19381-1-git-send-email-vapier@gentoo.org>
References: <0F1B54C89D5F954D8535DB252AF412FA04292614@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D415724474
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 17:29:24 +0200 (CEST)
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04292614@chinexm1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Do not let the SPORT be reconfigured until there are no more active
streams.  Then we can let the system reprogram the SPORT state.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 9648244..0e8af48 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -50,6 +50,7 @@ struct bf5xx_i2s_port {
 	u16 tcr2;
 	u16 rcr2;
 	int counter;
+	int configured;
 };
 
 static struct bf5xx_i2s_port bf5xx_i2s;
@@ -168,7 +169,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	if (bf5xx_i2s.counter == 1) {
+	if (!bf5xx_i2s.configured) {
 		/*
 		 * TX and RX are not independent,they are enabled at the
 		 * same time, even if only one side is running. So, we
@@ -177,6 +178,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		 *
 		 * CPU DAI:slave mode.
 		 */
+		bf5xx_i2s.configured = 1;
 		ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
 				      bf5xx_i2s.rcr2, 0, 0);
 		if (ret) {
@@ -200,6 +202,9 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 {
 	pr_debug("%s enter\n", __func__);
 	bf5xx_i2s.counter--;
+	/* No active stream, SPORT is allowed to be configured again. */
+	if (!bf5xx_i2s.counter)
+		bf5xx_i2s.configured = 0;
 }
 
 static int bf5xx_i2s_probe(struct platform_device *pdev,
-- 
1.6.3.1
