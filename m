From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH 3/3] aplay: Fix playback for small raw files
Date: Wed,  9 Aug 2017 01:06:00 +0300
Message-ID: <1502229960-8516-4-git-send-email-daniel.baluta@gmail.com>
References: <1502229960-8516-1-git-send-email-daniel.baluta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id CA491266E29
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 00:06:19 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id o33so3338227wrb.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Aug 2017 15:06:19 -0700 (PDT)
In-Reply-To: <1502229960-8516-1-git-send-email-daniel.baluta@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, alsa-devel@alsa-project.org
Cc: mihai.serban@nxp.com, shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>, Daniel Baluta <daniel.baluta@gmail.com>, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

This fixes a bug when trying to play files with size
smaller than maximum supported header size.

Lets have a look at the following example:

$ aplay -s 2 sample.raw

-> playback_go(fd = 10, loaded = 26, count = 2, name="sample.raw")
--> l = loaded = 26
--> c = count - written = 2
--> c -= l = 2 - 26 = -24
---> r = safe_read(fd, audiobuf + 26, -24)
---> r = -1, EXIT_FAILURE

In this case we have already 'loaded' from the input file more
bytes that we need to send to pcm device. So, we need to adjust
the number of bytes loaded and avoid reading a negative number
of bytes.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 aplay/aplay.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 28da6c5..0aa1688 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2774,6 +2774,13 @@ static void playback_go(int fd, size_t loaded, off64_t count, int rtype, char *n
 			c = count - written;
 			if (c > chunk_bytes)
 				c = chunk_bytes;
+
+			/* c < l, there is more data loaded
+			 * then we actually need to write
+			 */
+			if (c < l)
+				l = c;
+
 			c -= l;
 
 			if (c == 0)
-- 
2.7.4
