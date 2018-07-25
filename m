From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/12] ALSA: usb-audio: Declare the common
	variable in header file
Date: Wed, 25 Jul 2018 23:00:53 +0200
Message-ID: <20180725210057.18017-9-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD48B26775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id ADDE0B0B0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Declare snd_usb_feature_unit_ctl properly in mixer.h.  Otherwise it's
error-prone.

This fixes the sparse warning:
  sound/usb/mixer.c:1464:25: warning: symbol 'snd_usb_feature_unit_ctl' was not declared. Should it be static?

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.h        | 2 ++
 sound/usb/mixer_quirks.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index e02653465e29..3d12af8bf191 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -109,4 +109,6 @@ int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
 
 extern void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl);
 
+extern struct snd_kcontrol_new *snd_usb_feature_unit_ctl;
+
 #endif /* __USBMIXER_H */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e82a72fea9a1..cbfb48bdea51 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -47,8 +47,6 @@
 #include "mixer_us16x08.h"
 #include "helper.h"
 
-extern struct snd_kcontrol_new *snd_usb_feature_unit_ctl;
-
 struct std_mono_table {
 	unsigned int unitid, control, cmask;
 	int val_type;
-- 
2.18.0
