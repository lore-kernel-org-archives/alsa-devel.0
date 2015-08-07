From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 29/31] sound/oxfw: use kmemdup rather than duplicating its
 implementation
Date: Fri, 07 Aug 2015 09:59:35 +0200
Message-ID: <1438934377-4922-30-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 sound/firewire/oxfw/oxfw-stream.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 873d40f..77ad5b9 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -512,12 +512,11 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 	if (err < 0)
 		goto end;
 
-	formats[eid] = kmalloc(*len, GFP_KERNEL);
+	formats[eid] = kmemdup(buf, *len, GFP_KERNEL);
 	if (formats[eid] == NULL) {
 		err = -ENOMEM;
 		goto end;
 	}
-	memcpy(formats[eid], buf, *len);
 
 	/* apply the format for each available sampling rate */
 	for (i = 0; i < ARRAY_SIZE(oxfw_rate_table); i++) {
@@ -531,12 +530,11 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 			continue;
 
 		eid++;
-		formats[eid] = kmalloc(*len, GFP_KERNEL);
+		formats[eid] = kmemdup(buf, *len, GFP_KERNEL);
 		if (formats[eid] == NULL) {
 			err = -ENOMEM;
 			goto end;
 		}
-		memcpy(formats[eid], buf, *len);
 		formats[eid][2] = avc_stream_rate_table[i];
 	}
 
@@ -594,12 +592,11 @@ static int fill_stream_formats(struct snd_oxfw *oxfw,
 		if (err < 0)
 			break;
 
-		formats[eid] = kmalloc(len, GFP_KERNEL);
+		formats[eid] = kmemdup(buf, len, GFP_KERNEL);
 		if (formats[eid] == NULL) {
 			err = -ENOMEM;
 			break;
 		}
-		memcpy(formats[eid], buf, len);
 
 		/* get next entry */
 		len = AVC_GENERIC_FRAME_MAXIMUM_BYTES;
-- 
1.9.1
