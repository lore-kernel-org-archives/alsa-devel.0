From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] speaker-test: Allow sampling rates up to 768000
Date: Thu,  7 Jun 2018 11:10:55 +0200
Message-ID: <20180607091055.27404-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 18423266E76
 for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2018 11:11:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

There are audio devices around that support up to 768kHz playback, allow
testing them by increasing the maximum supported sampling rate.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 speaker-test/speaker-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 0cdecb3..773af0a 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -1034,7 +1034,7 @@ int main(int argc, char *argv[]) {
     case 'r':
       rate = atoi(optarg);
       rate = rate < 4000 ? 4000 : rate;
-      rate = rate > 384000 ? 384000 : rate;
+      rate = rate > 768000 ? 768000 : rate;
       break;
     case 'c':
       channels = atoi(optarg);
-- 
2.17.0
