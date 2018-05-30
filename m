From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: unhide snd_soc_new_compress() declaration
Date: Thu, 31 May 2018 00:06:03 +0200
Message-ID: <20180530220628.1613824-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 940EB2677D4
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 00:06:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

My randconfig build setup came across a new build failure today:

sound/soc/soc-topology.c: In function 'soc_tplg_dai_create':
sound/soc/soc-topology.c:1758:27: error: 'snd_soc_new_compress' undeclared (first use in this function); did you mean 'snd_soc_compr_ops'?
   dai_drv->compress_new = snd_soc_new_compress;

Simply making that prototype visible again fixes the build failure
for me, though I'm not exactly sure why we don't get a link
error now.

The reference to snd_soc_new_compress() was added a few weeks
ago and seems to have caused the problem.

Fixes: 5db6aab6f36f ("ASoC: topology: Add support for compressed PCMs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/soc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 600a7ebd10c0..8e073865bde3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -460,9 +460,7 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name);
 
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
-#ifdef CONFIG_SND_SOC_COMPRESS
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
-#endif
 
 void snd_soc_disconnect_sync(struct device *dev);
 
-- 
2.9.0
