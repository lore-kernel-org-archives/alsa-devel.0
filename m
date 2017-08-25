From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: pcm: Sync delayed work before releasing
	resources
Date: Fri, 25 Aug 2017 12:04:07 +0200
Message-ID: <20170825100407.5640-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4772B266EA7
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 12:04:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

When ASoC driver is unbound dynamically during its operation (i.e. a
kind of hot-unplug), we may hit Oops due to the resource access after
the release by a delayed work, something like:

  Unable to handle kernel paging request at virtual address dead000000000220
  ....
  PC is at soc_dapm_dai_stream_event.isra.14+0x20/0xd0
  LR is at snd_soc_dapm_stream_event+0x74/0xa8
  ....
  [<ffff000008715610>] soc_dapm_dai_stream_event.isra.14+0x20/0xd0
  [<ffff00000871989c>] snd_soc_dapm_stream_event+0x74/0xa8
  [<ffff00000871b23c>] close_delayed_work+0x3c/0x50
  [<ffff0000080bbd6c>] process_one_work+0x1ac/0x318
  [<ffff0000080bbf20>] worker_thread+0x48/0x420
  [<ffff0000080c201c>] kthread+0xfc/0x128
  [<ffff0000080842f0>] ret_from_fork+0x10/0x18

For fixing the race, this patch adds a sync-point in pcm private_free
callback to finish the delayed work before actually releasing the
resources.

Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-pcm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 94b88b897c3b..c0f0b09cb433 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2632,6 +2632,17 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	return ret;
 }
 
+static void soc_pcm_private_free(struct snd_pcm *pcm)
+{
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+
+	/* need to sync the delayed work before releasing resources */
+	flush_delayed_work(&rtd->delayed_work);
+	if (platform->driver->pcm_free)
+		platform->driver->pcm_free(pcm);
+}
+
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
@@ -2757,7 +2768,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		}
 	}
 
-	pcm->private_free = platform->driver->pcm_free;
+	pcm->private_free = soc_pcm_private_free;
 out:
 	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
 		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
-- 
2.14.0
