From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix widget sysfs tree corruption
	after refresh
Date: Wed, 26 Aug 2015 07:50:56 +0200
Message-ID: <1440568256-14336-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 864B3265307
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 07:50:58 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3ABECAC4A
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 05:50:58 +0000 (UTC)
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

When snd_hdac_refresh_widget_sysfs() is called before the first
hda_widget_sysfs_init(), the next call overrides and eventually
fails.  This results in unexpected Oops, something like:
  BUG: unable to handle kernel NULL pointer dereference at 00000000000000c8
  IP: [<ffffffff8180e2a3>] hdmi_chmap_ctl_info+0x23/0x40

The fix is to add a check of the existing sysfs tree.  Also, for more
safety, this patch adds the checks of device_is_registered() in
snd-hdac_refresh_wdiget_sysfs(), too.

Fixes: fa4f18b4f402 ('ALSA: hda - Refresh widgets sysfs at probing Haswell+ HDMI codecs')
Bugizlla: https://bugzilla.kernel.org/show_bug.cgi?id=103431
Reported-by: Andreas Reis <andreas.reis@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_device.c | 14 ++++++++------
 sound/hda/hdac_sysfs.c  |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index aa6d6cec2380..db96042a497f 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -384,18 +384,20 @@ int snd_hdac_refresh_widget_sysfs(struct hdac_device *codec)
 {
 	int ret;
 
-	hda_widget_sysfs_exit(codec);
+	if (device_is_registered(&codec->dev))
+		hda_widget_sysfs_exit(codec);
 	ret = snd_hdac_refresh_widgets(codec);
 	if (ret) {
 		dev_err(&codec->dev, "failed to refresh widget: %d\n", ret);
 		return ret;
 	}
-	ret = hda_widget_sysfs_init(codec);
-	if (ret) {
-		dev_err(&codec->dev, "failed to init sysfs: %d\n", ret);
-		return ret;
+	if (device_is_registered(&codec->dev)) {
+		ret = hda_widget_sysfs_init(codec);
+		if (ret) {
+			dev_err(&codec->dev, "failed to init sysfs: %d\n", ret);
+			return ret;
+		}
 	}
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_refresh_widget_sysfs);
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 089b35f6f108..c71142dea98a 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -390,6 +390,9 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 {
 	int err;
 
+	if (codec->widgets)
+		return 0; /* already created */
+
 	err = widget_tree_create(codec);
 	if (err < 0) {
 		widget_tree_free(codec);
-- 
2.5.0
