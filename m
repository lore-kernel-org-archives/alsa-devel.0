From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] linux-next: ASoC: mediatek: mt2701: Fix a typo
	in printk
Date: Tue, 20 Mar 2018 21:33:09 +0900
Message-ID: <20180320123309.12333-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B3DB26720A
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 13:33:16 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id x4-v6so862495pln.7
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 05:33:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a spelling typo in printk

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f7e0702d92f8..f2eb4c7f94e8 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -343,7 +343,7 @@ static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
 	stream_fs = params_rate(params);
 
 	if ((stream_fs != 8000) && (stream_fs != 16000)) {
-		dev_err(afe->dev, "%s() btmgr not supprt this stream_fs %d\n",
+		dev_err(afe->dev, "%s() btmgr not support this stream_fs %d\n",
 			__func__, stream_fs);
 		return -EINVAL;
 	}
-- 
2.16.2.520.gd0db9edba005
