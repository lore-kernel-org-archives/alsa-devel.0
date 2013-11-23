From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/13] bebob: Add functionality to change
	sampling rate and control interface
Date: Sat, 23 Nov 2013 15:09:16 +0900
Message-ID: <1385186965-8303-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 05F7226530A
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:35 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds the functionality to change sampling rate. To debug this,
this commit also adds control interface. I plan to extend this control
interface for the other functionality.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile        |   2 +-
 sound/firewire/bebob/bebob.c         |   4 +
 sound/firewire/bebob/bebob.h         |   4 +
 sound/firewire/bebob/bebob_control.c | 148 +++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_stream.c  |   2 +
 5 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_control.c

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 6e44fa0..bec01cd 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,3 @@
-snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o \
+snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index e5aa96e..71a3896 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -177,6 +177,10 @@ snd_bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_bebob_create_control_devices(bebob);
+	if (err < 0)
+		goto error;
+
 	snd_bebob_proc_init(bebob);
 
 	err = snd_bebob_stream_discover(bebob);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 2d60165..d87999e 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -30,6 +30,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
+#include <sound/control.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -74,6 +75,7 @@ struct snd_bebob {
 	struct snd_bebob_stream_formation
 		rx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
 
+	struct snd_ctl_elem_id *ctl_id_freq;
 };
 
 static inline int
@@ -149,6 +151,8 @@ void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
 void snd_bebob_proc_init(struct snd_bebob *bebob);
 
+int snd_bebob_create_control_devices(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_control.c b/sound/firewire/bebob/bebob_control.c
new file mode 100644
index 0000000..f9a9229
--- /dev/null
+++ b/sound/firewire/bebob/bebob_control.c
@@ -0,0 +1,148 @@
+/*
+ * bebob_control.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "bebob.h"
+
+
+/*
+ * Global Control: Sampling Rate Control
+ *
+ * refer to snd_bebob_rate_table.
+ */
+static int
+control_sampling_rate_info(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_info *einf)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int i, value;
+
+	/* maximum value for user */
+	einf->value.enumerated.items = 0;
+	for (i = 0; i < ARRAY_SIZE(snd_bebob_rate_table); i++)
+		if ((bebob->tx_stream_formations[i].pcm > 0) &&
+		    (bebob->rx_stream_formations[i].pcm > 0))
+			einf->value.enumerated.items++;
+
+	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	einf->count = 1;
+
+	if (einf->value.enumerated.item >= einf->value.enumerated.items)
+		einf->value.enumerated.item = einf->value.enumerated.items - 1;
+
+	/* skip unsupported sampling rates */
+	value = einf->value.enumerated.item;
+	for (i = 0; i < ARRAY_SIZE(snd_bebob_rate_table); i++) {
+		if ((bebob->tx_stream_formations[i].pcm == 0) ||
+		    (bebob->rx_stream_formations[i].pcm == 0))
+			continue;
+		else if (value == 0)
+			break;
+		else
+			value--;
+	}
+
+	sprintf(einf->value.enumerated.name, "%dHz", snd_bebob_rate_table[i]);
+
+	return 0;
+}
+static int
+control_sampling_rate_get(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int i, sampling_rate, index;
+	int err;
+
+	mutex_lock(&bebob->mutex);
+
+	err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
+	if (err < 0)
+		goto end;
+
+	for (index = 0; index < ARRAY_SIZE(snd_bebob_rate_table); index++)
+		if (snd_bebob_rate_table[index] == sampling_rate)
+			break;
+
+	uval->value.enumerated.item[0] = 0;
+	for (i = 0; i < index; i++)
+		if ((bebob->tx_stream_formations[i].pcm != 0) ||
+		    (bebob->rx_stream_formations[i].pcm != 0))
+			uval->value.enumerated.item[0]++;
+
+end:
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+static int
+control_sampling_rate_put(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int index, sampling_rate;
+	int value, changed = 0;
+
+	/* get index from user value*/
+	value = uval->value.enumerated.item[0];
+	for (index = 0; index < ARRAY_SIZE(snd_bebob_rate_table); index++) {
+		if ((bebob->tx_stream_formations[index].pcm == 0) ||
+		    (bebob->rx_stream_formations[index].pcm == 0))
+			continue;
+		else if (value == 0)
+			break;
+		else
+			value--;
+	}
+
+	sampling_rate = snd_bebob_rate_table[index];
+
+	mutex_lock(&bebob->mutex);
+	if (snd_bebob_stream_set_rate(bebob, sampling_rate) < 0)
+		goto end;
+
+	/* prevent from failure of getting command just after setting */
+	msleep(100);
+	changed = 1;
+
+	snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       bebob->ctl_id_freq);
+end:
+	mutex_unlock(&bebob->mutex);
+	return changed;
+}
+
+static struct snd_kcontrol_new global_sampling_rate_control = {
+	.name	= "Sampling Rate",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= control_sampling_rate_info,
+	.get	= control_sampling_rate_get,
+	.put	= control_sampling_rate_put
+};
+
+int snd_bebob_create_control_devices(struct snd_bebob *bebob)
+{
+	int err = 0;
+	struct snd_kcontrol *kctl;
+
+	kctl = snd_ctl_new1(&global_sampling_rate_control, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+	if (err < 0)
+		goto end;
+	bebob->ctl_id_freq = &kctl->id;
+end:
+	return err;
+}
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 6852945..773dffb 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -368,6 +368,8 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 		err = snd_bebob_stream_set_rate(bebob, rate);
 		if (err < 0)
 			goto end;
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       bebob->ctl_id_freq);
 
 		err = make_both_connections(bebob, rate);
 		if (err < 0)
-- 
1.8.3.2
