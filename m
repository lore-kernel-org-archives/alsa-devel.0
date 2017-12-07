From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] alsa-utils: aplay: Adjust sample rate limits
	to support newer hardware
Date: Thu,  7 Dec 2017 13:57:14 +0200
Message-ID: <1512647834-24554-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 060322670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 12:57:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel@alsa-project.org
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

There are number of devices that support up to 384 kHz sampling rate and
some devices up to 768 kHz sampling rate. This patch increases sanity
check limit to 768k in order to support testing of such hardware.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 aplay/aplay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index dbae17c..6b740c2 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -635,10 +635,10 @@ int main(int argc, char *argv[])
 				error(_("invalid rate argument '%s'"), optarg);
 				return 1;
 			}
-			if (tmp < 300)
+			if (tmp < 1000)
 				tmp *= 1000;
 			rhwparams.rate = tmp;
-			if (tmp < 2000 || tmp > 192000) {
+			if (tmp < 2000 || tmp > 768000) {
 				error(_("bad speed value %i"), tmp);
 				return 1;
 			}
-- 
2.7.4
