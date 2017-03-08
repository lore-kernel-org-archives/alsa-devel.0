From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: fix getting wrong work handler
	container
Date: Wed, 8 Mar 2017 19:03:10 +0800
Message-ID: <1488970990-18967-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B63F266927
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:03:33 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We got rt5665 private data from wrong work. It will result in kernel
panic.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index c866502..a0c1d9a 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1241,7 +1241,7 @@ static irqreturn_t rt5665_irq(int irq, void *data)
 static void rt5665_jd_check_handler(struct work_struct *work)
 {
 	struct rt5665_priv *rt5665 = container_of(work, struct rt5665_priv,
-		calibrate_work.work);
+		jd_check_work.work);
 
 	if (snd_soc_read(rt5665->codec, RT5665_AJD1_CTRL) & 0x0010) {
 		/* jack out */
-- 
2.7.4
