From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH - TINYCOMPRESS 1/4] compress: Extend limit on
	error messages
Date: Fri, 25 Jan 2013 10:43:11 +0000
Message-ID: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
To: patch@alsa-project.org, vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

32 characters is a very short size for the error message, extend this
to 128 characters to prevent clipping on the majority of messages.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

diff --git a/compress.c b/compress.c
index faef982..05e54ae 100644
--- a/compress.c
+++ b/compress.c
@@ -75,7 +75,7 @@
 #include "sound/compress_offload.h"
 #include "tinycompress/tinycompress.h"
 
-#define COMPR_ERR_MAX 32
+#define COMPR_ERR_MAX 128
 
 struct compress {
 	int fd;
-- 
1.7.2.5
