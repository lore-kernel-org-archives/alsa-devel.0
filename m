From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH alsa-utils] speaker-test: increase the maximum
	supported rate to 384000
Date: Wed, 16 Jan 2013 17:06:04 +0100
Message-ID: <1358352364-28279-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

There are some devices around supporting this sample rate so let's make
speaker-test capable to deal with them.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 speaker-test/speaker-test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 3c89c38..de42a0c 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -999,7 +999,7 @@ int main(int argc, char *argv[]) {
     case 'r':
       rate = atoi(optarg);
       rate = rate < 4000 ? 4000 : rate;
-      rate = rate > 196000 ? 196000 : rate;
+      rate = rate > 384000 ? 384000 : rate;
       break;
     case 'c':
       channels = atoi(optarg);
-- 
1.7.10.4
