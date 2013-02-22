From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 3/14 v2] compress:
	Remove	unused buffer_size member from struct compress
Date: Fri, 22 Feb 2013 15:58:32 +0000
Message-ID: <20130222155832.GC21174@opensource.wolfsonmicro.com>
References: <20130210000645.GC31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A8D8265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 16:58:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210000645.GC31139@opensource.wolfsonmicro.com>
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

---
 compress.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 5429754..3cd0f85 100644
--- a/compress.c
+++ b/compress.c
@@ -80,7 +80,6 @@
 struct compress {
 	int fd;
 	unsigned int flags;
-	__u64 buffer_size;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
 	unsigned int running:1;
-- 
1.7.2.5
