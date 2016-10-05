From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH] ALSA: line6: Fix POD X3 Live audio input
Date: Wed,  5 Oct 2016 17:46:09 +0200
Message-ID: <1475682369-5084-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B5DD0261740
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:46:16 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id b184so25185821wma.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2016 08:46:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org, eddi@depieri.net
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

The commit c039aaa77a7d1d9375665a8b59ec16dc7d23e259 was incomplete,
missing part of the setup for Live. This makes also audio input work,
in addition to audio output.

Signed-off-by: Andrej Krutak <dev@andree.sk>
Reported-by: Eddi De Pieri <eddi@depieri.net>
Fixes: c039aaa77a7d1d9375665a8b59ec16dc7d23e259
---
 sound/usb/line6/podhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 193eb29..ac40525 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -317,7 +317,8 @@ static int podhd_init(struct usb_line6 *line6,
 	if (pod->line6.properties->capabilities & LINE6_CAP_PCM) {
 		/* initialize PCM subsystem: */
 		err = line6_init_pcm(line6,
-			(id->driver_info == LINE6_PODX3) ? &podx3_pcm_properties :
+			(id->driver_info == LINE6_PODX3 ||
+			id->driver_info == LINE6_PODX3LIVE) ? &podx3_pcm_properties :
 			&podhd_pcm_properties);
 		if (err < 0)
 			return err;
-- 
2.7.4
