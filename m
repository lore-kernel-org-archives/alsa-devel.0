From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompress: compress: use int for samples in
	compress_get_tstamp
Date: Mon, 17 Feb 2014 22:58:18 +0530
Message-ID: <1392658098-14227-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C447926086C
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 18:30:22 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

in 64bit updates we made the sample rate as 32bit explicitly, so update the
library API as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c                          |    2 +-
 include/tinycompress/tinycompress.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compress.c b/compress.c
index d1a2283..15dfdb7 100644
--- a/compress.c
+++ b/compress.c
@@ -333,7 +333,7 @@ int compress_get_hpointer(struct compress *compress,
 }
 
 int compress_get_tstamp(struct compress *compress,
-			unsigned long *samples, unsigned int *sampling_rate)
+			unsigned int *samples, unsigned int *sampling_rate)
 {
 	struct snd_compr_tstamp ktstamp;
 
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index e340cca..03c396f 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -125,7 +125,7 @@ int compress_get_hpointer(struct compress *compress,
  * @sampling_rate: sampling rate of decoded samples
  */
 int compress_get_tstamp(struct compress *compress,
-		unsigned long *samples, unsigned int *sampling_rate);
+		unsigned int *samples, unsigned int *sampling_rate);
 
 /*
  * compress_write: write data to the compress stream
-- 
1.7.0.4
