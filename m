From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 1/2] ALSA: pcm: introduce ACK_APPLPTR
	flag and bump up interface version to 2.0.14
Date: Mon, 19 Jun 2017 01:49:20 +0900
Message-ID: <20170618164921.9881-3-o-takashi@sakamocchi.jp>
References: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id BEF83266AE2
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 18:49:25 +0200 (CEST)
In-Reply-To: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: vinod.koul@intel.com, subhransu.s.prusty@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

In a development period for v4.13, it's clear that there's a type of
devices which demand userspace applications to change their behaviour.
These devices can take care of application-side pointer on PCM buffer
for their data transmission. As a result, these devices achieve some
advantages. For these devices, drivers need to get feedback about
current position of the pointer from applications when they
queue/dequeue PCM frames on the buffer.

When applications operates with SNDRV_PCM_IOCTL_[READ|WRITE][N|I] command
for ioctl(2) to transmit/receive PCM frames, the above is achieved with
an assist of ALSA PCM core. On the other hand, when applications run with
mmap operations, the above is not achieved. In this case, they should call
ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR after operating any PCM frames on
the buffer. But existent applications are not programmed to do it.

This commit adds a new flag; SNDRV_PCM_INFO_ACK_APPLPTR. When
applications find this flag on 'struct snd_pcm_hw_params.info', they're
expected to perform as the above. When programmed so, they should set
SNDRV_PCM_HW_PARAMS_ACK_APPLPTR flag to the structure in advance. Else,
they're not allowed to do mmap operation. This is for backward
compatibility because existent stuffs in user land don't perform like
the above.

As of this type of device, digital signal processor (DSP) integrated
to Intel's processor is reported. The DSP can prefetch the PCM frames on
the buffer and go to a deep sleep mode till next awakening. The awakening
is done by drivers. When applications deliver information about the number
of handled PCM frames to a corresponding driver in kernel land, then the
driver calculates according to the number, then awakens the DSP from the
sleep.

Additionally, there's two types of devices which potentially receive
advantages from this change. One is packet-oriented drivers, and another
is drivers with ALSA indirect layer. The former may process packets
immediately in process context when handling the feedback. This results
in reduction of audio latency. The latter may copy PCM frames in process
context. This results in reduction CPU time on any interrupt context.

Anyway, this flag requires userspace applications to change their
behaviour. This commit bumps up interface version to v2.0.14.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/asound.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index fb8d7d7e..dc367cf0 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -152,7 +152,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 13)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -268,6 +268,8 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
 #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
 #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
+/* Driver/hardware acknowledge current appl_ptr for specific purposes. */
+#define SNDRV_PCM_INFO_ACK_APPLPTR	0x00000012
 #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
 #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
 #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
@@ -365,6 +367,13 @@ typedef int snd_pcm_hw_param_t;
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
 #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
+/*
+ * When applications are programmed to execute ioctl(2) with
+ * SNDRV_PCM_IOCTL_SYNC_PTR for notification of current appl_ptr after handling
+ * any frames on mapped PCM buffer for driver/hardware with
+ * SNDRV_PCM_INFO_ACK_APPLPTR, this should be set.
+ */
+#define SNDRV_PCM_HW_PARAMS_ACK_APPLPTR	(1<<3)
 
 struct snd_interval {
 	unsigned int min, max;
-- 
2.11.0
