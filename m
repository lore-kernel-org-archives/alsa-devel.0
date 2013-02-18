From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] compress: remove unused variables
Date: Mon, 18 Feb 2013 19:45:13 +0530
Message-ID: <1361196915-12121-2-git-send-email-vinod.koul@intel.com>
References: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA14265083
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 15:16:02 +0100 (CET)
In-Reply-To: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
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

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/compress.c b/compress.c
index a8964f4..d98517d 100644
--- a/compress.c
+++ b/compress.c
@@ -204,7 +204,6 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	struct compress *compress;
 	struct snd_compr_params params;
 	char fn[256];
-	int rc;
 
 	compress = calloc(1, sizeof(struct compress));
 	if (!compress || !config) {
@@ -397,12 +396,10 @@ int compress_drain(struct compress *compress)
 bool is_codec_supported(unsigned int card, unsigned int device,
 		unsigned int flags, struct snd_codec *codec)
 {
-	struct snd_compr_params params;
 	unsigned int dev_flag;
 	bool ret;
 	int fd;
 	char fn[256];
-	int rc;
 
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
-- 
1.7.0.4
