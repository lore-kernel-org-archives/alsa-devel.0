From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wcd9335: remove some unnecessary NULL
	checks" to the asoc tree
Date: Wed,  6 Feb 2019 16:58:16 +0000 (GMT)
Message-ID: <20190206165816.CA9E81127EA4@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B215267971
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:58:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wcd9335: remove some unnecessary NULL checks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d22b4117538d42f3dcf7e28210f07f968e46222e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 5 Feb 2019 12:09:27 +0300
Subject: [PATCH] ASoC: wcd9335: remove some unnecessary NULL checks

These are arrays, not pointers, and they can't be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
