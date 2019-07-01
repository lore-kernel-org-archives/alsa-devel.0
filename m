From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v3] ALSA: hda: Fix widget_mutex incomplete protection
Date: Mon,  1 Jul 2019 10:30:30 -0700
Message-ID: <20190701173030.168346-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

The widget_mutex was introduced to serialize callers to
hda_widget_sysfs_{re}init. However, its protection of the sysfs widget array
is incomplete. For example, it is acquired around the call to
hda_widget_sysfs_reinit(), which actually creates the new array, but isn't
still acquired when codec->num_nodes and codec->start_nid is updated. So
the lock ensures one thread sets up the new array at a time, but doesn't
ensure which thread's value will end up in codec->num_nodes. If a larger
num_nodes wins but a smaller array was set up, the next call to
refresh_widgets() will touch free memory as it iterates over codec->num_nodes
that aren't there.

The widget_lock really protects both the tree as well as codec->num_nodes,
start_nid, and end_nid, so make sure it's held across that update. It should
also be held during snd_hdac_get_sub_nodes(), so that a very old read from that
function doesn't end up clobbering a later update.

Fixes: ed180abba7f1 ("ALSA: hda: Fix race between creating and refreshing sysfs entries")

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v3:
- Moved locking back into callers (Takashi)
- Combined update_widgets exit flow (Takashi)

Changes in v2:
- Introduced widget_mutex relocation

 sound/hda/hdac_device.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6907dbefd08c..3842f9d34b7c 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -400,27 +400,33 @@ static void setup_fg_nodes(struct hdac_device *codec)
 int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 {
 	hda_nid_t start_nid;
-	int nums, err;
+	int nums, err = 0;
 
+	/*
+	 * Serialize against multiple threads trying to update the sysfs
+	 * widgets array.
+	 */
+	mutex_lock(&codec->widget_lock);
 	nums = snd_hdac_get_sub_nodes(codec, codec->afg, &start_nid);
 	if (!start_nid || nums <= 0 || nums >= 0xff) {
 		dev_err(&codec->dev, "cannot read sub nodes for FG 0x%02x\n",
 			codec->afg);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	if (sysfs) {
-		mutex_lock(&codec->widget_lock);
 		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
-		mutex_unlock(&codec->widget_lock);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
 
 	codec->num_nodes = nums;
 	codec->start_nid = start_nid;
 	codec->end_nid = start_nid + nums;
-	return 0;
+unlock:
+	mutex_unlock(&codec->widget_lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_refresh_widgets);
 
-- 
2.20.1
