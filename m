From: klem.dev@gmail.com
Subject: [PATCH 3/4] ESI W192M: Add sampling rate control.
Date: Sat,  5 Oct 2013 15:41:04 +0200
Message-ID: <525016f1.a556b40a.02db.ffff9b74@mx.google.com>
References: <1380980465-5961-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1380980465-5961-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Clement Guedez <klem.dev@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Clement Guedez <klem.dev@gmail.com>

Add sampling rate control for adc/dac in  Ego Sys Waveterminal 192M.

Signed-off-by: Clement Guedez <klem.dev@gmail.com>
---
 sound/pci/ice1712/wtm.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index d559916..cf2b6a5 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <sound/core.h>
+#include <linux/slab.h>
 #include <sound/tlv.h>
 
 #include "ice1712.h"
@@ -69,6 +70,37 @@ static inline unsigned char stac9460_2_get(struct snd_ice1712 *ice, int reg)
 /*
  *	DAC mute control
  */
+static void stac9460_dac_mute_all(struct snd_ice1712 *ice, unsigned char mute,
+				  unsigned char *change)
+{
+	unsigned char new, old;
+	int idx;
+
+	/*stac9460 1*/
+	for (idx = 0; idx < 7; idx++) {
+		if (change[idx]) {
+			old = stac9460_get(ice, idx);
+			new = (~mute << 7 & 0x80) | (old & ~0x80);
+			change[idx] = (new != old);
+			if (change[idx])
+				stac9460_put(ice, idx, new);
+		}
+	}
+
+	/*stac9460 2*/
+	for (idx = 0; idx < 3; idx++) {
+		if (change[idx + 7]) {
+			old = stac9460_2_get(ice, idx);
+			new = (~mute << 7 & 0x80) | (old & ~0x80);
+			change[idx + 7] = (new != old);
+			if (change[idx + 7])
+				stac9460_2_put(ice, idx, new);
+		}
+	}
+}
+
+
+
 #define stac9460_dac_mute_info		snd_ctl_boolean_mono_info
 
 static int stac9460_dac_mute_get(struct snd_kcontrol *kcontrol,
@@ -97,10 +129,13 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct mutex *mute_mutex = ice->spec;
 	unsigned char new, old;
 	int id, idx;
 	int change;
 
+	mutex_lock(mute_mutex);
+
 	if (kcontrol->private_value) {
 		idx = STAC946X_MASTER_VOLUME;
 		old = stac9460_get(ice, idx);
@@ -128,6 +163,9 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 				stac9460_2_put(ice, idx - 6, new);
 		}
 	}
+
+	mutex_unlock(mute_mutex);
+
 	return change;
 }
 
@@ -381,6 +419,41 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+/*
+ * Handler for setting correct codec rate - called when rate change is detected
+ */
+static void stac9460_set_rate_val(struct snd_ice1712 *ice, unsigned int rate)
+{
+	unsigned char old, new;
+	unsigned char changed[10];
+	struct mutex *mute_mutex = ice->spec;
+
+	if (rate == 0)  /* no hint - S/PDIF input is master, simply return */
+		return;
+	else if (rate <= 48000)
+		new = 0x08;     /* 256x, base rate mode */
+	else if (rate <= 96000)
+		new = 0x11;     /* 256x, mid rate mode */
+	else
+		new = 0x12;     /* 128x, high rate mode */
+	old = stac9460_get(ice, STAC946X_MASTER_CLOCKING);
+	if (old == new)
+		return;
+	/* change detected, setting master clock, muting first */
+	/* due to possible conflicts with mute controls - mutexing */
+	mutex_lock(mute_mutex);
+	/* we have to remember current mute status for each DAC */
+	stac9460_dac_mute_all(ice, 0, changed);
+	/*printk(KERN_DEBUG "Rate change: %d, new MC: 0x%02x\n", rate, new);*/
+	stac9460_put(ice, STAC946X_MASTER_CLOCKING, new);
+	udelay(10);
+	/* unmuting - only originally unmuted dacs -
+	* i.e. those changed when muting */
+	stac9460_dac_mute_all(ice, 1, changed);
+	mutex_unlock(mute_mutex);
+}
+
+
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dac, -19125, 75, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
@@ -479,9 +552,11 @@ static int wtm_init(struct snd_ice1712 *ice)
 {
 	static unsigned short stac_inits_wtm[] = {
 		STAC946X_RESET, 0,
+		STAC946X_MASTER_CLOCKING, 0x11,
 		(unsigned short)-1
 	};
 	unsigned short *p;
+	struct mutex *mute_mutex;
 
 	/*WTM 192M*/
 	ice->num_total_dacs = 8;
@@ -489,12 +564,20 @@ static int wtm_init(struct snd_ice1712 *ice)
 	ice->force_rdma1 = 1;
 	ice->vt1720 = 0;  /* ice1724, e.g. 23 GPIOs */
 
+	mute_mutex = kzalloc(sizeof(*mute_mutex), GFP_KERNEL);
+	if (!mute_mutex)
+		return -ENOMEM;
+	ice->spec = mute_mutex;
+	mutex_init(mute_mutex);
+
+
 	/*initialize codec*/
 	p = stac_inits_wtm;
 	for (; *p != (unsigned short)-1; p += 2) {
 		stac9460_put(ice, p[0], p[1]);
 		stac9460_2_put(ice, p[0], p[1]);
 	}
+	ice->gpio.set_pro_rate = stac9460_set_rate_val;
 	return 0;
 }
 
-- 
1.8.4.rc3
