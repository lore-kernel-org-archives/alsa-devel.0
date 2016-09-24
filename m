From: pengdonglin137 <pengdonglin137@163.com>
Subject: A small bug in soc-pcm.c
Date: Sat, 24 Sep 2016 09:53:18 +0800 (CST)
Message-ID: <2427cb7f.ab0.15759e58bdd.Coremail.pengdonglin137@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m13-15.163.com (m13-15.163.com [220.181.13.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA0626048C
 for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2016 03:53:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi All,
I found a small bug in soc-pcm.c. For example, we can see kernel logs as follows:

[  518.707401]  SLIMBUS_0_TX: ASoC: trigger BE MSM8996 Media1 cmd 0    // should be SLIMBUS_0_TX other than MSM8996 Media1
[  518.707414]  MSM8996 Media1: ASoC: post trigger FE MSM8996 Media1 cmd 0

Here is the patch.

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 60d702f..8c037ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1790,7 +1790,7 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
             continue;
 
         dev_dbg(be->dev, "ASoC: close BE %s\n",
-            dpcm->fe->dai_link->name);
+            dpcm->be->dai_link->name);
 
         soc_pcm_close(be_substream);
         be_substream->runtime = NULL;
@@ -1856,7 +1856,7 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
             continue;
 
         dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
-            dpcm->fe->dai_link->name);
+            dpcm->be->dai_link->name);
 
         soc_pcm_hw_free(be_substream);
 
@@ -1934,7 +1934,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
             continue;
 
         dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
-            dpcm->fe->dai_link->name);
+            dpcm->be->dai_link->name);
 
         ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
         if (ret < 0) {
@@ -2014,7 +2014,7 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
     int ret;
 
     dev_dbg(dpcm->be->dev, "ASoC: trigger BE %s cmd %d\n",
-            dpcm->fe->dai_link->name, cmd);
+            dpcm->be->dai_link->name, cmd);
 
     ret = soc_pcm_trigger(substream, cmd);
     if (ret < 0)
@@ -2229,7 +2229,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
             continue;
 
         dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-            dpcm->fe->dai_link->name);
+            dpcm->be->dai_link->name);
 
         ret = soc_pcm_prepare(be_substream);
         if (ret < 0) {

Thanks,
Donglin Peng
