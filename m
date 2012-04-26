From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: pcm: Add pcm operation for pcm ioctl.
Date: Thu, 26 Apr 2012 16:16:10 +0100
Message-ID: <1335453370-28020-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F42C10BB48
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 17:16:17 +0200 (CEST)
Received: by wibhm17 with SMTP id hm17so4705305wib.5
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 08:16:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Provide an ioctl marshaller for ASoC platform drivers.
This will use the default ALSA handler if no platform
handler exists.

This is also required for DPCM BE PCMs as snd_pcm_info()
will call the ioctl as part of stream startup.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5bd8270..4e3be82 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1647,6 +1647,17 @@ out:
 	return ret;
 }
 
+static int soc_pcm_ioctl(struct snd_pcm_substream *substream,
+		     unsigned int cmd, void *arg)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+
+	if (platform->driver->ops->ioctl)
+		return platform->driver->ops->ioctl(substream, cmd, arg);
+	return snd_pcm_lib_ioctl(substream, cmd, arg);
+}
+
 static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_pcm_substream *substream =
@@ -2051,6 +2062,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		rtd->ops.hw_free	= dpcm_fe_dai_hw_free;
 		rtd->ops.close		= dpcm_fe_dai_close;
 		rtd->ops.pointer	= soc_pcm_pointer;
+		rtd->ops.ioctl		= soc_pcm_ioctl;
 	} else {
 		rtd->ops.open		= soc_pcm_open;
 		rtd->ops.hw_params	= soc_pcm_hw_params;
@@ -2059,6 +2071,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		rtd->ops.hw_free	= soc_pcm_hw_free;
 		rtd->ops.close		= soc_pcm_close;
 		rtd->ops.pointer	= soc_pcm_pointer;
+		rtd->ops.ioctl		= soc_pcm_ioctl;
 	}
 
 	if (platform->driver->ops) {
-- 
1.7.5.4
