From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ALSA: snd-aloop: make preallocated buffer size
	configurable
Date: Tue, 20 Sep 2011 14:02:12 -0500
Message-ID: <1316545332-2229-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F4A510384C
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 21:02:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Default of 2MB of physically-contiguous memory can be
too high for embedded solutions, make the size configurable.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/drivers/Kconfig |   15 +++++++++++++++
 sound/drivers/aloop.c |    6 +++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index c896116..ad51067 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -93,6 +93,21 @@ config SND_ALOOP
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-aloop.
 
+if SND_ALOOP
+config SND_ALOOP_PREALLOC_SIZE
+	int "Pre-allocated buffer size for aloop driver"
+	range 0 32768
+	default 2048
+	help
+	  Specifies the default pre-allocated buffer-size in kB for the
+	  snd-aloop driver. The default 2048 is chosen just
+	  for compatibility reasons. Some distributions may want to
+	  use a smaller size when only one stream is used.
+
+	  Note that the pre-allocation size can be changed dynamically
+	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
+endif
+
 config SND_VIRMIDI
 	tristate "Virtual MIDI soundcard"
 	depends on SND_SEQUENCER
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index a0da775..f945573 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -556,11 +556,11 @@ static struct snd_pcm_hardware loopback_pcm_hardware =
 	.rate_max =		192000,
 	.channels_min =		1,
 	.channels_max =		32,
-	.buffer_bytes_max =	2 * 1024 * 1024,
+	.buffer_bytes_max =	CONFIG_SND_ALOOP_PREALLOC_SIZE * 1024,
 	.period_bytes_min =	64,
 	/* note check overflow in frac_pos() using pcm_rate_shift before
 	   changing period_bytes_max value */
-	.period_bytes_max =	1024 * 1024,
+	.period_bytes_max =     CONFIG_SND_ALOOP_PREALLOC_SIZE * 1024,
 	.periods_min =		1,
 	.periods_max =		1024,
 	.fifo_size =		0,
@@ -774,7 +774,7 @@ static int __devinit loopback_pcm_new(struct loopback *loopback,
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 			snd_dma_continuous_data(GFP_KERNEL),
-			0, 2 * 1024 * 1024);
+			0, CONFIG_SND_ALOOP_PREALLOC_SIZE * 1024);
 	return 0;
 }
 
-- 
1.7.6
