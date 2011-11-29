From: David Henningsson <david.henningsson@canonical.com>
Subject: Tests of the hda-jack branch
Date: Tue, 29 Nov 2011 20:43:06 +0100
Message-ID: <4ED535CA.1080108@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050907080508000907070701"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 4294A2441E
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 20:43:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050907080508000907070701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

I've done some more tests of your branch now, and the new names seems to 
work for my machine here.

I'm attaching two patches - one adds a "device index" for mapping 
against pcm devices on HDMI, the other one is a backport for the 
driver-build tree.

What are your thoughts on how to proceed, when do you think this is 
ready to be merged into the topic/hda branch?

// David


--------------050907080508000907070701
Content-Type: text/x-patch;
 name="0001-alsa-driver-build-Make-new-jack-API-compile-on-older.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-driver-build-Make-new-jack-API-compile-on-older.pa";
 filename*1="tch"

>From 0f14d27ffebf72b636c765e95003c780a1cb8c07 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 29 Nov 2011 19:41:27 +0100
Subject: [PATCH] alsa-driver-build: Make new jack API compile on older
 kernels

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 acore/ctljack.c    |    4 ++++
 pci/hda/hda_jack.c |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 acore/ctljack.c
 create mode 100644 pci/hda/hda_jack.c

diff --git a/acore/ctljack.c b/acore/ctljack.c
new file mode 100644
index 0000000..4d9352f
--- /dev/null
+++ b/acore/ctljack.c
@@ -0,0 +1,4 @@
+#define __NO_VERSION__
+#include "adriver.h"
+#include "../alsa-kernel/core/ctljack.c"
+
diff --git a/pci/hda/hda_jack.c b/pci/hda/hda_jack.c
new file mode 100644
index 0000000..160ad73
--- /dev/null
+++ b/pci/hda/hda_jack.c
@@ -0,0 +1,3 @@
+#include "adriver.h"
+#include "../../alsa-kernel/pci/hda/hda_jack.c"
+
-- 
1.7.5.4




--------------050907080508000907070701
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Jack-Make-device-indices-for-HDMI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Jack-Make-device-indices-for-HDMI.patch"

>From 4b4c17927eb05b460a9788d9dfc9a03ace5d160e Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 29 Nov 2011 20:19:56 +0100
Subject: [PATCH] ALSA: HDA/Jack: Make device indices for HDMI

Make sure we can associate HDMI Jacks with the correct PCM devices.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c   |    5 +++--
 sound/pci/hda/hda_jack.h   |    2 +-
 sound/pci/hda/patch_hdmi.c |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 3949015..0b1f72c 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -210,7 +210,7 @@ EXPORT_SYMBOL_HDA(snd_hda_jack_report_sync);
  * will have the given name and index.
  */
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx)
+			  const char *name, int idx, int device)
 {
 	struct hda_jack_tbl *jack;
 	struct snd_kcontrol *kctl;
@@ -223,6 +223,7 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	kctl = snd_kctl_jack_new(name, idx, codec);
 	if (!kctl)
 		return -ENOMEM;
+	kctl->id.device = device;
 	if (snd_hda_ctl_add(codec, nid, kctl) < 0)
 		return -ENOMEM;
 	jack->kctl = kctl;
@@ -249,7 +250,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 		return 0;
 
 	snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
-	err = snd_hda_jack_add_kctl(codec, nid, name, idx);
+	err = snd_hda_jack_add_kctl(codec, nid, name, idx, 0);
 	if (err < 0)
 		return err;
 	return snd_hda_jack_detect_enable(codec, nid, 0);
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index f8f97c7..fcca96c 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -76,7 +76,7 @@ static inline bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 }
 
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx);
+			  const char *name, int idx, int device);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bb8cfc6..9689c8d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1277,7 +1277,8 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		err = snd_hda_jack_add_kctl(codec, per_pin->pin_nid,
-					    "HDMI", pin_idx);
+					    "HDMI", pin_idx,
+					    spec->pcm_rec[pin_idx].device);
 		if (err < 0)
 			return err;
 	}
-- 
1.7.5.4



--------------050907080508000907070701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050907080508000907070701--
