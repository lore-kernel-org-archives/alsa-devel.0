From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/17] ALSA: oxfw: rename a structure so that
	it means backward compatibility to old drivers
Date: Sun,  6 Dec 2015 13:18:17 +0900
Message-ID: <1449375505-2704-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AE39D2651AC
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commits, some model-specific members are split from the
structure. The structure is just to keep old names for compatibility to
old drivers.

This commit arranges name of the structure and moves it to localize.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 14 ++++++++++----
 sound/firewire/oxfw/oxfw.h |  6 ------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 16ee6ea..96fbb78 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -30,6 +30,12 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
+struct compat_info {
+	const char *driver_name;
+	const char *vendor_name;
+	const char *model_name;
+};
+
 static bool detect_loud_models(struct fw_unit *unit)
 {
 	const char *const models[] = {
@@ -59,7 +65,7 @@ static bool detect_loud_models(struct fw_unit *unit)
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
-	const struct device_info *info;
+	const struct compat_info *info;
 	char vendor[24];
 	char model[32];
 	const char *d, *v, *m;
@@ -87,7 +93,7 @@ static int name_card(struct snd_oxfw *oxfw)
 	/* to apply card definitions */
 	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN ||
 	    oxfw->entry->vendor_id == VENDOR_LACIE) {
-		info = (const struct device_info *)oxfw->entry->driver_data;
+		info = (const struct compat_info *)oxfw->entry->driver_data;
 		d = info->driver_name;
 		v = info->vendor_name;
 		m = info->model_name;
@@ -279,13 +285,13 @@ static void oxfw_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(oxfw->card);
 }
 
-static const struct device_info griffin_firewave = {
+static const struct compat_info griffin_firewave = {
 	.driver_name = "FireWave",
 	.vendor_name = "Griffin",
 	.model_name = "FireWave",
 };
 
-static const struct device_info lacie_speakers = {
+static const struct compat_info lacie_speakers = {
 	.driver_name = "FWSpeakers",
 	.vendor_name = "LaCie",
 	.model_name = "FireWire Speakers",
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 6038150..1c9844a 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -31,12 +31,6 @@
 #include "../amdtp-am824.h"
 #include "../cmp.h"
 
-struct device_info {
-	const char *driver_name;
-	const char *vendor_name;
-	const char *model_name;
-};
-
 /* This is an arbitrary number for convinience. */
 #define	SND_OXFW_STREAM_FORMAT_ENTRIES	10
 struct snd_oxfw {
-- 
2.5.0
