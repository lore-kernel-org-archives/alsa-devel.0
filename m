From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 4/14] compress: Change running
	from bitfield	to plain int
Date: Sun, 10 Feb 2013 00:08:06 +0000
Message-ID: <20130210000806.GD31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 652822615F2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:08:08 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Declaring running as a single-bit bitfield does not save any space
or give any coding advantages, but does leave potential opportunities
for the compiler to be inefficient in how it handles bitfields compared
to how it would handle a machine int.

diff --git a/compress.c b/compress.c
index fa2d43f..c4f215c 100644
--- a/compress.c
+++ b/compress.c
@@ -82,7 +82,7 @@ struct compress {
 	unsigned int flags;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
-	int running:1;
+	int running;
 };
 
 static int oops(struct compress *compress, int e, const char *fmt, ...)
-- 
1.7.2.5
