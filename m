From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] alsa-info.sh: include 1 line of dmesg context
Date: Sat, 18 Jul 2009 10:28:13 +0800
Message-ID: <20090718022812.GA10524@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 054232449F
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jul 2009 04:28:22 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So as to include possible ALSA messages without the common keywords,
as well as be more confident on the completeness/coverage of the report. 

It also shows nice '--' separators between the dmesg ranges.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -247,7 +247,7 @@ withdmesg() {
 	echo "!!ALSA/HDA dmesg" >> $FILE
 	echo "!!------------------" >> $FILE
 	echo "" >> $FILE
-	dmesg | grep -E 'ALSA|HDA|HDMI|sound|hda.codec|hda.intel' >> $FILE
+	dmesg | grep -C1 -E 'ALSA|HDA|HDMI|sound|hda.codec|hda.intel' >> $FILE
 	echo "" >> $FILE
 	echo "" >> $FILE
 }
