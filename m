From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] conf/ucm: rt5651: Fix HiFi file name
Date: Thu, 26 Oct 2017 16:05:01 +0100
Message-ID: <20171026150501.24631-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D9A266AF8
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 17:05:08 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id l1so3506933wrc.3
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 08:05:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

The conf HiFi file name is HiFi.conf, fix the name in the main
configuration file.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index 2dcc72cc..60798ce7 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -1,7 +1,7 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
 SectionUseCase."HiFi" {
-	File "HiFi"
+	File "HiFi.conf"
 	Comment "Play HiFi quality Music"
 }
 
-- 
2.14.2
