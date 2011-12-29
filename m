From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH] alsa: export compress headers
Date: Thu, 29 Dec 2011 18:42:31 +0530
Message-ID: <1325164351-18396-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 738162474E
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 14:12:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Export compress_offload.h and compress_params.h for userland to use

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/Kbuild |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/Kbuild b/include/sound/Kbuild
index 802947f..6df30ed 100644
--- a/include/sound/Kbuild
+++ b/include/sound/Kbuild
@@ -6,3 +6,5 @@ header-y += hdsp.h
 header-y += hdspm.h
 header-y += sb16_csp.h
 header-y += sfnt_info.h
+header-y += compress_params.h
+header-y += compress_offload.h
-- 
1.7.0.4
