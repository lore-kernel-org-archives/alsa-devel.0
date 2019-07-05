From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Simplify snd_hdac_refresh_widgets()
Date: Fri,  5 Jul 2019 12:06:05 +0200
Message-ID: <20190705100605.19945-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50F27F800E7
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2019 12:06:11 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Evan Green <evgreen@chromium.org>
List-Id: alsa-devel@alsa-project.org

Along with the recent fix for the races of snd_hdac_refresh_widgets()
it turned out that the instantiation of widgets sysfs at
snd_hdac_sysfs_reinit() could cause a race.  The race itself was
already covered later by extending the mutex protection range, the
commit 98482377dc72 ("ALSA: hda: Fix widget_mutex incomplete
protection"), but this also indicated that the call of *_reinit() is
basically superfluous, as the widgets shall be created sooner or later
from snd_hdac_device_register().

This patch removes the redundant call of snd_hdac_sysfs_reinit() at
first.  By this removal, the sysfs argument itself in
snd_hdac_refresh_widgets() becomes superfluous, too, because the only
case sysfs=false is always with codec->widgets=NULL.  So, we drop this
redundant argument as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h      |  2 +-
 sound/hda/hdac_device.c      | 13 +++++--------
 sound/hda/hdac_sysfs.c       |  2 +-
 sound/pci/hda/hda_codec.c    |  2 +-
 sound/soc/codecs/hdac_hdmi.c |  2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index e8346784cf3f..f475293d0668 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -120,7 +120,7 @@ void snd_hdac_device_unregister(struct hdac_device *codec);
 int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name);
 int snd_hdac_codec_modalias(struct hdac_device *hdac, char *buf, size_t size);
 
-int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs);
+int snd_hdac_refresh_widgets(struct hdac_device *codec);
 
 unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
 			       unsigned int verb, unsigned int parm);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 11050bfd8068..a265c1d68876 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -89,7 +89,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 
 	fg = codec->afg ? codec->afg : codec->mfg;
 
-	err = snd_hdac_refresh_widgets(codec, false);
+	err = snd_hdac_refresh_widgets(codec);
 	if (err < 0)
 		goto error;
 
@@ -394,9 +394,8 @@ static void setup_fg_nodes(struct hdac_device *codec)
 /**
  * snd_hdac_refresh_widgets - Reset the widget start/end nodes
  * @codec: the codec object
- * @sysfs: re-initialize sysfs tree, too
  */
-int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
+int snd_hdac_refresh_widgets(struct hdac_device *codec)
 {
 	hda_nid_t start_nid;
 	int nums, err = 0;
@@ -414,11 +413,9 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 		goto unlock;
 	}
 
-	if (sysfs) {
-		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
-		if (err < 0)
-			goto unlock;
-	}
+	err = hda_widget_sysfs_reinit(codec, start_nid, nums);
+	if (err < 0)
+		goto unlock;
 
 	codec->num_nodes = nums;
 	codec->start_nid = start_nid;
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 909d5ef1179c..e56e83325903 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -428,7 +428,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	int i;
 
 	if (!codec->widgets)
-		return hda_widget_sysfs_init(codec);
+		return 0;
 
 	tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
 	if (!tree)
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index fcdf2cd3783b..d1a0e0de80ac 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1016,7 +1016,7 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 	hda_nid_t fg;
 	int err;
 
-	err = snd_hdac_refresh_widgets(&codec->core, true);
+	err = snd_hdac_refresh_widgets(&codec->core);
 	if (err < 0)
 		return err;
 
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 660e0587f399..6302ad5b7128 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2043,7 +2043,7 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 			"Failed in parse and map nid with err: %d\n", ret);
 		return ret;
 	}
-	snd_hdac_refresh_widgets(hdev, true);
+	snd_hdac_refresh_widgets(hdev);
 
 	/* ASoC specific initialization */
 	ret = devm_snd_soc_register_component(&hdev->dev, &hdmi_hda_codec,
-- 
2.16.4
