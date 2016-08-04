From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8825: fix static check error
	about semaphone control
Date: Thu, 4 Aug 2016 16:52:07 +0800
Message-ID: <1470300727-19998-2-git-send-email-KCHSU0@nuvoton.com>
References: <1470300727-19998-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 995A72657B1
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 10:52:30 +0200 (CEST)
In-Reply-To: <1470300727-19998-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The patch is to fix the static check error as the following.

The patch commit b50455fab459 ("ASoC: nau8825: cross talk suppression
measurement function") from Jun 7, 2016, leads to the following
static checker warning:

	sound/soc/codecs/nau8825.c:265 nau8825_sema_acquire()
	warn: 'sem:&nau8825->xtalk_sem' is sometimes locked here and
	sometimes unlocked.

The semaphone acquire function has return value, and some callers
can do error handling when lock fails.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 20d2f15..2e59a85 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -225,19 +225,26 @@ static const unsigned short logtable[256] = {
  * Acquires the semaphore without jiffies. If no more tasks are allowed
  * to acquire the semaphore, calling this function will put the task to
  * sleep until the semaphore is released.
- * It returns if the semaphore was acquired.
+ * If the semaphore is not released within the specified number of jiffies,
+ * this function returns -ETIME.
+ * If the sleep is interrupted by a signal, this function will return -EINTR.
+ * It returns 0 if the semaphore was acquired successfully.
  */
-static void nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
+static int nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
 {
 	int ret;
 
-	if (timeout)
+	if (timeout) {
 		ret = down_timeout(&nau8825->xtalk_sem, timeout);
-	else
+		if (ret < 0)
+			dev_warn(nau8825->dev, "Acquire semaphone timeout\n");
+	} else {
 		ret = down_interruptible(&nau8825->xtalk_sem);
+		if (ret < 0)
+			dev_warn(nau8825->dev, "Acquire semaphone fail\n");
+	}
 
-	if (ret < 0)
-		dev_warn(nau8825->dev, "Acquire semaphone fail\n");
+	return ret;
 }
 
 /**
@@ -1596,8 +1603,11 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 					 * cess and restore changes if process
 					 * is ongoing when ejection.
 					 */
+					int ret;
 					nau8825->xtalk_protect = true;
-					nau8825_sema_acquire(nau8825, 0);
+					ret = nau8825_sema_acquire(nau8825, 0);
+					if (ret < 0)
+						nau8825->xtalk_protect = false;
 				}
 				/* Startup cross talk detection process */
 				nau8825->xtalk_state = NAU8825_XTALK_PREPARE;
@@ -2223,11 +2233,14 @@ static int __maybe_unused nau8825_suspend(struct snd_soc_codec *codec)
 static int __maybe_unused nau8825_resume(struct snd_soc_codec *codec)
 {
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	regcache_cache_only(nau8825->regmap, false);
 	regcache_sync(nau8825->regmap);
 	nau8825->xtalk_protect = true;
-	nau8825_sema_acquire(nau8825, 0);
+	ret = nau8825_sema_acquire(nau8825, 0);
+	if (ret < 0)
+		nau8825->xtalk_protect = false;
 	enable_irq(nau8825->irq);
 
 	return 0;
-- 
2.6.4
