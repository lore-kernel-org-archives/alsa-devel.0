From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH] Sound: MSM soc : imported alsa for the MSM
	from codeaurora
Date: Sun,  8 Nov 2009 23:46:10 +0100
Message-ID: <1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
References: <1257435101.25623.1.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.4.4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id F122A103811
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 21:47:59 +0100 (CET)
In-Reply-To: <1257435101.25623.1.camel@localhost>
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
Cc: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------1.6.4.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: quoted-printable


I had to make two little change to make it compile:
snd_ep =3D msm_rpc_connect_compatible(snd_rpc_ids.prog,
became:
snd_ep =3D msm_rpc_connect(snd_rpc_ids.prog,
and I also changed snd_rpc_ids.vers(with ifdefs)
to a known and working magick number:

I also had to change from ARCH_MSM_ARM11 to ARCH_MSM in the configuration

it still has serious runtime problems such as:
*Can produce kernel oops under theses conditions:
 start alsamixer and if the second bar is on 0 or 4,
 so it can play music with aplay,then increase the routing alsamixer bar
 to the max.
 Then decrease the routing bar to 4 or less
 Then It may have a null pointer problem
 That bug could be because it tries to route to route to speakers and
 handset at the same time(SND_DEVICE_HEADSET_AND_SPEAKER in android):
 that is to say it could be the same bug than here:
http://gitorious.org/replicant/msm7k/commit/370d37a088368ca8cc478e76c928a=
1ce6589495e
 but I need time to verify that
*can pannick(reboots the phone) if you send things to /dev/dsp when the
 oss emulation is activated
*only aplay works(mplayer,gstreamer don't work) for mplayer an ioctl
 didn't return...so it get stuck before playing.
 The explanation of the bug can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022697=
.html

Note the following things:
*this patch depends on,and doesn't contain arch/arm/mach-msm/qdsp5
*I removed the support for more recents chips because of code-size issue
 in a mailing list

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/Kconfig         |    1 +
 sound/soc/Makefile        |    1 +
 sound/soc/msm/Kconfig     |   23 ++
 sound/soc/msm/Makefile    |   11 +
 sound/soc/msm/msm-dai.c   |  143 ++++++++++
 sound/soc/msm/msm-pcm.c   |  643 +++++++++++++++++++++++++++++++++++++++=
++++++
 sound/soc/msm/msm-pcm.h   |  200 ++++++++++++++
 sound/soc/msm/msm7201.c   |  337 ++++++++++++++++++++++++
 sound/soc/msm/msm7k-pcm.c |  574 +++++++++++++++++++++++++++++++++++++++=
+
 9 files changed, 1933 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/msm/Kconfig
 create mode 100644 sound/soc/msm/Makefile
 create mode 100644 sound/soc/msm/msm-dai.c
 create mode 100644 sound/soc/msm/msm-pcm.c
 create mode 100644 sound/soc/msm/msm-pcm.h
 create mode 100644 sound/soc/msm/msm7201.c
 create mode 100644 sound/soc/msm/msm7k-pcm.c


--------------1.6.4.4
Content-Type: text/x-patch; name="0001-Sound-MSM-soc-imported-alsa-for-the-MSM-from-codeaur.patch"
Content-Disposition: inline; filename="0001-Sound-MSM-soc-imported-alsa-for-the-MSM-from-codeaur.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index ef025c6..4b1a48f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -32,6 +32,7 @@ source "sound/soc/omap/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/msm/Kconfig"
=20
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 86a9b1f..ea754e5 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SND_SOC)	+=3D omap/
 obj-$(CONFIG_SND_SOC)	+=3D pxa/
 obj-$(CONFIG_SND_SOC)	+=3D s3c24xx/
 obj-$(CONFIG_SND_SOC)	+=3D sh/
+obj-$(CONFIG_SND_SOC)	+=3D msm/
diff --git a/sound/soc/msm/Kconfig b/sound/soc/msm/Kconfig
new file mode 100644
index 0000000..70f2f76
--- /dev/null
+++ b/sound/soc/msm/Kconfig
@@ -0,0 +1,23 @@
+menu "MSM SoC Audio support"
+
+config SND_MSM_SOC
+	tristate "SoC Audio for the MSM series chips"
+	depends on ARCH_MSM && SND_SOC
+	select MSM_ADSP
+	help
+	  To add support for ALSA PCM driver for MSM board.
+
+config SND_MSM_DAI_SOC
+	tristate "SoC CPU/CODEC DAI for the MSM chip"
+	depends on SND_MSM_SOC || SND_QSD_SOC
+	help
+	 To add support for ALSA PCM driver for MSM board.
+
+config SND_MSM_SOC_MSM7K
+        tristate "SoC Audio support for MSM7K"
+        depends on SND_MSM_SOC
+        help
+	 To add support for SoC audio on msm7k for msm72x1 or msm7x27
+
+
+endmenu
diff --git a/sound/soc/msm/Makefile b/sound/soc/msm/Makefile
new file mode 100644
index 0000000..d2b38d3
--- /dev/null
+++ b/sound/soc/msm/Makefile
@@ -0,0 +1,11 @@
+# MSM CPU/CODEC DAI Support
+snd-soc-msm-dai-objs :=3D msm-dai.o
+obj-$(CONFIG_SND_MSM_DAI_SOC) +=3D snd-soc-msm-dai.o
+
+# MSM Platform Support
+snd-soc-msm-objs :=3D msm-pcm.o msm7k-pcm.o
+obj-$(CONFIG_SND_MSM_SOC) +=3D snd-soc-msm.o
+
+# MSM Machine Support
+snd-soc-msm7k-objs :=3D msm7201.o
+obj-$(CONFIG_SND_MSM_SOC_MSM7K) +=3D snd-soc-msm7k.o
diff --git a/sound/soc/msm/msm-dai.c b/sound/soc/msm/msm-dai.c
new file mode 100644
index 0000000..564e7fe
--- /dev/null
+++ b/sound/soc/msm/msm-dai.c
@@ -0,0 +1,143 @@
+/* sound/soc/msm/msm-dai.c
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2008 HTC Corporation
+ * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * Derived from msm-pcm.c and msm7201.c.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * See the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can find it at http://www.fsf.or=
g.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include "msm-pcm.h"
+
+struct snd_soc_dai msm_dais[] =3D {
+{
+	.name =3D "CODEC_DAI",
+	.playback =3D {
+		.stream_name =3D "Playback",
+		.channels_min =3D USE_CHANNELS_MIN,
+		.channels_max =3D USE_CHANNELS_MAX,
+		.rates =3D USE_RATE,
+		.rate_min =3D USE_RATE_MIN,
+		.rate_max =3D USE_RATE_MAX,
+		.formats =3D USE_FORMATS,
+	},
+	.capture =3D {
+		.stream_name =3D "Capture",
+		.channels_min =3D USE_CHANNELS_MIN,
+		.channels_max =3D USE_CHANNELS_MAX,
+		.rate_min =3D USE_RATE_MIN,
+		.rates =3D USE_RATE,
+		.formats =3D USE_FORMATS,
+	},
+},
+{
+	.name =3D "CPU_DAI",
+	.id =3D 0,
+	.playback =3D {
+		.channels_min =3D USE_CHANNELS_MIN,
+		.channels_max =3D USE_CHANNELS_MAX,
+		.rates =3D USE_RATE,
+		.rate_min =3D USE_RATE_MIN,
+		.rate_max =3D USE_RATE_MAX,
+		.formats =3D USE_FORMATS,
+	},
+	.capture =3D {
+		.channels_min =3D USE_CHANNELS_MIN,
+		.channels_max =3D USE_CHANNELS_MAX,
+		.rate_min =3D USE_RATE_MIN,
+		.rates =3D USE_RATE,
+		.formats =3D USE_FORMATS,
+	},
+},
+};
+EXPORT_SYMBOL_GPL(msm_dais);
+
+int msm_pcm_probe(struct platform_device *devptr)
+{
+	struct snd_card *card;
+	struct snd_soc_codec *codec;
+	int ret;
+
+	struct snd_soc_device *socdev =3D platform_get_drvdata(devptr);
+
+	printk(KERN_ERR "msm_soc: create pcms\n");
+	codec =3D kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec =3D=3D NULL)
+		return -ENOMEM;
+
+	codec->name =3D "MSM-CARD";
+	codec->owner =3D THIS_MODULE;
+	socdev->codec =3D codec;
+	mutex_init(&codec->mutex);
+
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	/* register pcms */
+	ret =3D snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1=
);
+	if (ret < 0) {
+		printk(KERN_ERR "msm_soc: failed to create pcms\n");
+		goto __nopcm;
+	}
+
+	card =3D socdev->codec->card;
+
+	ret =3D snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "msm_soc: failed to register card\n");
+		goto __nodev;
+	}
+
+	return 0;
+
+__nodev:
+	snd_soc_free_pcms(socdev);
+__nopcm:
+	kfree(codec);
+	return ret;
+}
+
+struct snd_soc_codec_device soc_codec_dev_msm =3D {
+	.probe          =3D msm_pcm_probe,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_msm);
+
+
+static int __init msm_dai_init(void)
+{
+	return snd_soc_register_dais(msm_dais, ARRAY_SIZE(msm_dais));
+}
+
+static void __exit msm_dai_exit(void)
+{
+	snd_soc_unregister_dais(msm_dais, ARRAY_SIZE(msm_dais));
+}
+
+module_init(msm_dai_init);
+module_exit(msm_dai_exit);
+
+/* Module information */
+MODULE_DESCRIPTION("MSM Codec/Cpu Dai driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/msm/msm-pcm.c b/sound/soc/msm/msm-pcm.c
new file mode 100644
index 0000000..90e200d
--- /dev/null
+++ b/sound/soc/msm/msm-pcm.c
@@ -0,0 +1,643 @@
+/* sound/soc/msm/msm-pcm.c
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2008 HTC Corporation
+ * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * See the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can find it at http://www.fsf.or=
g.
+ */
+
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <asm/dma.h>
+#include <linux/dma-mapping.h>
+
+#include "msm-pcm.h"
+
+#define MAX_DATA_SIZE 496
+#define AUDPP_ALSA_DECODER	(-1)
+
+#define DB_TABLE_INDEX		(50)
+
+#define audio_send_queue_recbs(prtd, cmd, len) \
+	msm_adsp_write(prtd->audrec, QDSP_uPAudRecBitStreamQueue, cmd, len)
+#define audio_send_queue_rec(prtd, cmd, len) \
+	msm_adsp_write(prtd->audrec, QDSP_uPAudRecCmdQueue, cmd, len)
+
+int intcnt;
+static int audio_dsp_send_buffer(struct msm_audio *prtd,
+			unsigned idx, unsigned len);
+
+struct audio_frame {
+	uint16_t count_low;
+	uint16_t count_high;
+	uint16_t bytes;
+	uint16_t unknown;
+	unsigned char samples[];
+} __attribute__ ((packed));
+
+/* Table contains dB to raw value mapping */
+static const unsigned decoder_db_table[] =3D {
+
+      31 , /* -50 dB */
+      35 ,      39 ,      44 ,      50 ,      56 ,
+      63 ,      70 ,      79 ,      89 ,      99 ,
+     112 ,     125 ,     141 ,     158 ,     177 ,
+     199 ,     223 ,     251 ,     281 ,     316 ,
+     354 ,     398 ,     446 ,     501 ,     562 ,
+     630 ,     707 ,     794 ,     891 ,     999 ,
+    1122 ,    1258 ,    1412 ,    1584 ,    1778 ,
+    1995 ,    2238 ,    2511 ,    2818 ,    3162 ,
+    3548 ,    3981 ,    4466 ,    5011 ,    5623 ,
+    6309 ,    7079 ,    7943 ,    8912 ,   10000 ,
+   11220 ,   12589 ,   14125 ,   15848 ,   17782 ,
+   19952 ,   22387 ,   25118 ,   28183 ,   31622 ,
+   35481 ,   39810 ,   44668 ,   50118 ,   56234 ,
+   63095 ,   70794 ,   79432 ,   89125 ,  100000 ,
+  112201 ,  125892 ,  141253 ,  158489 ,  177827 ,
+  199526 ,  223872 ,  251188 ,  281838 ,  316227 ,
+  354813 ,  398107 ,  446683 ,  501187 ,  562341 ,
+  630957 ,  707945 ,  794328 ,  891250 , 1000000 ,
+ 1122018 , 1258925 , 1412537 , 1584893 , 1778279 ,
+ 1995262 , 2238721 , 2511886 , 2818382 , 3162277 ,
+ 3548133   /*  51 dB */
+
+};
+
+static unsigned compute_db_raw(int db)
+{
+	unsigned reg_val =3D 0;        /* Computed result for correspondent db =
*/
+	/* Check if the given db is out of range */
+	if (db <=3D MIN_DB)
+		return 0;
+	else if (db > MAX_DB)
+		db =3D MAX_DB;       /* If db is too high then set to max    */
+	reg_val =3D decoder_db_table[DB_TABLE_INDEX+db];
+	return reg_val;
+}
+
+int msm_audio_volume_update(unsigned id,
+				int volume, int pan)
+{
+	unsigned vol_raw;
+
+	vol_raw =3D compute_db_raw(volume);
+	printk(KERN_INFO "volume: %8x vol_raw: %8x \n", volume, vol_raw);
+	return audpp_set_volume_and_pan(id, vol_raw, pan);
+}
+EXPORT_SYMBOL(msm_audio_volume_update);
+
+void alsa_dsp_event(void *data, unsigned id, uint16_t *msg)
+{
+	struct msm_audio *prtd =3D data;
+	struct buffer *frame;
+	unsigned long flag;
+
+	switch (id) {
+	case AUDPP_MSG_STATUS_MSG:
+		break;
+	case AUDPP_MSG_SPA_BANDS:
+		break;
+	case AUDPP_MSG_HOST_PCM_INTF_MSG:{
+			unsigned id =3D msg[2];
+			unsigned idx =3D msg[3] - 1;
+			if (id !=3D AUDPP_MSG_HOSTPCM_ID_ARM_RX) {
+				printk(KERN_ERR "bogus id\n");
+				break;
+			}
+			if (idx > 1) {
+				printk(KERN_ERR "bogus buffer idx\n");
+				break;
+			}
+			/* Update with actual sent buffer size */
+			if (prtd->out[idx].used !=3D BUF_INVALID_LEN)
+				prtd->pcm_irq_pos +=3D prtd->out[idx].used;
+
+			if (prtd->pcm_irq_pos > prtd->pcm_size)
+				prtd->pcm_irq_pos =3D prtd->pcm_count;
+
+			if (prtd->ops->playback)
+				prtd->ops->playback(prtd);
+
+			spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
+			if (prtd->running) {
+				prtd->out[idx].used =3D 0;
+				frame =3D prtd->out + prtd->out_tail;
+				if (frame->used) {
+					audio_dsp_send_buffer(prtd,
+							      prtd->out_tail,
+							      frame->used);
+					prtd->out_tail ^=3D 1;
+				} else {
+					prtd->out_needed++;
+				}
+				wake_up(&the_locks.write_wait);
+			}
+			spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
+			break;
+		}
+	case AUDPP_MSG_PCMDMAMISSED:
+		printk(KERN_ERR "alsa_dsp_event: PCMDMAMISSED %d\n", msg[0]);
+		break;
+	case AUDPP_MSG_CFG_MSG:
+		if (msg[0] =3D=3D AUDPP_MSG_ENA_ENA) {
+			prtd->out_needed =3D 0;
+			prtd->running =3D 1;
+			audio_dsp_out_enable(prtd, 1);
+		} else if (msg[0] =3D=3D AUDPP_MSG_ENA_DIS) {
+			prtd->running =3D 0;
+		} else {
+			printk(KERN_ERR "alsa_dsp_event:CFG_MSG=3D%d\n", msg[0]);
+		}
+		break;
+	case EVENT_MSG_ID:
+		printk(KERN_INFO"alsa_dsp_event: arm9 event\n");
+		break;
+	default:
+		printk(KERN_ERR "alsa_dsp_event: UNKNOWN (%d)\n", id);
+	}
+}
+
+void alsa_audpre_dsp_event(void *data, unsigned id, size_t len,
+		      void (*getevent) (void *ptr, size_t len))
+{
+	uint16_t msg[MAX_DATA_SIZE/2];
+
+	if (len > MAX_DATA_SIZE) {
+		printk(KERN_ERR"audpre: event too large(%d bytes)\n", len);
+		return;
+	}
+	getevent(msg, len);
+
+	switch (id) {
+	case AUDPREPROC_MSG_CMD_CFG_DONE_MSG:
+		break;
+	case AUDPREPROC_MSG_ERROR_MSG_ID:
+		printk(KERN_ERR "audpre: err_index %d\n", msg[0]);
+		break;
+	case EVENT_MSG_ID:
+		printk(KERN_INFO"audpre: arm9 event\n");
+		break;
+	default:
+		printk(KERN_ERR "audpre: unknown event %d\n", id);
+	}
+}
+
+void audrec_dsp_event(void *data, unsigned id, size_t len,
+		      void (*getevent) (void *ptr, size_t len))
+{
+	struct msm_audio *prtd =3D data;
+	unsigned long flag;
+	uint16_t msg[MAX_DATA_SIZE/2];
+
+	if (len > MAX_DATA_SIZE) {
+		printk(KERN_ERR"audrec: event/msg too large(%d bytes)\n", len);
+		return;
+	}
+	getevent(msg, len);
+
+	switch (id) {
+	case AUDREC_MSG_CMD_CFG_DONE_MSG:
+		if (msg[0] & AUDREC_MSG_CFG_DONE_TYPE_0_UPDATE) {
+			if (msg[0] & AUDREC_MSG_CFG_DONE_TYPE_0_ENA)
+				audrec_encoder_config(prtd);
+			else
+				prtd->running =3D 0;
+		}
+		break;
+	case AUDREC_MSG_CMD_AREC_PARAM_CFG_DONE_MSG:{
+			prtd->running =3D 1;
+			break;
+		}
+	case AUDREC_MSG_FATAL_ERR_MSG:
+		printk(KERN_ERR "audrec: ERROR %x\n", msg[0]);
+		break;
+	case AUDREC_MSG_PACKET_READY_MSG:
+		alsa_get_dsp_frames(prtd);
+		++intcnt;
+		if (prtd->channel_mode =3D=3D 1) {
+			spin_lock_irqsave(&the_locks.read_dsp_lock, flag);
+			prtd->pcm_irq_pos +=3D prtd->pcm_count;
+			if (prtd->pcm_irq_pos >=3D prtd->pcm_size)
+				prtd->pcm_irq_pos =3D 0;
+			spin_unlock_irqrestore(&the_locks.read_dsp_lock, flag);
+
+			if (prtd->ops->capture)
+				prtd->ops->capture(prtd);
+		} else if ((prtd->channel_mode =3D=3D 0) && (intcnt % 2 =3D=3D 0)) {
+			spin_lock_irqsave(&the_locks.read_dsp_lock, flag);
+			prtd->pcm_irq_pos +=3D prtd->pcm_count;
+			if (prtd->pcm_irq_pos >=3D prtd->pcm_size)
+				prtd->pcm_irq_pos =3D 0;
+			spin_unlock_irqrestore(&the_locks.read_dsp_lock, flag);
+			if (prtd->ops->capture)
+				prtd->ops->capture(prtd);
+		}
+		break;
+	case EVENT_MSG_ID:
+		printk(KERN_INFO"audrec: arm9 event\n");
+		break;
+	default:
+		printk(KERN_ERR "audrec: unknown event %d\n", id);
+	}
+}
+
+struct msm_adsp_ops aud_pre_adsp_ops =3D {
+	.event =3D alsa_audpre_dsp_event,
+};
+
+struct msm_adsp_ops aud_rec_adsp_ops =3D {
+	.event =3D audrec_dsp_event,
+};
+
+int alsa_adsp_configure(struct msm_audio *prtd)
+{
+	int ret, i;
+
+	if (prtd->dir =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		prtd->data =3D prtd->playback_substream->dma_buffer.area;
+		prtd->phys =3D prtd->playback_substream->dma_buffer.addr;
+	}
+	if (prtd->dir =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
+		prtd->data =3D prtd->capture_substream->dma_buffer.area;
+		prtd->phys =3D prtd->capture_substream->dma_buffer.addr;
+	}
+	if (!prtd->data) {
+		ret =3D -ENOMEM;
+		goto err1;
+	}
+
+	ret =3D audmgr_open(&prtd->audmgr);
+	if (ret)
+		goto err2;
+	if (prtd->dir =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		prtd->out_buffer_size =3D PLAYBACK_DMASZ;
+		prtd->out_sample_rate =3D 44100;
+		prtd->out_channel_mode =3D AUDPP_CMD_PCM_INTF_STEREO_V;
+		prtd->out_weight =3D 100;
+
+		prtd->out[0].data =3D prtd->data + 0;
+		prtd->out[0].addr =3D prtd->phys + 0;
+		prtd->out[0].size =3D BUFSZ;
+		prtd->out[1].data =3D prtd->data + BUFSZ;
+		prtd->out[1].addr =3D prtd->phys + BUFSZ;
+		prtd->out[1].size =3D BUFSZ;
+	}
+	if (prtd->dir =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
+		prtd->samp_rate =3D RPC_AUD_DEF_SAMPLE_RATE_44100;
+		prtd->samp_rate_index =3D AUDREC_CMD_SAMP_RATE_INDX_44100;
+		prtd->channel_mode =3D AUDREC_CMD_STEREO_MODE_STEREO;
+		prtd->buffer_size =3D STEREO_DATA_SIZE;
+		prtd->type =3D AUDREC_CMD_TYPE_0_INDEX_WAV;
+		prtd->tx_agc_cfg.cmd_id =3D AUDPREPROC_CMD_CFG_AGC_PARAMS;
+		prtd->ns_cfg.cmd_id =3D AUDPREPROC_CMD_CFG_NS_PARAMS;
+		prtd->iir_cfg.cmd_id =3D
+		    AUDPREPROC_CMD_CFG_IIR_TUNING_FILTER_PARAMS;
+
+		ret =3D msm_adsp_get("AUDPREPROCTASK",
+				   &prtd->audpre, &aud_pre_adsp_ops, prtd);
+		if (ret)
+			goto err3;
+		ret =3D msm_adsp_get("AUDRECTASK",
+				   &prtd->audrec, &aud_rec_adsp_ops, prtd);
+		if (ret) {
+			msm_adsp_put(prtd->audpre);
+			goto err3;
+		}
+		prtd->dsp_cnt =3D 0;
+		prtd->in_head =3D 0;
+		prtd->in_tail =3D 0;
+		prtd->in_count =3D 0;
+		for (i =3D 0; i < FRAME_NUM; i++) {
+			prtd->in[i].size =3D 0;
+			prtd->in[i].read =3D 0;
+		}
+	}
+
+	return 0;
+
+err3:
+	audmgr_close(&prtd->audmgr);
+
+err2:
+	prtd->data =3D NULL;
+err1:
+	return ret;
+}
+EXPORT_SYMBOL(alsa_adsp_configure);
+
+int alsa_audio_configure(struct msm_audio *prtd)
+{
+	struct audmgr_config cfg;
+	int rc;
+
+	if (prtd->enabled)
+		return 0;
+
+	/* refuse to start if we're not ready with first buffer */
+	if (!prtd->out[0].used)
+		return -EIO;
+
+	cfg.tx_rate =3D 0;
+	cfg.rx_rate =3D RPC_AUD_DEF_SAMPLE_RATE_48000;
+	cfg.def_method =3D RPC_AUD_DEF_METHOD_HOST_PCM;
+	cfg.codec =3D RPC_AUD_DEF_CODEC_PCM;
+	cfg.snd_method =3D RPC_SND_METHOD_MIDI;
+	rc =3D audmgr_enable(&prtd->audmgr, &cfg);
+	if (rc < 0)
+		return rc;
+
+	if (audpp_enable(AUDPP_ALSA_DECODER, alsa_dsp_event, prtd)) {
+		printk(KERN_ERR "audio: audpp_enable() failed\n");
+		audmgr_disable(&prtd->audmgr);
+		return -ENODEV;
+	}
+
+	prtd->enabled =3D 1;
+	return 0;
+}
+EXPORT_SYMBOL(alsa_audio_configure);
+
+ssize_t alsa_send_buffer(struct msm_audio *prtd, const char __user *buf,
+			  size_t count, loff_t *pos)
+{
+	unsigned long flag;
+	const char __user *start =3D buf;
+	struct buffer *frame;
+	size_t xfer;
+	int rc =3D 0;
+
+	mutex_lock(&the_locks.write_lock);
+	while (count > 0) {
+		frame =3D prtd->out + prtd->out_head;
+		rc =3D wait_event_interruptible(the_locks.write_wait,
+					      (frame->used =3D=3D 0)
+					      || (prtd->stopped));
+		if (rc < 0)
+			break;
+		if (prtd->stopped) {
+			rc =3D -EBUSY;
+			break;
+		}
+		xfer =3D count > frame->size ? frame->size : count;
+		if (copy_from_user(frame->data, buf, xfer)) {
+			rc =3D -EFAULT;
+			break;
+		}
+		frame->used =3D xfer;
+		prtd->out_head ^=3D 1;
+		count -=3D xfer;
+		buf +=3D xfer;
+
+		spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
+		frame =3D prtd->out + prtd->out_tail;
+		if (frame->used && prtd->out_needed) {
+			audio_dsp_send_buffer(prtd, prtd->out_tail,
+					      frame->used);
+			prtd->out_tail ^=3D 1;
+			prtd->out_needed--;
+		}
+		spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
+	}
+	mutex_unlock(&the_locks.write_lock);
+	if (buf > start)
+		return buf - start;
+	return rc;
+}
+EXPORT_SYMBOL(alsa_send_buffer);
+
+int alsa_audio_disable(struct msm_audio *prtd)
+{
+	if (prtd->enabled) {
+		mutex_lock(&the_locks.lock);
+		prtd->enabled =3D 0;
+		audio_dsp_out_enable(prtd, 0);
+		wake_up(&the_locks.write_wait);
+		audpp_disable(AUDPP_ALSA_DECODER, prtd);
+		audmgr_disable(&prtd->audmgr);
+		prtd->out_needed =3D 0;
+		mutex_unlock(&the_locks.lock);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(alsa_audio_disable);
+
+int alsa_audrec_disable(struct msm_audio *prtd)
+{
+	if (prtd->enabled) {
+		mutex_lock(&the_locks.lock);
+		prtd->enabled =3D 0;
+		alsa_rec_dsp_enable(prtd, 0);
+		wake_up(&the_locks.read_wait);
+		msm_adsp_disable(prtd->audpre);
+		msm_adsp_disable(prtd->audrec);
+		audmgr_disable(&prtd->audmgr);
+		prtd->out_needed =3D 0;
+		prtd->opened =3D 0;
+		mutex_unlock(&the_locks.lock);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(alsa_audrec_disable);
+
+static int audio_dsp_read_buffer(struct msm_audio *prtd, uint32_t read_c=
nt)
+{
+	audrec_cmd_packet_ext_ptr cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd_id =3D AUDREC_CMD_PACKET_EXT_PTR;
+	/* Both WAV and AAC use AUDREC_CMD_TYPE_0 */
+	cmd.type =3D AUDREC_CMD_TYPE_0;
+	cmd.curr_rec_count_msw =3D read_cnt >> 16;
+	cmd.curr_rec_count_lsw =3D read_cnt;
+
+	return audio_send_queue_recbs(prtd, &cmd, sizeof(cmd));
+}
+
+int audrec_encoder_config(struct msm_audio *prtd)
+{
+	audrec_cmd_arec0param_cfg cmd;
+	uint16_t *data =3D (void *)prtd->data;
+	unsigned n;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd_id =3D AUDREC_CMD_AREC0PARAM_CFG;
+	cmd.ptr_to_extpkt_buffer_msw =3D prtd->phys >> 16;
+	cmd.ptr_to_extpkt_buffer_lsw =3D prtd->phys;
+	cmd.buf_len =3D FRAME_NUM;	/* Both WAV and AAC use 8 frames */
+	cmd.samp_rate_index =3D prtd->samp_rate_index;
+	/* 0 for mono, 1 for stereo */
+	cmd.stereo_mode =3D prtd->channel_mode;
+	cmd.rec_quality =3D 0x1C00;
+
+	/* prepare buffer pointers:
+	 * Mono: 1024 samples + 4 halfword header
+	 * Stereo: 2048 samples + 4 halfword header
+	 */
+
+	for (n =3D 0; n < FRAME_NUM; n++) {
+		prtd->in[n].data =3D data + 4;
+		data +=3D (4 + (prtd->channel_mode ? 2048 : 1024));
+	}
+
+	return audio_send_queue_rec(prtd, &cmd, sizeof(cmd));
+}
+
+int audio_dsp_out_enable(struct msm_audio *prtd, int yes)
+{
+	audpp_cmd_pcm_intf cmd;
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd_id =3D AUDPP_CMD_PCM_INTF_2;
+	cmd.object_num =3D AUDPP_CMD_PCM_INTF_OBJECT_NUM;
+	cmd.config =3D AUDPP_CMD_PCM_INTF_CONFIG_CMD_V;
+	cmd.intf_type =3D AUDPP_CMD_PCM_INTF_RX_ENA_ARMTODSP_V;
+
+	if (yes) {
+		cmd.write_buf1LSW =3D prtd->out[0].addr;
+		cmd.write_buf1MSW =3D prtd->out[0].addr >> 16;
+		cmd.write_buf1_len =3D 0;
+		cmd.write_buf2LSW =3D prtd->out[1].addr;
+		cmd.write_buf2MSW =3D prtd->out[1].addr >> 16;
+		cmd.write_buf2_len =3D prtd->out[1].used;
+		cmd.arm_to_rx_flag =3D AUDPP_CMD_PCM_INTF_ENA_V;
+		cmd.weight_decoder_to_rx =3D prtd->out_weight;
+		cmd.weight_arm_to_rx =3D 1;
+		cmd.partition_number_arm_to_dsp =3D 0;
+		cmd.sample_rate =3D prtd->out_sample_rate;
+		cmd.channel_mode =3D prtd->out_channel_mode;
+	}
+	return audpp_send_queue2(&cmd, sizeof(cmd));
+}
+
+int alsa_buffer_read(struct msm_audio *prtd, void __user *buf,
+		      size_t count, loff_t *pos)
+{
+	unsigned long flag;
+	void *data;
+	uint32_t index;
+	uint32_t size;
+	int rc =3D 0;
+
+	mutex_lock(&the_locks.read_lock);
+	while (count > 0) {
+		rc =3D wait_event_interruptible(the_locks.read_wait,
+					      (prtd->in_count > 0)
+					      || prtd->stopped);
+		if (rc < 0)
+			break;
+
+		if (prtd->stopped) {
+			rc =3D -EBUSY;
+			break;
+		}
+
+		index =3D prtd->in_tail;
+		data =3D (uint8_t *) prtd->in[index].data;
+		size =3D prtd->in[index].size;
+		if (count >=3D size) {
+			if (copy_to_user(buf, data, size)) {
+				rc =3D -EFAULT;
+				break;
+			}
+			spin_lock_irqsave(&the_locks.read_dsp_lock, flag);
+			if (index !=3D prtd->in_tail) {
+				/* overrun: data is invalid, we need to retry */
+				spin_unlock_irqrestore(&the_locks.read_dsp_lock,
+						       flag);
+				continue;
+			}
+			prtd->in[index].size =3D 0;
+			prtd->in_tail =3D (prtd->in_tail + 1) & (FRAME_NUM - 1);
+			prtd->in_count--;
+			spin_unlock_irqrestore(&the_locks.read_dsp_lock, flag);
+			count -=3D size;
+			buf +=3D size;
+		} else {
+			break;
+		}
+	}
+	mutex_unlock(&the_locks.read_lock);
+	return rc;
+}
+EXPORT_SYMBOL(alsa_buffer_read);
+
+static int audio_dsp_send_buffer(struct msm_audio *prtd,
+					unsigned idx, unsigned len)
+{
+	audpp_cmd_pcm_intf_send_buffer cmd;
+	cmd.cmd_id =3D AUDPP_CMD_PCM_INTF_2;
+	cmd.host_pcm_object =3D AUDPP_CMD_PCM_INTF_OBJECT_NUM;
+	cmd.config =3D AUDPP_CMD_PCM_INTF_BUFFER_CMD_V;
+	cmd.intf_type =3D AUDPP_CMD_PCM_INTF_RX_ENA_ARMTODSP_V;
+	cmd.dsp_to_arm_buf_id =3D 0;
+	cmd.arm_to_dsp_buf_id =3D idx + 1;
+	cmd.arm_to_dsp_buf_len =3D len;
+	return audpp_send_queue2(&cmd, sizeof(cmd));
+}
+
+int alsa_rec_dsp_enable(struct msm_audio *prtd, int enable)
+{
+	audrec_cmd_cfg cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd_id =3D AUDREC_CMD_CFG;
+	cmd.type_0 =3D enable ? AUDREC_CMD_TYPE_0_ENA : AUDREC_CMD_TYPE_0_DIS;
+	cmd.type_0 |=3D (AUDREC_CMD_TYPE_0_UPDATE | prtd->type);
+	cmd.type_1 =3D 0;
+
+	return audio_send_queue_rec(prtd, &cmd, sizeof(cmd));
+}
+EXPORT_SYMBOL(alsa_rec_dsp_enable);
+
+void alsa_get_dsp_frames(struct msm_audio *prtd)
+{
+	struct audio_frame *frame;
+	uint32_t index =3D 0;
+	unsigned long flag;
+
+	if (prtd->type =3D=3D AUDREC_CMD_TYPE_0_INDEX_WAV) {
+		index =3D prtd->in_head;
+
+		frame =3D
+		    (void *)(((char *)prtd->in[index].data) - sizeof(*frame));
+
+		spin_lock_irqsave(&the_locks.read_dsp_lock, flag);
+		prtd->in[index].size =3D frame->bytes;
+
+		prtd->in_head =3D (prtd->in_head + 1) & (FRAME_NUM - 1);
+
+		/* If overflow, move the tail index foward. */
+		if (prtd->in_head =3D=3D prtd->in_tail)
+			prtd->in_tail =3D (prtd->in_tail + 1) & (FRAME_NUM - 1);
+		else
+			prtd->in_count++;
+
+		audio_dsp_read_buffer(prtd, prtd->dsp_cnt++);
+		spin_unlock_irqrestore(&the_locks.read_dsp_lock, flag);
+
+		wake_up(&the_locks.read_wait);
+	} else {
+		/* TODO AAC not supported yet. */
+	}
+}
+EXPORT_SYMBOL(alsa_get_dsp_frames);
diff --git a/sound/soc/msm/msm-pcm.h b/sound/soc/msm/msm-pcm.h
new file mode 100644
index 0000000..7563ef0
--- /dev/null
+++ b/sound/soc/msm/msm-pcm.h
@@ -0,0 +1,200 @@
+/* sound/soc/msm/msm-pcm.h
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Copyright (C) 2008 HTC Corporation
+ * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * See the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can find it at http://www.fsf.or=
g.
+ */
+
+#ifndef _MSM_PCM_H
+#define _MSM_PCM_H
+
+
+#include <mach/qdsp5/qdsp5audppcmdi.h>
+#include <mach/qdsp5/qdsp5audppmsg.h>
+#include <mach/qdsp5/qdsp5audreccmdi.h>
+#include <mach/qdsp5/qdsp5audrecmsg.h>
+#include <mach/qdsp5/qdsp5audpreproccmdi.h>
+#include <mach/qdsp5/qdsp5audpreprocmsg.h>
+
+#include <../arch/arm/mach-msm/qdsp5/adsp.h>
+#include <../arch/arm/mach-msm/qdsp5/audmgr.h>
+
+
+#define FRAME_NUM               (8)
+#define FRAME_SIZE              (2052 * 2)
+#define MONO_DATA_SIZE          (2048)
+#define STEREO_DATA_SIZE        (MONO_DATA_SIZE * 2)
+#define CAPTURE_DMASZ           (FRAME_SIZE * FRAME_NUM)
+
+#define BUFSZ			(960 * 5)
+#define PLAYBACK_DMASZ 		(BUFSZ * 2)
+
+#define MSM_PLAYBACK_DEFAULT_VOLUME 0 /* 0dB */
+#define MSM_PLAYBACK_DEFAULT_PAN 0
+
+#define USE_FORMATS             SNDRV_PCM_FMTBIT_S16_LE
+#define USE_CHANNELS_MIN        1
+#define USE_CHANNELS_MAX        2
+/* Support unconventional sample rates 12000, 24000 as well */
+#define USE_RATE                \
+			(SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
+#define USE_RATE_MIN            8000
+#define USE_RATE_MAX            48000
+#define MAX_BUFFER_PLAYBACK_SIZE \
+				(4800*4)
+/* 2048 frames (Mono), 1024 frames (Stereo) */
+#define CAPTURE_SIZE		4096
+#define MAX_BUFFER_CAPTURE_SIZE (4096*4)
+#define MAX_PERIOD_SIZE         BUFSZ
+#define USE_PERIODS_MAX         1024
+#define USE_PERIODS_MIN		1
+
+
+#define MAX_DB			(16)
+#define MIN_DB			(-50)
+#define PCMPLAYBACK_DECODERID   5
+
+/* 0xFFFFFFFF Indicates not to be used for audio data copy */
+#define	BUF_INVALID_LEN		0xFFFFFFFF
+
+extern int copy_count;
+extern int intcnt;
+
+struct msm_volume {
+	bool update;
+	int volume; /* Volume parameter, in dB Scale */
+	int pan;
+};
+
+struct buffer {
+	void *data;
+	unsigned size;
+	unsigned used;
+	unsigned addr;
+};
+
+struct buffer_rec {
+	void *data;
+	unsigned int size;
+	unsigned int read;
+	unsigned int addr;
+};
+
+struct audio_locks {
+	struct mutex lock;
+	struct mutex write_lock;
+	struct mutex read_lock;
+	spinlock_t read_dsp_lock;
+	spinlock_t write_dsp_lock;
+	spinlock_t mixer_lock;
+	wait_queue_head_t read_wait;
+	wait_queue_head_t write_wait;
+};
+
+extern struct audio_locks the_locks;
+
+struct msm_audio_event_callbacks {
+	/* event is called from interrupt context when a message
+	 * arrives from the DSP.
+	*/
+	void (*playback)(void *);
+	void (*capture)(void *);
+};
+
+
+struct msm_audio {
+	struct buffer out[2];
+	struct buffer_rec in[8];
+
+	uint8_t out_head;
+	uint8_t out_tail;
+	uint8_t out_needed; /* number of buffers the dsp is waiting for */
+	atomic_t out_bytes;
+
+	/* configuration to use on next enable */
+	uint32_t out_sample_rate;
+	uint32_t out_channel_mode;
+	uint32_t out_weight;
+	uint32_t out_buffer_size;
+
+	struct audmgr audmgr;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+
+	/* data allocated for various buffers */
+	char *data;
+	dma_addr_t phys;
+
+	unsigned int pcm_size;
+	unsigned int pcm_count;
+	unsigned int pcm_irq_pos;       /* IRQ position */
+	unsigned int pcm_buf_pos;       /* position in buffer */
+
+	struct msm_adsp_module *audpre;
+	struct msm_adsp_module *audrec;
+
+	/* configuration to use on next enable */
+	uint32_t samp_rate;
+	uint32_t channel_mode;
+	uint32_t buffer_size; /* 2048 for mono, 4096 for stereo */
+	uint32_t type; /* 0 for PCM ,1 for AAC */
+	uint32_t dsp_cnt;
+	uint32_t in_head; /* next buffer dsp will write */
+	uint32_t in_tail; /* next buffer read() will read */
+	uint32_t in_count; /* number of buffers available to read() */
+
+	unsigned short samp_rate_index;
+
+	/* audpre settings */
+	audpreproc_cmd_cfg_agc_params tx_agc_cfg;
+	audpreproc_cmd_cfg_ns_params ns_cfg;
+	/* For different sample rate, the coeff might be different. *
+	* All the coeff should be passed from user space           */
+	audpreproc_cmd_cfg_iir_tuning_filter_params iir_cfg;
+
+	struct  msm_audio_event_callbacks *ops;
+
+	int dir;
+	int opened;
+	int enabled;
+	int running;
+	int stopped; /* set when stopped, cleared on flush */
+};
+
+
+
+/* platform data */
+extern int audio_dsp_out_enable(struct msm_audio *prtd, int yes);
+extern struct snd_soc_platform msm_soc_platform;
+extern struct snd_soc_dai msm_dais[2];
+extern struct snd_soc_codec_device soc_codec_dev_msm;
+
+int audrec_encoder_config(struct msm_audio *prtd);
+extern void alsa_get_dsp_frames(struct msm_audio *prtd);
+extern int alsa_rec_dsp_enable(struct msm_audio *prtd, int enable);
+extern int alsa_audrec_disable(struct msm_audio *prtd);
+extern int alsa_audio_configure(struct msm_audio *prtd);
+extern int alsa_audio_disable(struct msm_audio *prtd);
+extern int alsa_adsp_configure(struct msm_audio *prtd);
+extern int alsa_buffer_read(struct msm_audio *prtd, void __user *buf,
+					size_t count, loff_t *pos);
+ssize_t alsa_send_buffer(struct msm_audio *prtd, const char __user *buf,
+					size_t count, loff_t *pos);
+int msm_audio_volume_update(unsigned id,
+				int volume, int pan);
+extern struct audio_locks the_locks;
+extern struct msm_volume msm_vol_ctl;
+
+#endif /*_MSM_PCM_H*/
diff --git a/sound/soc/msm/msm7201.c b/sound/soc/msm/msm7201.c
new file mode 100644
index 0000000..977fbac
--- /dev/null
+++ b/sound/soc/msm/msm7201.c
@@ -0,0 +1,337 @@
+/* linux/sound/soc/msm/msm7201.c
+ *
+ * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * All source code in this file is licensed under the following license =
except
+ * where indicated.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License version 2 as publis=
hed
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * See the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can find it at http://www.fsf.or=
g.
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/tlv.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <asm/dma.h>
+#include <linux/dma-mapping.h>
+
+#include "msm-pcm.h"
+#include <asm/mach-types.h>
+#include <mach/msm_rpcrouter.h>
+
+static struct msm_rpc_endpoint *snd_ep;
+
+struct msm_snd_rpc_ids {
+	unsigned long   prog;
+	unsigned long   vers;
+	unsigned long   rpc_set_snd_device;
+	int device;
+};
+
+static struct msm_snd_rpc_ids snd_rpc_ids;
+
+static struct platform_device *msm_audio_snd_device;
+
+static int snd_msm_volume_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1; /* Volume Param, in dB */
+	uinfo->value.integer.min =3D MIN_DB;
+	uinfo->value.integer.max =3D MAX_DB;
+	return 0;
+}
+
+static int snd_msm_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	spin_lock_irq(&the_locks.mixer_lock);
+	ucontrol->value.integer.value[0] =3D msm_vol_ctl.volume;
+	spin_unlock_irq(&the_locks.mixer_lock);
+	return 0;
+}
+
+static int snd_msm_volume_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	int change;
+	int volume;
+
+	volume =3D ucontrol->value.integer.value[0];
+	spin_lock_irq(&the_locks.mixer_lock);
+	change =3D (msm_vol_ctl.volume !=3D volume);
+	if (change) {
+		msm_vol_ctl.update =3D 1;
+		msm_vol_ctl.volume =3D volume;
+	}
+	spin_unlock_irq(&the_locks.mixer_lock);
+	return change;
+}
+
+static int snd_msm_device_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1; /* Device */
+
+	/*
+	 * The number of devices supported is 26 (0 to 25)
+	 */
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 25;
+	return 0;
+}
+
+static int snd_msm_device_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] =3D (uint32_t)snd_rpc_ids.device;
+	return 0;
+}
+
+int msm_snd_init_rpc_ids(void)
+{
+	snd_rpc_ids.prog	=3D 0x30000002;
+#ifdef CONFIG_MSM_AMSS_VERSION_6225
+	//TODO: complete for other versions
+	snd_rpc_ids.vers	=3D 0xaa2b1a44;
+#else
+	//seem a new magich number...not in arch/arm/mach-msm and it seem to be=
 for a new amss version
+	snd_rpc_ids.vers	=3D 0x00020001;
+#endif
+	/*
+	 * The magic number 2 corresponds to the rpc call
+	 * index for snd_set_device
+	 */
+	snd_rpc_ids.rpc_set_snd_device =3D 2;
+	return 0;
+}
+
+int msm_snd_rpc_connect(void)
+{
+	if (snd_ep) {
+		printk(KERN_INFO "%s: snd_ep already connected\n", __func__);
+		return 0;
+	}
+
+	/* Initialize rpc ids */
+	if (msm_snd_init_rpc_ids()) {
+		printk(KERN_ERR "%s: snd rpc ids initialization failed\n"
+			, __func__);
+		return -ENODATA;
+	}
+
+	snd_ep =3D msm_rpc_connect(snd_rpc_ids.prog,
+				snd_rpc_ids.vers, 0);
+	if (IS_ERR(snd_ep)) {
+		printk(KERN_ERR "%s: failed (compatible VERS =3D %ld)\n",
+				__func__, snd_rpc_ids.vers);
+		snd_ep =3D NULL;
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+int msm_snd_rpc_close(void)
+{
+	int rc =3D 0;
+
+	if (IS_ERR(snd_ep)) {
+		printk(KERN_ERR "%s: snd handle unavailable, rc =3D %ld\n",
+				__func__, PTR_ERR(snd_ep));
+		return -EAGAIN;
+	}
+
+	rc =3D msm_rpc_close(snd_ep);
+	snd_ep =3D NULL;
+
+	if (rc < 0) {
+		printk(KERN_ERR "%s: close rpc failed! rc =3D %d\n",
+				__func__, rc);
+		return -EAGAIN;
+	} else
+		printk(KERN_INFO "rpc close success\n");
+
+	return rc;
+}
+
+static int snd_msm_device_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	int rc =3D 0;
+	struct snd_start_req {
+		struct rpc_request_hdr hdr;
+		uint32_t rpc_snd_device;
+		uint32_t snd_mute_ear_mute;
+		uint32_t snd_mute_mic_mute;
+		uint32_t callback_ptr;
+		uint32_t client_data;
+	} req;
+
+	snd_rpc_ids.device =3D (int)ucontrol->value.integer.value[0];
+	req.hdr.type =3D 0;
+	req.hdr.rpc_vers =3D 2;
+
+	req.rpc_snd_device =3D cpu_to_be32(snd_rpc_ids.device);
+	req.snd_mute_ear_mute =3D cpu_to_be32(1);
+	req.snd_mute_mic_mute =3D cpu_to_be32(0);
+	req.callback_ptr =3D -1;
+	req.client_data =3D cpu_to_be32(0);
+
+	req.hdr.prog =3D snd_rpc_ids.prog;
+	req.hdr.vers =3D snd_rpc_ids.vers;
+
+	rc =3D msm_rpc_call(snd_ep, snd_rpc_ids.rpc_set_snd_device ,
+			&req, sizeof(req), 5 * HZ);
+
+	if (rc < 0) {
+		printk(KERN_ERR "%s: snd rpc call failed! rc =3D %d\n",
+			__func__, rc);
+	} else
+		printk(KERN_INFO "snd device connected \n");
+
+	return rc;
+}
+
+/* Supported range -50dB to 18dB */
+static const DECLARE_TLV_DB_LINEAR(db_scale_linear, -5000, 1800);
+
+#define MSM_EXT(xname, xindex, fp_info, fp_get, fp_put, addr) \
+{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+  .name =3D xname, .index =3D xindex, \
+  .info =3D fp_info,\
+  .get =3D fp_get, .put =3D fp_put, \
+  .private_value =3D addr, \
+}
+
+#define MSM_EXT_TLV(xname, xindex, fp_info, fp_get, fp_put, addr, tlv_ar=
ray) \
+{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .access =3D (SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		SNDRV_CTL_ELEM_ACCESS_READWRITE), \
+  .name =3D xname, .index =3D xindex, \
+  .info =3D fp_info,\
+  .get =3D fp_get, .put =3D fp_put, .tlv.p =3D tlv_array, \
+  .private_value =3D addr, \
+}
+
+static struct snd_kcontrol_new snd_msm_controls[] =3D {
+	MSM_EXT_TLV("PCM Playback Volume", 0, snd_msm_volume_info, \
+	snd_msm_volume_get, snd_msm_volume_put, 0, db_scale_linear),
+	MSM_EXT("device", 1, snd_msm_device_info, snd_msm_device_get, \
+						 snd_msm_device_put, 0),
+};
+
+static int msm_new_mixer(struct snd_card *card)
+{
+	unsigned int idx;
+	int err;
+
+	printk(KERN_ERR "msm_soc:ALSA MSM Mixer Setting");
+	strcpy(card->mixername, "MSM Mixer");
+	for (idx =3D 0; idx < ARRAY_SIZE(snd_msm_controls); idx++) {
+		err =3D snd_ctl_add(card,
+				snd_ctl_new1(&snd_msm_controls[idx], NULL));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int msm_soc_dai_init(struct snd_soc_codec *codec)
+{
+
+	int ret =3D 0;
+	ret =3D msm_new_mixer(codec->card);
+	if (ret < 0) {
+		printk(KERN_ERR "msm_soc:ALSA MSM Mixer Fail");
+	}
+
+	return ret;
+}
+
+
+static struct snd_soc_dai_link msm_dai =3D {
+	.name =3D "ASOC",
+	.stream_name =3D "ASOC",
+	.codec_dai =3D &msm_dais[0],
+	.cpu_dai =3D &msm_dais[1],
+	.init	=3D msm_soc_dai_init,
+};
+
+struct snd_soc_card snd_soc_card_msm =3D {
+	.name 		=3D "msm-audio",
+	.dai_link	=3D &msm_dai,
+	.num_links =3D 1,
+	.platform =3D &msm_soc_platform,
+};
+
+/* msm_audio audio subsystem */
+static struct snd_soc_device msm_audio_snd_devdata =3D {
+	.card =3D &snd_soc_card_msm,
+	.codec_dev =3D &soc_codec_dev_msm,
+};
+
+
+static int __init msm_audio_init(void)
+{
+	int ret;
+
+	msm_audio_snd_device =3D platform_device_alloc("soc-audio", -1);
+	if (!msm_audio_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(msm_audio_snd_device, &msm_audio_snd_devdata);
+	msm_audio_snd_devdata.dev =3D &msm_audio_snd_device->dev;
+	ret =3D platform_device_add(msm_audio_snd_device);
+	if (ret) {
+		platform_device_put(msm_audio_snd_device);
+		return ret;
+	}
+	mutex_init(&the_locks.lock);
+	mutex_init(&the_locks.write_lock);
+	mutex_init(&the_locks.read_lock);
+	spin_lock_init(&the_locks.read_dsp_lock);
+	spin_lock_init(&the_locks.write_dsp_lock);
+	spin_lock_init(&the_locks.mixer_lock);
+	init_waitqueue_head(&the_locks.write_wait);
+	init_waitqueue_head(&the_locks.read_wait);
+	msm_vol_ctl.volume =3D MSM_PLAYBACK_DEFAULT_VOLUME;
+	msm_vol_ctl.pan =3D MSM_PLAYBACK_DEFAULT_PAN;
+
+	ret =3D msm_snd_rpc_connect();
+
+	return ret;
+}
+
+static void __exit msm_audio_exit(void)
+{
+	msm_snd_rpc_close();
+	platform_device_unregister(msm_audio_snd_device);
+}
+
+module_init(msm_audio_init);
+module_exit(msm_audio_exit);
+
+MODULE_DESCRIPTION("PCM module");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
new file mode 100644
index 0000000..38e8283
--- /dev/null
+++ b/sound/soc/msm/msm7k-pcm.c
@@ -0,0 +1,574 @@
+/* linux/sound/soc/msm/msm7k-pcm.c
+ *
+ * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * All source code in this file is licensed under the following license =
except
+ * where indicated.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License version 2 as publis=
hed
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * See the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can find it at http://www.fsf.or=
g.
+ */
+
+
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <asm/dma.h>
+#include <linux/dma-mapping.h>
+
+#include "msm-pcm.h"
+
+#define SND_DRIVER        "snd_msm"
+#define MAX_PCM_DEVICES	SNDRV_CARDS
+#define MAX_PCM_SUBSTREAMS 1
+
+struct snd_msm {
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+};
+
+int copy_count;
+
+struct audio_locks the_locks;
+EXPORT_SYMBOL(the_locks);
+struct msm_volume msm_vol_ctl;
+EXPORT_SYMBOL(msm_vol_ctl);
+
+
+static unsigned convert_dsp_samp_index(unsigned index)
+{
+	switch (index) {
+	case 48000:
+		return AUDREC_CMD_SAMP_RATE_INDX_48000;
+	case 44100:
+		return AUDREC_CMD_SAMP_RATE_INDX_44100;
+	case 32000:
+		return AUDREC_CMD_SAMP_RATE_INDX_32000;
+	case 24000:
+		return AUDREC_CMD_SAMP_RATE_INDX_24000;
+	case 22050:
+		return AUDREC_CMD_SAMP_RATE_INDX_22050;
+	case 16000:
+		return AUDREC_CMD_SAMP_RATE_INDX_16000;
+	case 12000:
+		return AUDREC_CMD_SAMP_RATE_INDX_12000;
+	case 11025:
+		return AUDREC_CMD_SAMP_RATE_INDX_11025;
+	case 8000:
+		return AUDREC_CMD_SAMP_RATE_INDX_8000;
+	default:
+		return AUDREC_CMD_SAMP_RATE_INDX_44100;
+	}
+}
+
+static unsigned convert_samp_rate(unsigned hz)
+{
+	switch (hz) {
+	case 48000:
+		return RPC_AUD_DEF_SAMPLE_RATE_48000;
+	case 44100:
+		return RPC_AUD_DEF_SAMPLE_RATE_44100;
+	case 32000:
+		return RPC_AUD_DEF_SAMPLE_RATE_32000;
+	case 24000:
+		return RPC_AUD_DEF_SAMPLE_RATE_24000;
+	case 22050:
+		return RPC_AUD_DEF_SAMPLE_RATE_22050;
+	case 16000:
+		return RPC_AUD_DEF_SAMPLE_RATE_16000;
+	case 12000:
+		return RPC_AUD_DEF_SAMPLE_RATE_12000;
+	case 11025:
+		return RPC_AUD_DEF_SAMPLE_RATE_11025;
+	case 8000:
+		return RPC_AUD_DEF_SAMPLE_RATE_8000;
+	default:
+		return RPC_AUD_DEF_SAMPLE_RATE_44100;
+	}
+}
+
+static struct snd_pcm_hardware msm_pcm_playback_hardware =3D {
+	.info =3D                 SNDRV_PCM_INFO_INTERLEAVED,
+	.formats =3D              USE_FORMATS,
+	.rates =3D                USE_RATE,
+	.rate_min =3D             USE_RATE_MIN,
+	.rate_max =3D             USE_RATE_MAX,
+	.channels_min =3D         USE_CHANNELS_MIN,
+	.channels_max =3D         USE_CHANNELS_MAX,
+	.buffer_bytes_max =3D     MAX_BUFFER_PLAYBACK_SIZE,
+	.period_bytes_min =3D     64,
+	.period_bytes_max =3D     MAX_PERIOD_SIZE,
+	.periods_min =3D          USE_PERIODS_MIN,
+	.periods_max =3D          USE_PERIODS_MAX,
+	.fifo_size =3D            0,
+};
+
+static struct snd_pcm_hardware msm_pcm_capture_hardware =3D {
+	.info =3D                 SNDRV_PCM_INFO_INTERLEAVED,
+	.formats =3D		USE_FORMATS,
+	.rates =3D		USE_RATE,
+	.rate_min =3D		USE_RATE_MIN,
+	.rate_max =3D		USE_RATE_MAX,
+	.channels_min =3D		USE_CHANNELS_MIN,
+	.channels_max =3D		USE_CHANNELS_MAX,
+	.buffer_bytes_max =3D	MAX_BUFFER_CAPTURE_SIZE,
+	.period_bytes_min =3D	CAPTURE_SIZE,
+	.period_bytes_max =3D	CAPTURE_SIZE,
+	.periods_min =3D		USE_PERIODS_MIN,
+	.periods_max =3D		USE_PERIODS_MAX,
+	.fifo_size =3D		0,
+};
+
+/* Conventional and unconventional sample rate supported */
+static unsigned int supported_sample_rates[] =3D {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_sample_rates =3D {
+	.count =3D ARRAY_SIZE(supported_sample_rates),
+	.list =3D supported_sample_rates,
+	.mask =3D 0,
+};
+
+static void playback_event_handler(void *data)
+{
+	struct msm_audio *prtd =3D data;
+	snd_pcm_period_elapsed(prtd->playback_substream);
+}
+
+static void capture_event_handler(void *data)
+{
+	struct msm_audio *prtd =3D data;
+	snd_pcm_period_elapsed(prtd->capture_substream);
+}
+
+static int msm_pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	prtd->pcm_size =3D snd_pcm_lib_buffer_bytes(substream);
+	prtd->pcm_count =3D snd_pcm_lib_period_bytes(substream);
+	prtd->pcm_irq_pos =3D 0;
+	prtd->pcm_buf_pos =3D 0;
+
+	/* rate and channels are sent to audio driver */
+	prtd->out_sample_rate =3D runtime->rate;
+	prtd->out_channel_mode =3D runtime->channels;
+
+	return 0;
+}
+
+static int msm_pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+	struct audmgr_config cfg;
+	int rc;
+
+	prtd->pcm_size =3D snd_pcm_lib_buffer_bytes(substream);
+	prtd->pcm_count =3D snd_pcm_lib_period_bytes(substream);
+	prtd->pcm_irq_pos =3D 0;
+	prtd->pcm_buf_pos =3D 0;
+
+	/* rate and channels are sent to audio driver */
+	prtd->samp_rate =3D convert_samp_rate(runtime->rate);
+	prtd->samp_rate_index =3D convert_dsp_samp_index(runtime->rate);
+	prtd->channel_mode =3D (runtime->channels - 1);
+	prtd->buffer_size =3D prtd->channel_mode ? STEREO_DATA_SIZE : \
+							MONO_DATA_SIZE;
+
+	if (prtd->enabled =3D=3D 1)
+		return 0;
+
+	prtd->type =3D AUDREC_CMD_TYPE_0_INDEX_WAV;
+
+	cfg.tx_rate =3D convert_samp_rate(runtime->rate);
+	cfg.rx_rate =3D RPC_AUD_DEF_SAMPLE_RATE_NONE;
+	cfg.def_method =3D RPC_AUD_DEF_METHOD_RECORD;
+	cfg.codec =3D RPC_AUD_DEF_CODEC_PCM;
+	cfg.snd_method =3D RPC_SND_METHOD_MIDI;
+
+	rc =3D audmgr_enable(&prtd->audmgr, &cfg);
+	if (rc < 0)
+		return rc;
+
+	if (msm_adsp_enable(prtd->audpre)) {
+		audmgr_disable(&prtd->audmgr);
+		return -ENODEV;
+	}
+	if (msm_adsp_enable(prtd->audrec)) {
+		msm_adsp_disable(prtd->audpre);
+		audmgr_disable(&prtd->audmgr);
+		return -ENODEV;
+	}
+	prtd->enabled =3D 1;
+	alsa_rec_dsp_enable(prtd, 1);
+
+	return 0;
+}
+
+static int msm_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret =3D 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t
+msm_pcm_playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	if (prtd->pcm_irq_pos =3D=3D prtd->pcm_size)
+		prtd->pcm_irq_pos =3D 0;
+	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
+}
+
+static int msm_pcm_capture_copy(struct snd_pcm_substream *substream,
+		 int channel, snd_pcm_uframes_t hwoff, void __user *buf,
+						 snd_pcm_uframes_t frames)
+{
+	int rc =3D 0, rc1 =3D 0, rc2 =3D 0;
+	int fbytes =3D 0;
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D substream->runtime->private_data;
+
+	int monofbytes =3D 0;
+	char *bufferp =3D NULL;
+
+	fbytes =3D frames_to_bytes(runtime, frames);
+	monofbytes =3D fbytes / 2;
+	if (runtime->channels =3D=3D 2) {
+		rc =3D alsa_buffer_read(prtd, buf, fbytes, NULL);
+	} else {
+		bufferp =3D buf;
+		rc1 =3D alsa_buffer_read(prtd, bufferp, monofbytes, NULL);
+		bufferp =3D buf + monofbytes ;
+		rc2 =3D alsa_buffer_read(prtd, bufferp, monofbytes, NULL);
+		rc =3D rc1 + rc2;
+	}
+	prtd->pcm_buf_pos +=3D fbytes;
+	return rc;
+}
+
+static snd_pcm_uframes_t
+msm_pcm_capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
+}
+
+static int msm_pcm_capture_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	alsa_audrec_disable(prtd);
+	audmgr_close(&prtd->audmgr);
+	msm_adsp_put(prtd->audrec);
+	msm_adsp_put(prtd->audpre);
+	kfree(prtd);
+
+	return 0;
+}
+
+struct  msm_audio_event_callbacks snd_msm_audio_ops =3D {
+	.playback =3D playback_event_handler,
+	.capture =3D capture_event_handler,
+};
+
+static int msm_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd;
+	int ret =3D 0;
+
+	prtd =3D kzalloc(sizeof(struct msm_audio), GFP_KERNEL);
+	if (prtd =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		return ret;
+	}
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		msm_vol_ctl.update =3D 1; /* Update Volume, with Cached value */
+		runtime->hw =3D msm_pcm_playback_hardware;
+		prtd->dir =3D SNDRV_PCM_STREAM_PLAYBACK;
+		prtd->playback_substream =3D substream;
+	} else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw =3D msm_pcm_capture_hardware;
+		prtd->dir =3D SNDRV_PCM_STREAM_CAPTURE;
+		prtd->capture_substream =3D substream;
+	}
+	ret =3D snd_pcm_hw_constraint_list(runtime, 0,
+						SNDRV_PCM_HW_PARAM_RATE,
+						&constraints_sample_rates);
+	if (ret < 0)
+		goto out;
+	/* Ensure that buffer size is a multiple of period size */
+	ret =3D snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	prtd->ops =3D &snd_msm_audio_ops;
+	prtd->out[0].used =3D BUF_INVALID_LEN;
+	prtd->out_head =3D 1; /* point to second buffer on startup */
+	runtime->private_data =3D prtd;
+
+	ret =3D alsa_adsp_configure(prtd);
+	if (ret)
+		goto out;
+	copy_count =3D 0;
+	return 0;
+
+ out:
+	kfree(prtd);
+	return ret;
+}
+
+static int msm_pcm_playback_copy(struct snd_pcm_substream *substream, in=
t a,
+	snd_pcm_uframes_t hwoff, void __user *buf, snd_pcm_uframes_t frames)
+{
+	int rc =3D 1;
+	int fbytes =3D 0;
+
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	fbytes =3D frames_to_bytes(runtime, frames);
+	rc =3D alsa_send_buffer(prtd, buf, fbytes, NULL);
+	++copy_count;
+	prtd->pcm_buf_pos +=3D fbytes;
+	if (copy_count =3D=3D 1) {
+		mutex_lock(&the_locks.lock);
+		alsa_audio_configure(prtd);
+		mutex_unlock(&the_locks.lock);
+	}
+	if ((prtd->running) && (msm_vol_ctl.update)) {
+		rc =3D msm_audio_volume_update(PCMPLAYBACK_DECODERID,
+				msm_vol_ctl.volume, msm_vol_ctl.pan);
+		msm_vol_ctl.update =3D 0;
+	}
+
+	return  rc;
+}
+
+static int msm_pcm_playback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct msm_audio *prtd =3D runtime->private_data;
+
+	alsa_audio_disable(prtd);
+	audmgr_close(&prtd->audmgr);
+	kfree(prtd);
+
+	return 0;
+}
+
+
+static int msm_pcm_copy(struct snd_pcm_substream *substream, int a,
+	 snd_pcm_uframes_t hwoff, void __user *buf, snd_pcm_uframes_t frames)
+{
+	int ret =3D 0;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		ret =3D msm_pcm_playback_copy(substream, a, hwoff, buf, frames);
+	else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
+		ret =3D msm_pcm_capture_copy(substream, a, hwoff, buf, frames);
+	return ret;
+}
+
+static int msm_pcm_close(struct snd_pcm_substream *substream)
+{
+	int ret =3D 0;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		ret =3D msm_pcm_playback_close(substream);
+	else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
+		ret =3D msm_pcm_capture_close(substream);
+	return ret;
+}
+static int msm_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	int ret =3D 0;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		ret =3D msm_pcm_playback_prepare(substream);
+	else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
+		ret =3D msm_pcm_capture_prepare(substream);
+	return ret;
+}
+
+static snd_pcm_uframes_t msm_pcm_pointer(struct snd_pcm_substream *subst=
ream)
+{
+	snd_pcm_uframes_t ret =3D 0;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		ret =3D msm_pcm_playback_pointer(substream);
+	else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
+		ret =3D msm_pcm_capture_pointer(substream);
+	return ret;
+}
+
+int msm_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+
+	if (substream->pcm->device & 1) {
+		runtime->hw.info &=3D ~SNDRV_PCM_INFO_INTERLEAVED;
+		runtime->hw.info |=3D SNDRV_PCM_INFO_NONINTERLEAVED;
+	}
+	return 0;
+
+}
+
+static struct snd_pcm_ops msm_pcm_ops =3D {
+	.open           =3D msm_pcm_open,
+	.copy		=3D msm_pcm_copy,
+	.hw_params	=3D msm_pcm_hw_params,
+	.close          =3D msm_pcm_close,
+	.ioctl          =3D snd_pcm_lib_ioctl,
+	.prepare        =3D msm_pcm_prepare,
+	.trigger        =3D msm_pcm_trigger,
+	.pointer        =3D msm_pcm_pointer,
+};
+
+
+
+static int msm_pcm_remove(struct platform_device *devptr)
+{
+	struct snd_soc_device *socdev =3D platform_get_drvdata(devptr);
+	snd_soc_free_pcms(socdev);
+	kfree(socdev->codec);
+	platform_set_drvdata(devptr, NULL);
+	return 0;
+}
+
+static int pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+	int stream)
+{
+	struct snd_pcm_substream *substream =3D pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf =3D &substream->dma_buffer;
+	size_t size;
+	if (!stream)
+		size =3D PLAYBACK_DMASZ;
+	else
+		size =3D CAPTURE_DMASZ;
+
+	buf->dev.type =3D SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev =3D pcm->card->dev;
+	buf->private_data =3D NULL;
+	buf->area =3D dma_alloc_coherent(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+
+	buf->bytes =3D size;
+	return 0;
+}
+
+static void msm_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream =3D 0; stream < 2; stream++) {
+		substream =3D pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf =3D &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_coherent(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area =3D NULL;
+	}
+}
+
+static int msm_pcm_new(struct snd_card *card,
+			struct snd_soc_dai *codec_dai,
+			struct snd_pcm *pcm)
+{
+	int ret;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask =3D DMA_32BIT_MASK;
+
+	if (codec_dai->playback.channels_min) {
+		ret =3D pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			return ret;
+	}
+
+	if (codec_dai->capture.channels_min) {
+		ret =3D pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			msm_pcm_free_dma_buffers(pcm);
+	}
+	return ret;
+}
+
+struct snd_soc_platform msm_soc_platform =3D {
+	.name		=3D "msm-audio",
+	.remove         =3D msm_pcm_remove,
+	.pcm_ops 	=3D &msm_pcm_ops,
+	.pcm_new	=3D msm_pcm_new,
+	.pcm_free	=3D msm_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL(msm_soc_platform);
+
+static int __init msm_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&msm_soc_platform);
+}
+module_init(msm_soc_platform_init);
+
+static void __exit msm_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&msm_soc_platform);
+}
+module_exit(msm_soc_platform_exit);
+
+MODULE_DESCRIPTION("PCM module platform driver");
+MODULE_LICENSE("GPL v2");

--------------1.6.4.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------1.6.4.4--
