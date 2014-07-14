From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] pcm: rate: fix hw_ptr exceed the boundary
Date: Mon, 14 Jul 2014 16:55:48 +0800
Message-ID: <1405328148-2270-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6652610D2
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 10:55:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For long time test case, the hw_ptr will exceed the boundary, then cause
the avail size wrong.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/pcm_rate.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 7f667d4..2563d82 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -574,6 +574,8 @@ static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
 	rate->hw_ptr =
 		(slave_hw_ptr / rate->gen.slave->period_size) * pcm->period_size +
 		rate->ops.input_frames(rate->obj, slave_hw_ptr % rate->gen.slave->period_size);
+
+	rate->hw_ptr %= pcm->boundary;
 }
 
 static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)
-- 
1.7.9.5
