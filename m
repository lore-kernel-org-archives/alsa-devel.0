From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v3 11/12] ALSA: line6: Cleanup podhd
	initialization
Date: Fri, 16 Sep 2016 11:12:55 +0200
Message-ID: <1474017177-23769-12-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474017177-23769-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F3C266718
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 11:13:28 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id l132so1525002wmf.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 02:13:28 -0700 (PDT)
In-Reply-To: <1474017177-23769-1-git-send-email-dev@andree.sk>
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
