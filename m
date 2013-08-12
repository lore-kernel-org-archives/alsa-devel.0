From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: update the MAINTAINER entry
Date: Mon, 12 Aug 2013 11:15:27 +0530
Message-ID: <1376286327-17460-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 61ADD2602F2
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 08:27:20 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

add missing uapi/ headers and Documentation files

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a870e..a40e393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7667,7 +7667,9 @@ M:	Vinod Koul <vinod.koul@intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Supported
+F:	Documentation/sound/alsa/compress_offload.txt
 F:	include/sound/compress_driver.h
+F:	include/uapi/sound/compress_*
 F:	sound/core/compress_offload.c
 F:	sound/soc/soc-compress.c
 
-- 
1.7.0.4
