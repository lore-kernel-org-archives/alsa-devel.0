From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] aoa i2sbus: don't overwrite module parameter
Date: Thu, 23 Oct 2008 13:57:39 +0200
Message-ID: <1224763060.6569.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id AFB861038E6
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:18:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We shouldn't modify a global variable here.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 sound/aoa/soundbus/i2sbus/i2sbus-core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- everything.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2008-10-23 13:55:14.000000000 +0200
+++ everything/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2008-10-23 13:55:33.000000000 +0200
@@ -159,7 +159,7 @@ static int i2sbus_add_dev(struct macio_d
 	struct i2sbus_dev *dev;
 	struct device_node *child = NULL, *sound = NULL;
 	struct resource *r;
-	int i, layout = 0, rlen;
+	int i, layout = 0, rlen, ok = force;
 	static const char *rnames[] = { "i2sbus: %s (control)",
 					"i2sbus: %s (tx)",
 					"i2sbus: %s (rx)" };
@@ -192,7 +192,7 @@ static int i2sbus_add_dev(struct macio_d
 			layout = *layout_id;
 			snprintf(dev->sound.modalias, 32,
 				 "sound-layout-%d", layout);
-			force = 1;
+			ok = 1;
 		}
 	}
 	/* for the time being, until we can handle non-layout-id
@@ -201,7 +201,7 @@ static int i2sbus_add_dev(struct macio_d
 	 * When there are two i2s busses and only one has a layout-id,
 	 * then this depends on the order, but that isn't important
 	 * either as the second one in that case is just a modem. */
-	if (!force) {
+	if (!ok) {
 		kfree(dev);
 		return -ENODEV;
 	}
