From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc3][PATCH] OMAP: ASoC: Fix spinlock misuse in
	omap-pcm.c
Date: Mon,  2 Feb 2009 14:20:46 +0200
Message-ID: <1233577246-21969-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BE1FB24448
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 13:20:51 +0100 (CET)
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com
	[10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	n12CJqgw024578
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2009 06:20:48 -0600
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

omap_pcm_trigger is called also in interrupt context so CPU flags must
be restored when returning.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index b0362df..dd3bb29 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -175,9 +175,10 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct omap_runtime_data *prtd = runtime->private_data;
+	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irq(&prtd->lock);
+	spin_lock_irqsave(&prtd->lock, flags);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -195,7 +196,7 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		ret = -EINVAL;
 	}
-	spin_unlock_irq(&prtd->lock);
+	spin_unlock_irqrestore(&prtd->lock, flags);
 
 	return ret;
 }
-- 
1.5.6.5
