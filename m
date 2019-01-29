From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] wcd9335: Remove unnecessary null checks in
	wcd9335_set_channel_map
Date: Tue, 29 Jan 2019 14:48:47 -0700
Message-ID: <20190129214847.6341-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB3F2674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 22:50:32 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id a20so17298796edc.8
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 13:50:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Clang warns:

sound/soc/codecs/wcd9335.c:2004:11: warning: address of array
'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->rx_chs) {
        ~~  ~~~~~^~~~~~
sound/soc/codecs/wcd9335.c:2012:11: warning: address of array
'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->tx_chs) {
        ~~  ~~~~~^~~~~~
2 warnings generated.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 3878187bb512..981f88a5f615 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2001,20 +2001,16 @@ static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	if (wcd->rx_chs) {
-		wcd->num_rx_port = rx_num;
-		for (i = 0; i < rx_num; i++) {
-			wcd->rx_chs[i].ch_num = rx_slot[i];
-			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
-		}
+	wcd->num_rx_port = rx_num;
+	for (i = 0; i < rx_num; i++) {
+		wcd->rx_chs[i].ch_num = rx_slot[i];
+		INIT_LIST_HEAD(&wcd->rx_chs[i].list);
 	}
 
-	if (wcd->tx_chs) {
-		wcd->num_tx_port = tx_num;
-		for (i = 0; i < tx_num; i++) {
-			wcd->tx_chs[i].ch_num = tx_slot[i];
-			INIT_LIST_HEAD(&wcd->tx_chs[i].list);
-		}
+	wcd->num_tx_port = tx_num;
+	for (i = 0; i < tx_num; i++) {
+		wcd->tx_chs[i].ch_num = tx_slot[i];
+		INIT_LIST_HEAD(&wcd->tx_chs[i].list);
 	}
 
 	return 0;
-- 
2.20.1
