From: =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>
Subject: [PATCH 2/2] ALSA:line6: remove unnecessary
	initialization to PODHD500X.
Date: Fri, 16 Jun 2017 14:14:17 -0400
Message-ID: <1497636857-13944-2-git-send-email-hmoller@uc.cl>
References: <1497636857-13944-1-git-send-email-hmoller@uc.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C7AB266D08
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 20:14:27 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id w1so12010435qtg.0
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 11:14:27 -0700 (PDT)
In-Reply-To: <1497636857-13944-1-git-send-email-hmoller@uc.cl>
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
Cc: stefanha@gmail.com, "Hans P . Moller" <hmoller@uc.cl>, dev@andree.sk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Body:
Remove Initialization from POD HD500X because it's not needed.
Every time the device is connected dmesg gives the following output: "receive length failed (error -11)".
To solve this problem, another flags is introduced (LINE6_CAP_CONTROL_INFO) and it is only used for PODX3 in: sysfs entries, call podhd_startup_finalize(pod) and disconnection.
With this patch the error disappear.

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
---
 sound/usb/line6/driver.h |  2 ++
 sound/usb/line6/podhd.c  | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index a5c2e9a..dc97895 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -117,6 +117,8 @@ enum {
 	LINE6_CAP_IN_NEEDS_OUT = 1 << 3,
 	/* device uses raw MIDI via USB (data endpoints) */
 	LINE6_CAP_CONTROL_MIDI = 1 << 4,
+	/* device provides low-level information */
+	LINE6_CAP_CONTROL_INFO = 1 << 5,
 };
 
 /*
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index e389f92..49c034c 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -293,7 +293,7 @@ static void podhd_disconnect(struct usb_line6 *line6)
 {
 	struct usb_line6_podhd *pod = (struct usb_line6_podhd *)line6;
 
-	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
+	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO) {
 		struct usb_interface *intf;
 
 		del_timer_sync(&pod->startup_timer);
@@ -333,7 +333,9 @@ static int podhd_init(struct usb_line6 *line6,
 				pod->line6.properties->ctrl_if, err);
 			return err;
 		}
-
+	}
+	
+	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO) {
 		/* create sysfs entries: */
 		err = snd_card_add_dev_attr(line6->card, &podhd_dev_attr_group);
 		if (err < 0)
@@ -350,7 +352,7 @@ static int podhd_init(struct usb_line6 *line6,
 			return err;
 	}
 
-	if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL)) {
+	if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO)) {
 		/* register USB audio system directly */
 		return podhd_startup_finalize(pod);
 	}
@@ -428,7 +430,7 @@ static const struct line6_properties podhd_properties_table[] = {
 	[LINE6_PODX3] = {
 		.id = "PODX3",
 		.name = "POD X3",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_CONTROL_INFO
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON | LINE6_CAP_IN_NEEDS_OUT,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
@@ -440,7 +442,7 @@ static const struct line6_properties podhd_properties_table[] = {
 	[LINE6_PODX3LIVE] = {
 		.id = "PODX3LIVE",
 		.name = "POD X3 LIVE",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_CONTROL_INFO
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON | LINE6_CAP_IN_NEEDS_OUT,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
-- 
2.7.4
