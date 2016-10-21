From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: samsung: i2s: Fixup last IRQ unsafe spin
	lock call
Date: Fri, 21 Oct 2016 14:18:48 +0100
Message-ID: <1477055928-11712-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 33B322671D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 15:18:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

Unfortunately, I seem to have missed a case where an IRQ safe spinlock was
required, in samsung_i2s_dai_remove, when I fixed up the other calls in
this patch:

316fa9e09ad7 ("ASoC: samsung: Use IRQ safe spin lock calls")

This causes a lockdep warning when unbinding and rebinding the audio card:

[  104.357664]        CPU0                    CPU1
[  104.362174]        ----                    ----
[  104.366692]   lock(&(&pri_dai->spinlock)->rlock);
[  104.371372]                                local_irq_disable();
[  104.377283]                                lock(&(&substream->self_group.lock)->rlock);
[  104.385259]                                lock(&(&pri_dai->spinlock)->rlock);
[  104.392469]   <Interrupt>
[  104.395072]     lock(&(&substream->self_group.lock)->rlock);
[  104.400710]
[  104.400710]  *** DEADLOCK ***

Fixes: ce8bcdbb61d9 ("ASoC: samsung: i2s: Protect more registers with a spinlock")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7e32cf4..588aa01 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1029,12 +1029,13 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned long flags;
 
 	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
-			spin_lock(i2s->lock);
+			spin_lock_irqsave(i2s->lock, flags);
 			writel(0, i2s->addr + I2SCON);
-			spin_unlock(i2s->lock);
+			spin_unlock_irqrestore(i2s->lock, flags);
 		}
 	}
 
-- 
2.1.4
