From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: dmaengine: Correct Makefile when sound
	is built as module
Date: Mon,  1 Oct 2012 12:29:26 +0300
Message-ID: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog135.obsmtp.com (na3sys009aog135.obsmtp.com
 [74.125.149.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A35261708
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 11:28:22 +0200 (CEST)
Received: by oagn12 with SMTP id n12so5031518oag.38
 for <alsa-devel@alsa-project.org>; Mon, 01 Oct 2012 02:28:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

soc-dmaengine-pcm library need to be part of the snd-soc-core in order to
be able to compile ASoC as modules when dmaengine is enabled on the platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index bcbf1d0..99f32f7 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,8 +1,9 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o
 
-snd-soc-dmaengine-pcm-objs := soc-dmaengine-pcm.o
-obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) += snd-soc-dmaengine-pcm.o
+ifneq ($(CONFIG_SND_SOC_DMAENGINE_PCM),)
+snd-soc-core-objs += soc-dmaengine-pcm.o
+endif
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
-- 
1.7.12
