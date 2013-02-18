From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] compress: fix arithmetic exception in
	compress_get_hpointer
Date: Mon, 18 Feb 2013 19:45:15 +0530
Message-ID: <1361196915-12121-4-git-send-email-vinod.koul@intel.com>
References: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B1679265099
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 15:16:05 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Xuemin Su <xuemin.su@intel.com>, He Bo <bo.he@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Xuemin Su <xuemin.su@intel.com>

In compress_get_hpointer, check for invalid sample
rate to prevent devide-by-zero exceptions

Signed-off-by: Xuemin Su <xuemin.su@intel.com>
Signed-off-by: He Bo <bo.he@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compress.c b/compress.c
index b035e4a..27c03d9 100644
--- a/compress.c
+++ b/compress.c
@@ -286,6 +286,8 @@ int compress_get_hpointer(struct compress *compress,
 
 	if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &kavail))
 		return oops(compress, errno, "cannot get avail");
+	if (0 == kavail.tstamp.sampling_rate)
+		return oops(compress, errno, "invalid paramter");
 	*avail = (unsigned int)kavail.avail;
 	time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
 	tstamp->tv_sec = time;
-- 
1.7.0.4
