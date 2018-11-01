From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH alsa-utils] topology/topology.c: drop unneeded
	<dlfcn.h> include
Date: Thu,  1 Nov 2018 15:17:47 +0100
Message-ID: <20181101141747.31602-1-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F4062677E4
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 15:17:49 +0100 (CET)
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: alsa-devel@alsa-project.org

This include is not used/needed and prevents building on systems that
don't provide <dlfcn.h>.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 topology/topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/topology/topology.c b/topology/topology.c
index 097c255..b72e341 100644
--- a/topology/topology.c
+++ b/topology/topology.c
@@ -27,7 +27,6 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/stat.h>
-#include <dlfcn.h>
 #include <getopt.h>
 #include <assert.h>
 
-- 
2.14.4
