From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 03/10] ASoC: blackfin: bf5xx-sport:
	Allow setting rx and tx mask independently
Date: Tue, 28 May 2013 19:22:11 +0200
Message-ID: <1369761738-29503-3-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Since the hardware supports it there is no need to artificially limit this to
just being able to set the same mask for both tx and rx.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/bf5xx-ac97.c  |  8 ++++----
 sound/soc/blackfin/bf5xx-sport.c | 10 +++++-----
 sound/soc/blackfin/bf5xx-sport.h |  2 +-
 sound/soc/blackfin/bf5xx-tdm.c   |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 4902173..c66bef8 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -231,9 +231,9 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 		return 0;
 
 #if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
-	ret = sport_set_multichannel(sport, 16, 0x3FF, 1);
+	ret = sport_set_multichannel(sport, 16, 0x3FF, 0x3FF, 1);
 #else
-	ret = sport_set_multichannel(sport, 16, 0x1F, 1);
+	ret = sport_set_multichannel(sport, 16, 0x1F, 0x1F, 1);
 #endif
 	if (ret) {
 		pr_err("SPORT is busy!\n");
@@ -311,9 +311,9 @@ static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 
 	/*SPORT works in TDM mode to simulate AC97 transfers*/
 #if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
-	ret = sport_set_multichannel(sport_handle, 16, 0x3FF, 1);
+	ret = sport_set_multichannel(sport_handle, 16, 0x3FF, 0x3FF, 1);
 #else
-	ret = sport_set_multichannel(sport_handle, 16, 0x1F, 1);
+	ret = sport_set_multichannel(sport_handle, 16, 0x1F, 0x1F, 1);
 #endif
 	if (ret) {
 		pr_err("SPORT is busy!\n");
diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 2fd9f2a..6953512 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -46,10 +46,10 @@
 /* note: multichannel is in units of 8 channels,
  * tdm_count is # channels NOT / 8 ! */
 int sport_set_multichannel(struct sport_device *sport,
-		int tdm_count, u32 mask, int packed)
+		int tdm_count, u32 tx_mask, u32 rx_mask, int packed)
 {
-	pr_debug("%s tdm_count=%d mask:0x%08x packed=%d\n", __func__,
-			tdm_count, mask, packed);
+	pr_debug("%s tdm_count=%d tx_mask:0x%08x rx_mask:0x%08x packed=%d\n",
+			__func__, tdm_count, tx_mask, rx_mask, packed);
 
 	if ((sport->regs->tcr1 & TSPEN) || (sport->regs->rcr1 & RSPEN))
 		return -EBUSY;
@@ -65,8 +65,8 @@ int sport_set_multichannel(struct sport_device *sport,
 		sport->regs->mcmc2 = FRAME_DELAY | MCMEN | \
 				(packed ? (MCDTXPE|MCDRXPE) : 0);
 
-		sport->regs->mtcs0 = mask;
-		sport->regs->mrcs0 = mask;
+		sport->regs->mtcs0 = tx_mask;
+		sport->regs->mrcs0 = rx_mask;
 		sport->regs->mtcs1 = 0;
 		sport->regs->mrcs1 = 0;
 		sport->regs->mtcs2 = 0;
diff --git a/sound/soc/blackfin/bf5xx-sport.h b/sound/soc/blackfin/bf5xx-sport.h
index 5ab60bd..9fc2192 100644
--- a/sound/soc/blackfin/bf5xx-sport.h
+++ b/sound/soc/blackfin/bf5xx-sport.h
@@ -128,7 +128,7 @@ void sport_done(struct sport_device *sport);
 /* note: multichannel is in units of 8 channels, tdm_count is number of channels
  *  NOT / 8 ! all channels are enabled by default */
 int sport_set_multichannel(struct sport_device *sport, int tdm_count,
-		u32 mask, int packed);
+		u32 tx_mask, u32 rx_mask, int packed);
 
 int sport_config_rx(struct sport_device *sport,
 		unsigned int rcr1, unsigned int rcr2,
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 69e9a3e..aa08516 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -198,7 +198,7 @@ static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 	int ret;
 	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
-	ret = sport_set_multichannel(sport, 8, 0xFF, 1);
+	ret = sport_set_multichannel(sport, 8, 0xFF, 0xFF, 1);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
@@ -265,7 +265,7 @@ static int bfin_tdm_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* SPORT works in TDM mode */
-	ret = sport_set_multichannel(sport_handle, 8, 0xFF, 1);
+	ret = sport_set_multichannel(sport_handle, 8, 0xFF, 0xFF, 1);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
-- 
1.8.0
