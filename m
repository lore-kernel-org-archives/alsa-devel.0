From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/12] bebob: Improve comments about stream
	format
Date: Wed, 28 May 2014 00:14:47 +0900
Message-ID: <1401203687-4189-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DD5826585F
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:21 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently bebob driver apply Raw Audio Data channel (in IEC 61883-1:2002,
Multi Bit Linear Audio Data channel in IEC 61883-6:20005) to IEC 60958
Conformant Data channel because both fireworks and bebob based devices
can handle it by ignoring each label.

This patch improves a comment about this.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 38aee33..514c7c9 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -760,7 +760,7 @@ parse_stream_formation(u8 *buf, unsigned int len,
 		format = buf[6 + e * 2];
 
 		switch (format) {
-		/* IEC 60958-3, currently handle as MBLA */
+		/* IEC 60958 Conformant, currently handled as MBLA */
 		case 0x00:
 		/* Multi bit linear audio */
 		case 0x06:	/* Raw */
-- 
1.8.3.2
