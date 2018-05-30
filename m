From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: mediatek: export mtk-afe symbols as
	needed
Date: Thu, 31 May 2018 00:00:35 +0200
Message-ID: <20180530220057.1419933-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB6C2677D1
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 00:01:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The new mt6797-afe driver uses some functions in a common file, which
works for a built-in driver but fails for a loadable module:

ERROR: "mtk_afe_pcm_free" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_add_sub_dai_control" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_new" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_combine_sub_dai" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_ops" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!

This exports the five symbols above for modules.

Fixes: b3c702f56bf5 ("ASoC: mt6797: combine DAI to register component")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 00618587ef1e..51ec4ff6ed95 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -57,6 +57,7 @@ int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_afe_combine_sub_dai);
 
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 {
@@ -90,6 +91,7 @@ int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(mtk_afe_add_sub_dai_control);
 
 static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
@@ -130,6 +132,7 @@ const struct snd_pcm_ops mtk_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
 	.pointer = mtk_afe_pcm_pointer,
 };
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_ops);
 
 int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
@@ -143,11 +146,13 @@ int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     afe->dev,
 						     size, size);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
 void mtk_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_free);
 
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name = AFE_PCM_NAME,
-- 
2.9.0
