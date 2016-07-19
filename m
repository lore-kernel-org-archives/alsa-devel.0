From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] alsabat: make snr_is_valid static
Date: Tue, 19 Jul 2016 14:35:09 +0530
Message-ID: <1468919109-28287-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7117E26739C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 10:58:03 +0200 (CEST)
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
Cc: tiwai@suse.de, han.lu@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The compilation fails due to multiple defination of snr_is_valid

common.o: In function `snr_is_valid':
bat/common.h:99: multiple definition of `snr_is_valid'
bat.o:bat/common.h:99: first defined here

signal.o: In function `snr_is_valid':
bat/common.h:99: multiple definition of `snr_is_valid'
bat.o:bat/common.h:99: first defined here

latencytest.o: In function `snr_is_valid':
bat/common.h:99: multiple definition of `snr_is_valid'
bat.o:bat/common.h:99: first defined here

analyze.o: In function `snr_is_valid':
bat/common.h:99: multiple definition of `snr_is_valid'
bat.o:bat/common.h:99: first defined here

alsa.o: In function `snr_is_valid':
bat/common.h:99: multiple definition of `snr_is_valid'
bat.o:bat/common.h:99: first defined here

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 bat/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat/common.h b/bat/common.h
index db49868a419a..1b07fbeb7755 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -94,7 +94,7 @@
 #define SNR_DB_MIN			0.0
 #define SNR_DB_MAX			200.0
 
-inline bool snr_is_valid(float db)
+static inline bool snr_is_valid(float db)
 {
 	return (db > SNR_DB_MIN && db < SNR_DB_MAX);
 }
-- 
1.9.1
