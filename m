From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-utils] [PATCH 1/3] aplay: Fix signal.h include
Date: Tue, 17 Jul 2012 15:45:33 +0530
Message-ID: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id EEE3C264F92
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:15:28 +0200 (CEST)
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

The correct header to include is <signal.h> not <sys/signal.h>.
---
 aplay/aplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 8462484..932497d 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -42,10 +42,10 @@
 #include <alsa/asoundlib.h>
 #include <assert.h>
 #include <termios.h>
+#include <signal.h>
 #include <sys/poll.h>
 #include <sys/uio.h>
 #include <sys/time.h>
-#include <sys/signal.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <endian.h>
-- 
1.7.8.6
