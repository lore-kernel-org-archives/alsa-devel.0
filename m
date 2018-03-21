From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt2701: Fix a typo in printk"
	to the asoc tree
Date: Wed, 21 Mar 2018 01:33:31 +0000 (GMT)
Message-ID: <20180321013331.3344844007A@finisterre.ee.mobilebroadband>
References: <20180320123309.12333-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BF73267219
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 02:33:34 +0100 (CET)
In-Reply-To: <20180320123309.12333-1-standby24x7@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt2701: Fix a typo in printk

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

>From 9260f873684fb1cfb9ea10a10be3e8b888da3c0e Mon Sep 17 00:00:00 2001
From: Masanari Iida <standby24x7@gmail.com>
Date: Tue, 20 Mar 2018 21:33:09 +0900
Subject: [PATCH] ASoC: mediatek: mt2701: Fix a typo in printk

This patch fixes a spelling typo in printk

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d68b53f7cefe..e96028c06557 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -336,7 +336,7 @@ static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
 	stream_fs = params_rate(params);
 
 	if ((stream_fs != 8000) && (stream_fs != 16000)) {
-		dev_err(afe->dev, "%s() btmgr not supprt this stream_fs %d\n",
+		dev_err(afe->dev, "%s() btmgr not support this stream_fs %d\n",
 			__func__, stream_fs);
 		return -EINVAL;
 	}
-- 
2.16.2
