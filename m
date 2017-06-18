From: Alexander Tsoy <alexander@tsoy.me>
Subject: [PATCH alsa-lib 1/2] USB-Audio: fix dsnoop args for
	Audiophile USB card
Date: Sun, 18 Jun 2017 23:23:02 +0300
Message-ID: <20170618202303.29269-1-alexander@tsoy.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from puleglot.ru (puleglot.ru [78.47.112.147])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D32266C25
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 22:23:07 +0200 (CEST)
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Fixes: a9b129955659 ("USB-Audio.conf: fix definition for M-Audio AudioP...")
Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 src/conf/cards/USB-Audio.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index e365f297..f72ef121 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -90,7 +90,7 @@ USB-Audio."Audiophile USB (tm)".pcm.default {
 		type plug
 		slave.pcm {
 			@func concat
-			strings [ "dsnoop:DEVICE=1,CARD=" $CARD ]
+			strings [ "dsnoop:DEV=1,CARD=" $CARD ]
 		}
 	}
 }
-- 
2.13.0
