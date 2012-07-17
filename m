From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-lib] [PATCH 3/4] ucm: Add missing pthread.h
	include
Date: Tue, 17 Jul 2012 15:30:16 +0530
Message-ID: <1342519217-3668-4-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 6332B264F91
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:02:05 +0200 (CEST)
In-Reply-To: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Needed for the use of pthread_mutex_t

Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
---
 src/ucm/ucm_local.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 03d3ace..87f14a2 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -36,6 +36,7 @@
 #define UC_MGR_DEBUG
 #endif
 
+#include <pthread.h>
 #include "local.h"
 #include "use-case.h"
 
-- 
1.7.8.6
