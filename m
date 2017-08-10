From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: compress: Delete error messages for a
 failed memory allocation in snd_soc_new_compress()
Date: Thu, 10 Aug 2017 16:26:23 +0200
Message-ID: <f9abf5ea-0284-ba87-9f22-2111d8631dfa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id D0BE62665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 16:26:45 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 16:21:34 +0200

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-compress.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36bf43e8..6c867d50e036 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -764,15 +764,12 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		direction = SND_COMPRESS_CAPTURE;
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
-	if (compr == NULL) {
-		snd_printk(KERN_ERR "Cannot allocate compr\n");
+	if (!compr)
 		return -ENOMEM;
-	}
 
 	compr->ops = devm_kzalloc(rtd->card->dev, sizeof(soc_compr_ops),
 				  GFP_KERNEL);
-	if (compr->ops == NULL) {
-		dev_err(rtd->card->dev, "Cannot allocate compressed ops\n");
+	if (!compr->ops) {
 		ret = -ENOMEM;
 		goto compr_err;
 	}
-- 
2.14.0
