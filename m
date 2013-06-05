From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [tinycompress][PATCH 1/2] compress: copy final version
	of config	struct
Date: Wed, 5 Jun 2013 13:10:41 +0100
Message-ID: <20130605121041.GB21556@opensource.wolfsonmicro.com>
References: <20130605120827.GA21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C51326545E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:10:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605120827.GA21556@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

compress_open() should delay taking a copy of the
config struct until we've finished modifying it.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compress.c b/compress.c
index 7f56c78..373de85 100644
--- a/compress.c
+++ b/compress.c
@@ -235,7 +235,6 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	compress->config = calloc(1, sizeof(*config));
 	if (!compress->config)
 		goto input_fail;
-	memcpy(compress->config, config, sizeof(*compress->config));
 
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
@@ -277,6 +276,8 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 		goto codec_fail;
 	}
 #endif
+
+	memcpy(compress->config, config, sizeof(*compress->config));
 	fill_compress_params(config, &params);
 
 	if (ioctl(compress->fd, SNDRV_COMPRESS_SET_PARAMS, &params)) {
-- 
1.7.2.5
