From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-tascam: add new hwdep ioctl
	command to get state image
Date: Fri, 23 Nov 2018 13:13:04 +0900
Message-ID: <20181123041307.22980-3-o-takashi@sakamocchi.jp>
References: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D6E71267865
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 05:13:35 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id z10so2504095pgp.7
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 20:13:35 -0800 (PST)
In-Reply-To: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: sbahling@suse.com, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In a previous commit, ALSA firewire-tascam driver stores state image
from tx isochronous packets. This image includes states of knob, fader,
button of control surface, level of gain/volume of each physical
inputs/outputs, and so on. It's useful for userspace applications to
read whole of the image.

This commit adds a unique ioctl command for ALSA hwdep interface for the
purpose. For actual meaning of each bits in this image, please refer to
discussion in alsa-devel[1].

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-October/140785.html

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h        |  5 +++++
 sound/firewire/tascam/tascam-hwdep.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index b9bc4bb1756b..012f81bf4750 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -66,6 +66,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_IOCTL_GET_INFO _IOR('H', 0xf8, struct snd_firewire_get_info)
 #define SNDRV_FIREWIRE_IOCTL_LOCK      _IO('H', 0xf9)
 #define SNDRV_FIREWIRE_IOCTL_UNLOCK    _IO('H', 0xfa)
+#define SNDRV_FIREWIRE_IOCTL_TASCAM_STATE _IOR('H', 0xfb, struct snd_firewire_tascam_state)
 
 #define SNDRV_FIREWIRE_TYPE_DICE	1
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
@@ -90,4 +91,8 @@ struct snd_firewire_get_info {
 
 #define SNDRV_FIREWIRE_TASCAM_STATE_COUNT	64
 
+struct snd_firewire_tascam_state {
+	__be32 data[SNDRV_FIREWIRE_TASCAM_STATE_COUNT];
+};
+
 #endif /* _UAPI_SOUND_FIREWIRE_H_INCLUDED */
diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
index 4e4c1e9020e8..a80397116c48 100644
--- a/sound/firewire/tascam/tascam-hwdep.c
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -123,6 +123,14 @@ static int hwdep_unlock(struct snd_tscm *tscm)
 	return err;
 }
 
+static int tscm_hwdep_state(struct snd_tscm *tscm, void __user *arg)
+{
+	if (copy_to_user(arg, tscm->state, sizeof(tscm->state)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
 {
 	struct snd_tscm *tscm = hwdep->private_data;
@@ -147,6 +155,8 @@ static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
 		return hwdep_lock(tscm);
 	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
 		return hwdep_unlock(tscm);
+	case SNDRV_FIREWIRE_IOCTL_TASCAM_STATE:
+		return tscm_hwdep_state(tscm, (void __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.19.1
