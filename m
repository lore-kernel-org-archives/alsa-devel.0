From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v3 10/12] ALSA: line6: Only determine control
	port properties if needed
Date: Fri, 16 Sep 2016 11:12:54 +0200
Message-ID: <1474017177-23769-11-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474017177-23769-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CD2A8266718
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 11:13:27 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id b184so2695325wma.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 02:13:27 -0700 (PDT)
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

Not all line6 devices use the control port.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 853a143..8a71d45 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -612,9 +612,8 @@ int line6_probe(struct usb_interface *interface,
 		goto error;
 	}
 
-	line6_get_interval(line6);
-
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
+		line6_get_interval(line6);
 		ret = line6_init_cap_control(line6);
 		if (ret < 0)
 			goto error;
-- 
1.9.1
