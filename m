From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 11/12] ALSA: line6: Cleanup podhd
	initialization
Date: Sun, 18 Sep 2016 20:59:31 +0200
Message-ID: <1474225172-32081-12-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A49126680E
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:58 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id l132so10516414wmf.1
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:58 -0700 (PDT)
In-Reply-To: <1474225172-32081-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Only initialize PCM for POD HD devices that support it.
No POD HD seems to support MIDI, thus drop the initialization.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/podhd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 8246ea5..193eb29 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -314,17 +314,14 @@ static int podhd_init(struct usb_line6 *line6,
 			return err;
 	}
 
-	/* initialize MIDI subsystem: */
-	err = line6_init_midi(line6);
-	if (err < 0)
-		return err;
-
-	/* initialize PCM subsystem: */
-	err = line6_init_pcm(line6,
-		(id->driver_info == LINE6_PODX3) ? &podx3_pcm_properties :
-		&podhd_pcm_properties);
-	if (err < 0)
-		return err;
+	if (pod->line6.properties->capabilities & LINE6_CAP_PCM) {
+		/* initialize PCM subsystem: */
+		err = line6_init_pcm(line6,
+			(id->driver_info == LINE6_PODX3) ? &podx3_pcm_properties :
+			&podhd_pcm_properties);
+		if (err < 0)
+			return err;
+	}
 
 	if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL)) {
 		/* register USB audio system directly */
-- 
1.9.1
