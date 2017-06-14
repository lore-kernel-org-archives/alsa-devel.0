From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: disable alsa-lib topology debug
	output by default.
Date: Wed, 14 Jun 2017 12:37:40 +0100
Message-ID: <1497440260-28334-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1497440260-28334-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 037C626725C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 13:37:57 +0200 (CEST)
In-Reply-To: <1497440260-28334-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/tplg_local.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 42e3201..60af017 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -22,7 +22,6 @@
 #include <sound/asoc.h>
 #include <sound/tlv.h>
 
-#define TPLG_DEBUG
 #ifdef TPLG_DEBUG
 #define tplg_dbg SNDERR
 #else
-- 
1.9.1
