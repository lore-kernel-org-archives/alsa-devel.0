From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items
Date: Mon, 29 Apr 2019 12:37:13 +0000
Message-ID: <20190429123713.64280-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each_entry() macro aptly named
list_for_each_entry_safe().

Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sprd/sprd-mcdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 28f5e649733d..df250f7f2b6f 100644
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
