From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 4/14 v2] compress:
	Change	running from bitfield to plain int
Date: Fri, 22 Feb 2013 15:59:54 +0000
Message-ID: <20130222155954.GD21174@opensource.wolfsonmicro.com>
References: <20130210000806.GD31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D851B265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 16:59:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210000806.GD31139@opensource.wolfsonmicro.com>
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

---
 compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 3cd0f85..d09e161 100644
--- a/compress.c
+++ b/compress.c
@@ -82,7 +82,7 @@ struct compress {
 	unsigned int flags;
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
-	unsigned int running:1;
+	int running;
 };
 
 static int oops(struct compress *compress, int e, const char *fmt, ...)
-- 
1.7.2.5
