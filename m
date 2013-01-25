From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH - TINYCOMPRESS 2/4] compress: Return error when
	failing to allocate compress struct
Date: Fri, 25 Jan 2013 10:43:12 +0000
Message-ID: <1359110594-20163-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

diff --git a/compress.c b/compress.c
index 05e54ae..51455fc 100644
--- a/compress.c
+++ b/compress.c
@@ -207,8 +207,10 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	int rc;
 
 	compress = calloc(1, sizeof(struct compress));
-	if (!compress || !config)
+	if (!compress || !config) {
+		oops(&bad_compress, errno, "cannot allocate compress object");
 		return &bad_compress;
+	}
 
 	compress->config = config;
 
-- 
1.7.2.5
