From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items" to the asoc tree
Date: Thu,  2 May 2019 03:18:02 +0100 (BST)
Message-ID: <20190502021802.767DF441D3F@finisterre.ee.mobilebroadband>
References: <20190429123713.64280-1-weiyongjun1@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429123713.64280-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 81a812c98b6eda7e3101305d57354433e3edc541 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 29 Apr 2019 12:37:13 +0000
Subject: [PATCH] ASoC: sprd: Fix to use list_for_each_entry_safe() when delete
 items

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each_entry() macro aptly named
list_for_each_entry_safe().

Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-mcdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index e9318d7a4810..7448015a4935 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -978,12 +978,12 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 
 static int sprd_mcdt_remove(struct platform_device *pdev)
 {
-	struct sprd_mcdt_chan *temp;
+	struct sprd_mcdt_chan *chan, *temp;
 
 	mutex_lock(&sprd_mcdt_list_mutex);
 
-	list_for_each_entry(temp, &sprd_mcdt_chan_list, list)
-		list_del(&temp->list);
+	list_for_each_entry_safe(chan, temp, &sprd_mcdt_chan_list, list)
+		list_del(&chan->list);
 
 	mutex_unlock(&sprd_mcdt_list_mutex);
 
-- 
2.20.1
