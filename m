From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] conf/ucm: rt5651: Add missing cdev
Date: Wed,  8 Nov 2017 12:33:29 +0000
Message-ID: <20171108123330.12102-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FFF0266D45
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 13:33:39 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id n89so1618034pfk.11
 for <alsa-devel@alsa-project.org>; Wed, 08 Nov 2017 04:33:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index b9da30f7..8ded2d52 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -7,6 +7,7 @@ SectionVerb {
 	]
 
 	DisableSequence [
+		cdev "hw:bytcrrt5651"
 		exec "echo HiFi disable sequence"
 	]
 
-- 
2.14.2
