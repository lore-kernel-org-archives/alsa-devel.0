From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 3/14] compress: Remove unused
	buffer_size	member from struct compress
Date: Sun, 10 Feb 2013 00:06:45 +0000
Message-ID: <20130210000645.GC31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76A712615F2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:06:47 +0100 (CET)
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

diff --git a/compress.c b/compress.c
index ee11988..fa2d43f 100644
--- a/compress.c
+++ b/compress.c
@@ -80,7 +80,6 @@
 struct compress {
 	int fd;
 	unsigned int flags;
-	__u64 buffer_size;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
 	int running:1;
-- 
1.7.2.5
