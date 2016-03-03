From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 5/5] Remove unnecessary includes.
Date: Thu,  3 Mar 2016 15:08:04 +0100
Message-ID: <1457014084-27694-5-git-send-email-tk@giga.or.at>
References: <1457014084-27694-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe03-2.mx.upcmail.net
 (vie01a-dmta-pe03-2.mx.upcmail.net [62.179.121.161])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCAB2606B8
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:08:50 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe03.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abTvu-0004t4-Lj
 for alsa-devel@alsa-project.org; Thu, 03 Mar 2016 15:08:50 +0100
In-Reply-To: <1457014084-27694-1-git-send-email-tk@giga.or.at>
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
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

Headers are already included in local.h.
---
 src/topology/tplg_local.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index e66d7f4..5d0cb91 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -13,8 +13,6 @@
 #include <limits.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <endian.h>
-#include <linux/types.h>
 
 #include "local.h"
 #include "list.h"
-- 
2.7.1
