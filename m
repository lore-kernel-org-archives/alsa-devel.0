From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 13/16] ASoC: wm8958: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:09 +0530
Message-ID: <1403258352-8210-13-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B350261B1E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:03:03 +0200 (CEST)
Received: by mail-pb0-f41.google.com with SMTP id ma3so2946855pbc.14
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:03:03 -0700 (PDT)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Let memory subsystem handle the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index b2ebb104d879..0dada7f0105e 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -934,12 +934,8 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		/* We need an array of texts for the enum API */
 		wm8994->mbc_texts = kmalloc(sizeof(char *)
 					    * pdata->num_mbc_cfgs, GFP_KERNEL);
-		if (!wm8994->mbc_texts) {
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to allocate %d MBC config texts\n",
-				pdata->num_mbc_cfgs);
+		if (!wm8994->mbc_texts)
 			return;
-		}
 
 		for (i = 0; i < pdata->num_mbc_cfgs; i++)
 			wm8994->mbc_texts[i] = pdata->mbc_cfgs[i].name;
@@ -963,12 +959,8 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		/* We need an array of texts for the enum API */
 		wm8994->vss_texts = kmalloc(sizeof(char *)
 					    * pdata->num_vss_cfgs, GFP_KERNEL);
-		if (!wm8994->vss_texts) {
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to allocate %d VSS config texts\n",
-				pdata->num_vss_cfgs);
+		if (!wm8994->vss_texts)
 			return;
-		}
 
 		for (i = 0; i < pdata->num_vss_cfgs; i++)
 			wm8994->vss_texts[i] = pdata->vss_cfgs[i].name;
@@ -993,12 +985,8 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		/* We need an array of texts for the enum API */
 		wm8994->vss_hpf_texts = kmalloc(sizeof(char *)
 						* pdata->num_vss_hpf_cfgs, GFP_KERNEL);
-		if (!wm8994->vss_hpf_texts) {
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to allocate %d VSS HPF config texts\n",
-				pdata->num_vss_hpf_cfgs);
+		if (!wm8994->vss_hpf_texts)
 			return;
-		}
 
 		for (i = 0; i < pdata->num_vss_hpf_cfgs; i++)
 			wm8994->vss_hpf_texts[i] = pdata->vss_hpf_cfgs[i].name;
@@ -1024,12 +1012,8 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		/* We need an array of texts for the enum API */
 		wm8994->enh_eq_texts = kmalloc(sizeof(char *)
 						* pdata->num_enh_eq_cfgs, GFP_KERNEL);
-		if (!wm8994->enh_eq_texts) {
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to allocate %d enhanced EQ config texts\n",
-				pdata->num_enh_eq_cfgs);
+		if (!wm8994->enh_eq_texts)
 			return;
-		}
 
 		for (i = 0; i < pdata->num_enh_eq_cfgs; i++)
 			wm8994->enh_eq_texts[i] = pdata->enh_eq_cfgs[i].name;
-- 
1.7.9.5
