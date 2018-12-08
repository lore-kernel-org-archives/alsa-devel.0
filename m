From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 1/7] doc: Fix typo in AAF doc
Date: Fri,  7 Dec 2018 17:55:44 -0800
Message-ID: <20181208015550.20268-2-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC41267D2F
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:22 +0100 (CET)
In-Reply-To: <20181208015550.20268-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch fixes a typo in aaf.txt documentation.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 doc/aaf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/aaf.txt b/doc/aaf.txt
index 58d9c02..cae86d8 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -47,7 +47,7 @@ Enable TAI offset to be automatically set by phc2sys:
 		clockClass 248 clockAccuracy 0xfe \
 		offsetScaledLogVariance 0xffff \
 		currentUtcOffset 37 leap61 0 leap59 0 \
-		currentUtcOffsetValid 1 p pTimescale 1 \
+		currentUtcOffsetValid 1 pTimescale 1 \
 		timeTraceable 1 frequencyTraceable 0 timeSource 0xa0'
 
 Synchronize system clock with PTP clock:
-- 
2.19.1
