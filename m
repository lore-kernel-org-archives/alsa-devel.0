From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 1/4] ALSA: usb-audio: Initial Power Domain
	support
Date: Mon, 30 Jul 2018 10:23:33 +0100
Message-ID: <20180730092336.18741-2-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 8693426779B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 11:23:41 +0200 (CEST)
In-Reply-To: <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thee USB Audio Class 3 (UAC3) introduces Power Domains as a new
feature to let a host turn individual parts of an audio function
to different power states via USB requests. This lets the device
get to know a bit amore about what the host is up to in order to
optimize power consumption efficiently.

The Power Domains are optional for UAC3 configuration but all
UAC3 devices shall include at least one BADD configuration where
the support for Power Domains is compulsory.

This patch adds a set of features/helpers to parse these power
domains and change their status.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/linux/usb/audio-v3.h |   4 ++
 sound/usb/Makefile           |   1 +
 sound/usb/power.c            | 118 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/power.h            |  19 +++++++
 4 files changed, 142 insertions(+)
 create mode 100644 sound/usb/power.c

diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index 334bfa6dfb47..786e5939d831 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -447,4 +447,8 @@ struct uac3_interrupt_data_msg {
 /* BADD sample rate is always fixed to 48kHz */
 #define UAC3_BADD_SAMPLING_RATE				48000
 
+/* BADD power domains recovery times */
+#define UAC3_BADD_PD_RECOVER_D1D0			0x0258
+#define UAC3_BADD_PD_RECOVER_D2D0			0x1770
+
 #endif /* __LINUX_USB_AUDIO_V3_H */
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 05440e2df8d9..a4d69638b501 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -15,6 +15,7 @@ snd-usb-audio-objs := 	card.o \
 			pcm.o \
 			proc.o \
 			quirks.o \
+			power.o \
 			stream.o
 
 snd-usbmidi-lib-objs := midi.o
diff --git a/sound/usb/power.c b/sound/usb/power.c
new file mode 100644
index 000000000000..ce3fea2bd030
--- /dev/null
+++ b/sound/usb/power.c
@@ -0,0 +1,118 @@
+/*
+ *   UAC3 Power Domain state management functions
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
+#include <linux/usb/audio-v3.h>
+
+#include "usbaudio.h"
+#include "helper.h"
+#include "power.h"
+
+struct snd_usb_power_domain *
+snd_usb_find_power_domain(struct usb_host_interface *ctrl_iface,
+			  unsigned char id)
+{
+	struct snd_usb_power_domain *pd;
+	void *p;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return NULL;
+
+	p = NULL;
+	while ((p = snd_usb_find_csint_desc(ctrl_iface->extra,
+					    ctrl_iface->extralen,
+					    p, UAC3_POWER_DOMAIN)) != NULL) {
+		struct uac3_power_domain_descriptor *pd_desc = p;
+		int i;
+
+		for (i = 0; i < pd_desc->bNrEntities; i++) {
+			if (pd_desc->baEntityID[i] == id) {
+				pd->pd_id = pd_desc->bPowerDomainID;
+				pd->pd_d1d0_rec =
+					le16_to_cpu(pd_desc->waRecoveryTime1);
+				pd->pd_d2d0_rec =
+					le16_to_cpu(pd_desc->waRecoveryTime2);
+				return pd;
+			}
+		}
+	}
+
+	kfree(pd);
+	return NULL;
+}
+
+int snd_usb_power_domain_set(struct snd_usb_audio *chip,
+			     struct snd_usb_power_domain *pd,
+			     unsigned char state)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned char current_state;
+	int err, idx;
+
+	idx = snd_usb_ctrl_intf(chip) | (pd->pd_id << 8);
+
+	err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+			      UAC2_CS_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			      UAC3_AC_POWER_DOMAIN_CONTROL << 8, idx,
+			      &current_state, sizeof(current_state));
+	if (err < 0) {
+		dev_err(&dev->dev, "Can't get UAC3 power state for id %d\n",
+			pd->pd_id);
+		return err;
+	}
+
+	if (current_state == state) {
+		dev_dbg(&dev->dev, "UAC3 power domain id %d already in state %d\n",
+			pd->pd_id, state);
+		return 0;
+	}
+
+	err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0), UAC2_CS_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			      UAC3_AC_POWER_DOMAIN_CONTROL << 8, idx,
+			      &state, sizeof(state));
+	if (err < 0) {
+		dev_err(&dev->dev, "Can't set UAC3 power state to %d for id %d\n",
+			state, pd->pd_id);
+		return err;
+	}
+
+	if (state == UAC3_PD_STATE_D0) {
+		switch (current_state) {
+		case UAC3_PD_STATE_D2:
+			udelay(pd->pd_d2d0_rec * 50);
+			break;
+		case UAC3_PD_STATE_D1:
+			udelay(pd->pd_d1d0_rec * 50);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	dev_dbg(&dev->dev, "UAC3 power domain id %d change to state %d\n",
+		pd->pd_id, state);
+
+	return 0;
+}
diff --git a/sound/usb/power.h b/sound/usb/power.h
index b2e25f60c5a2..6004231a7c75 100644
--- a/sound/usb/power.h
+++ b/sound/usb/power.h
@@ -2,6 +2,25 @@
 #ifndef __USBAUDIO_POWER_H
 #define __USBAUDIO_POWER_H
 
+struct snd_usb_power_domain {
+	int pd_id;              /* UAC3 Power Domain ID */
+	int pd_d1d0_rec;        /* D1 to D0 recovery time */
+	int pd_d2d0_rec;        /* D2 to D0 recovery time */
+};
+
+enum {
+	UAC3_PD_STATE_D0,
+	UAC3_PD_STATE_D1,
+	UAC3_PD_STATE_D2,
+};
+
+int snd_usb_power_domain_set(struct snd_usb_audio *chip,
+			     struct snd_usb_power_domain *pd,
+			     unsigned char state);
+struct snd_usb_power_domain *
+snd_usb_find_power_domain(struct usb_host_interface *ctrl_iface,
+			  unsigned char id);
+
 #ifdef CONFIG_PM
 int snd_usb_autoresume(struct snd_usb_audio *chip);
 void snd_usb_autosuspend(struct snd_usb_audio *chip);
-- 
2.11.0
